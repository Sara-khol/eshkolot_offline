import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eshkolot_offline/models/course.dart';
import 'package:eshkolot_offline/models/videoIsar.dart';
import 'package:flutter/cupertino.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../models/vimoe_download.dart';
import 'package:collection/src/iterable_extensions.dart';
import '../utils/common_funcs.dart';
import 'isar_service.dart';
import 'network_check.dart';

class VimoeService with ChangeNotifier {
  String token = '1234e6802e12410d1130b9fa774d4cd0'; //privet video files

  int projectId = 0; //english
  int courseId = 0; //english
  Dio dio = Dio();
  Dio dioDownload = Dio();
  List<VimoeVideo> videoList = [];
  List<VideoIsar> isarVideoList = [];
  List<String> quizLinks = [];
  int numDownloadFiles = 0;
  late DownloadStatus downloadStatus, lastDownLoadStatus;
  late String currentLink;
  List<String> blockLinks = [];
  List<String> errorLinks = [];
  int errorTries = 0;
  List<Course> courses = [];
  int numOfAllVideos = 0;
  CancelToken cancelToken = CancelToken();
  late String path;
  bool finishConnectToVimoe = false;
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  late bool isNetWorkConnection;
  bool isDispose = false;
  late StreamSubscription subscription;
  Timer? timer;
  int captureMessageNum = 1;

  // final transaction = Sentry.startTransaction(
  //   'dio-download',
  //   'download',
  //   bindToScope: true,
  // );

  tryAgainFromStart() async {
    debugPrint("timer finished ,sending data");
    Sentry.addBreadcrumb(Breadcrumb(
        message: 'videos id that were not downloaded:\n'
            '${getAllNotDownloaded().map((v) => v.id).toList()}'));
    //  await transaction.finish();
    if (captureMessageNum < 2) {
      await Sentry.captureMessage(
          'my downloading data timeout error trying again $captureMessageNum');
      debugPrint(
          'my downloading data timeout error trying again $captureMessageNum');

      //await IsarService().clearVideoIsar();
      // isarVideoList.clear();
      // videoList.clear();

      // try {
      cancelToken.cancel('wwwwwww');
      /*} catch (e) {
        print('errorrrrrrr ${e.toString()}');
        if (e.toString() == 'The request was cancelled') {
          print('ooo');
        }
      }*/
      cancelToken = CancelToken();

      startDownLoading();
    } else {
      await Sentry.addBreadcrumb(
          Breadcrumb(message: 'tried twice from start, display problem'));
      await Sentry.captureMessage(
          'my downloading data timeout error tried twice display error $captureMessageNum');
      debugPrint(
          'my downloading data timeout error tried twice display error $captureMessageNum');

      captureMessageNum = 0;
      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
      videoList.clear();
      cancelToken.cancel('wwwwwww');
      downloadStatus = DownloadStatus.error;
      notifyListeners();
    }
    captureMessageNum++;
  }

  VimoeService() {
    debugPrint("VimoeService");

    dio.options.headers['content-Type'] = 'application/json;charset=UTF-8';
    dio.options.headers['authorization'] = "bearer $token";
    dio.options.headers['Connection'] = "keep-alive";

    _networkConnectivity.whileDownloading = true;
    //_networkConnectivity.initialise();

    subscription = _networkConnectivity.myStream.listen((source) async {
      _source = source;
      debugPrint('source222 $_source');
      if (_source.keys.toList()[0] == ConnectivityResult.none) {
        // if (downloadStatus != DownloadStatus.netWorkError) {
        if (timer != null && timer!.isActive) {
          timer!.cancel();
        }
        isNetWorkConnection = false;
        downloadStatus = DownloadStatus.netWorkError;
        notifyListeners();
        cancelToken.cancel('wwwwwww');
        if (finishConnectToVimoe) {
          debugPrint('no connection so cancel downloading');
          Sentry.addBreadcrumb(
              Breadcrumb(message: 'no connection so cancel downloading'));
        } else {
          debugPrint('no connection so cancel vimeo connection');
        }
        // }
      } else {
        // if (downloadStatus == DownloadStatus.netWorkError) {
        downloadStatus = lastDownLoadStatus;
        notifyListeners();
        isNetWorkConnection = true;
        //if in middle to download videos
        if (finishConnectToVimoe) {
          debugPrint('jjjj ${getAllDownloaded().map((v) => v.id)}');
          debugPrint('jjjj ${getAllDownloaded().length}');

          debugPrint('aaaaagain');
          if (cancelToken.isCancelled) {
            cancelToken = CancelToken();
          }
          startDownLoading(wasNetWorkProblem: true);
        } else {
          debugPrint('start');
          start();
        }
        //}
      }
    });

    InterceptorsWrapper interceptorsWrapper = InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint("::: Api Url : ${options.uri}");
        //debugPrint("::: Api header : ${options.headers}");
        isarVideoList
            .firstWhereOrNull((iv) => iv.downloadLink == options.path)
            ?.requestOptions = options;

        return handler.next(options);
        // super.onRequest(options, handler);
      },
      // onResponse: (response, handler) {
      //   // debugPrint("::: response : ${response.data.toString()}");
      //   return handler.next(response);
      // },
      onError: (error, handler) async {
        String url = error.requestOptions.path;
        String start = 'download/';

        // String start = 'playback/';

        final startIndex = url.indexOf(start);
        final endIndex = url.indexOf('/', startIndex + start.length);
        String vimoeId = url.substring(startIndex + start.length, endIndex);
        // debugPrint('updateIsarVideoError $vimoeId');
        // IsarService().updateIsarVideoError(int.parse(vimoeId));
        if (error.response?.statusCode == 418) {
          // String url = error.requestOptions.path;
          // // String start = 'download/';
          // String start = 'playback/';
          // final startIndex = url.indexOf(start);
          // final endIndex = url.indexOf('/', startIndex + start.length);
          // String vimoeId = url.substring(startIndex + start.length, endIndex);
          blockLinks.add('https://vimeo.com/$vimoeId');

          debugPrint('block $vimoeId');
          Sentry.addBreadcrumb(Breadcrumb(message: 'block $vimoeId'));

          //   transaction.throwable = error;
          // transaction.status = const SpanStatus.internalError();
        }
        /*else if (error.message == 'The request was cancelled') {
          debugPrint('hhh');
        } */
        else {
          debugPrint('my error $error $vimoeId');
          Sentry.addBreadcrumb(
              Breadcrumb(message: 'my error $error $vimoeId'));

          // if(error.error is SocketException) {
          //   debugPrint('SocketException');
          errorLinks.add(error.requestOptions.path);
        }
        checkErrors();
        handler.reject(
            error); // Added this line to let error propagate outside the interceptor
      },
    );

    InterceptorsWrapper interceptorsWrapper1 = InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint("::: Api Url : ${options.uri}");
        // //debugPrint("::: Api header : ${options.headers}");
        // isarVideoList.firstWhereOrNull((iv) => iv.downloadLink == options.path)
        //     ?.requestOptions = options;

        return handler.next(options);
        // super.onRequest(options, handler);
      },

      // onError: (error, handler) async {
      //   String url = error.requestOptions.path;
      //   String start = 'download/';
      //
      //   // String start = 'playback/';
      //
      //   final startIndex = url.indexOf(start);
      //   final endIndex = url.indexOf('/', startIndex + start.length);
      //   String vimoeId = url.substring(startIndex + start.length, endIndex);
      //   if (error.response?.statusCode == 418) {
      //     // String url = error.requestOptions.path;
      //     // // String start = 'download/';
      //     // String start = 'playback/';
      //     // final startIndex = url.indexOf(start);
      //     // final endIndex = url.indexOf('/', startIndex + start.length);
      //     // String vimoeId = url.substring(startIndex + start.length, endIndex);
      //     blockLinks.add('https://vimeo.com/$vimoeId');
      //     debugPrint('block $vimoeId');
      //     Sentry.addBreadcrumb(Breadcrumb(message: 'block $vimoeId'));
      //
      //     //   transaction.throwable = error;
      //     // transaction.status = const SpanStatus.internalError();
      //   }
      //   /*else if (error.message == 'The request was cancelled') {
      //     debugPrint('hhh');
      //   } */
      //   else {
      //     debugPrint('my error ${error} $vimoeId');
      //     Sentry.addBreadcrumb(
      //         Breadcrumb(message: 'my error ${error} $vimoeId'));
      //
      //     // if(error.error is SocketException) {
      //     //   debugPrint('SocketException');
      //     errorLinks.add(error.requestOptions.path);
      //   }
      //
      //   handler.reject(
      //       error); // Added this line to let error propagate outside the interceptor
      // },
    );

    dio.interceptors.add(interceptorsWrapper1);
    dioDownload.interceptors.add(interceptorsWrapper);
    dio.addSentry();
    dioDownload.addSentry();
  }

  start({bool notify = false, oldLinks = false}) async {
    debugPrint('kkk');
    if (isNetWorkConnection) {
      downloadStatus = DownloadStatus.downloading;
      lastDownLoadStatus = DownloadStatus.downloading;
      numOfAllVideos = 0;
      numDownloadFiles = 0;
      blockLinks = [];
      errorLinks = [];
      videoList.clear();

      finishConnectToVimoe = false;

      if (cancelToken.isCancelled) {
        cancelToken = CancelToken();
      }
      if (!oldLinks) {
        debugPrint('isarVideoList clear');
        isarVideoList.clear();
      }


      if (notify) notifyListeners();
      // if (courses.isEmpty) {
      //   courses = await IsarService().getAllCourses();
      // }
      for (Course course in courses) {
        if(isNetWorkConnection) {
          debugPrint('ggg ${course.title}');
          // if (course.serverId > 1000) {
          // if (course.id == 2567060) {
          //todo
          // projectId = course.id == 69 ? 2651706 : int.parse(course.vimeoId);
          projectId =
          course.vimeoId != '' ? int.parse(course.vimeoId) : 10390152;
          courseId = course.id;
          // projectId = course.vimeoId;
          await connectToVimoe();
        }
        // }
      }
      //todo
      // if ((courses.length > 1) ||
      //     (numOfAllVideos == 0 && courses.length == 1)) {
      if (isNetWorkConnection) next();
      // } else {
      //   debugPrint('?????');
      // }
    } else {
      downloadStatus = DownloadStatus.netWorkError;
      lastDownLoadStatus = DownloadStatus.netWorkError;
      debugPrint('no network');
    }
  }

  connectToVimoe({String url = '', bool notify = false}) async {
    debugPrint('idddddd $projectId');
    downloadStatus = DownloadStatus.downloading;
    if (notify) notifyListeners();

    url = url == ''
        ? 'https://api.vimeo.com/me/projects/$projectId/videos'
            '?fields=uri,link,download.link,download.size_short,download.height,'
            'download.width,download.rendition,download.quality'
        : 'https://api.vimeo.com$url';

    // url = url == ''
    //     ? 'https://api.vimeo.com/me/projects/${projectId}/videos'
    //         '?fields=uri,link,files.link,files.size_short,files.height,'
    //         'files.width,files.rendition,files.quality'
    //     : 'https://api.vimeo.com${url}';

    try {
      Response response = await dio.get(url, cancelToken: cancelToken);

      // transaction.status =
      //     SpanStatus.fromHttpStatusCode(response.statusCode ?? -1);

      Map result = response.data;
      debugPrint('courseId $courseId');

//       List<VimoeVideo> newVideos = result['data']
//           .map<VimoeVideo>((entry) => (VimoeVideo.fromJson(entry, courseId)))
//           .toList();
//
// // Iterate through newVideos and add only if they don't already exist in videoList
//       for (var video in newVideos) {
//         bool videoExists = videoList.any((existingVideo) => existingVideo.uri == video.uri);
//         if (!videoExists) {
//           videoList.add(video);
//         }
//       }

      videoList.addAll(result['data']
          .map<VimoeVideo>((entry) => (VimoeVideo.fromJson(entry, courseId)))
          .toList());

      if (result['paging']['next'] != null) {
        await connectToVimoe(url: result['paging']['next']);
      }
    } catch (exception) {
      // transaction.throwable = exception;
      // transaction.status = const SpanStatus.internalError();
    }
  }

  next() async {
    // numOfAllVideos = videoList.length;
    numOfAllVideos = videoList.length+isarVideoList.length;

    debugPrint('numOfAllVideos $numOfAllVideos');
    Sentry.addBreadcrumb(Breadcrumb(message: 'numOfAllVideos $numOfAllVideos'));
    finishConnectToVimoe = true;

    setTimer();

    //todo check if needed
    //todo change when adding new course , can delete all other videos of older courses
    //todo maybe add a file for every course videos
    try {
      await deleteFilesInDirectoryBeforeDownloading();
    } catch (e) {
      debugPrint('can not delete files');
      Sentry.addBreadcrumb(Breadcrumb(message: 'can not delete files'));
    }
    //bool setExpiredDate=false;
    // int expiredDate=-1;

    if(isarVideoList.isNotEmpty)
    {
      debugPrint('old links');
      for(VideoIsar videoIsar in isarVideoList)
      {
        downloadFile(videoIsar.downloadLink, videoIsar.name, videoIsar.courseId);
      }
    }
    for (VimoeVideo v in videoList) {
      //todo change???
      // VimoeFile? download =
      //     v.files.firstWhereOrNull((d) => d.rendition == '540p');
      VimoeDownload? download =
          v.download.firstWhereOrNull((d) => d.rendition == '540p');
      currentLink = v.link;
      download ??= v.download.first;
      if (download.rendition != '540p') {
        debugPrint('fff ${download.rendition}');
        debugPrint('fff ${download.link}');
      }
      //not sepouse to be null
      if (/*download != null &&*/ download.link != null) {
        //i++;
        String name = v.uri.substring(v.uri.lastIndexOf('/'), v.uri.length);
        isarVideoList.add(VideoIsar()
          ..id = int.parse(name.substring(1))
          ..courseId = v.courseId
          ..downloadLink = download.link!
          ..name = name);
        // if(expiredDate==-1) {
        //   expiredDate = extractExpiryTimestamp(download.link!);
        // }
        //debugPrint('name id ${name.substring(1)} $i');

        await IsarService().addIsarVideo(VideoIsar()
          ..id = int.parse(name.substring(1))
          ..courseId = v.courseId
          ..downloadLink = download.link!
          ..expiredDate = extractExpiryTimestamp(download.link!)
          ..name = name);

        /*await*/
        downloadFile(download.link!, name, v.courseId);
      } else {
        debugPrint('hhh ??');
      }
    }
  }

  int extractExpiryTimestamp(String link) {
    Uri uri = Uri.parse(link);
    String? expiresParam = uri.queryParameters['expires'] ?? '';

    return expiresParam != '' ? int.parse(expiresParam) : -1;
  }

  startDownLoading(
      {bool wasNetWorkProblem = false, bool notify = false}) async {
    if (isNetWorkConnection) {
      debugPrint('startDownLoading');
      downloadStatus = DownloadStatus.downloading;
      lastDownLoadStatus = DownloadStatus.downloading;
      if (notify) notifyListeners();

      if (cancelToken.isCancelled) {
        cancelToken = CancelToken();
      }

      numDownloadFiles = 0;
      blockLinks = [];
      errorLinks = [];
      isarVideoList.removeWhere((item) => item.isDownload == true);

      numOfAllVideos = isarVideoList.length;
      debugPrint('numOfAllVideos $numOfAllVideos');
      Sentry.addBreadcrumb(
          Breadcrumb(message: 'numOfAllVideos $numOfAllVideos'));

      if (numOfAllVideos == 0) {
        downloadStatus = DownloadStatus.downloaded;
        notifyListeners();
      } else {
        setTimer();

        for (VideoIsar v in isarVideoList) {
          if (wasNetWorkProblem) {
            // debugPrint('awaittttttttt');
            await downloadFile(v.downloadLink, v.name, v.courseId);
          } else {
            // debugPrint('nooo await');
            downloadFile(v.downloadLink, v.name, v.courseId);
          }
        }
      }
    } else {
      downloadStatus = DownloadStatus.netWorkError;
      lastDownLoadStatus = DownloadStatus.netWorkError;
      if (notify) notifyListeners();
      debugPrint('no network');
      Sentry.addBreadcrumb(Breadcrumb(message: 'no network'));
    }
  }

  Future<void> downloadFile(
      String url, String name, int courseId) async {
    String progress = '';
    //var dir = await getApplicationSupportDirectory(); //C:\Users\USER\AppData\Roaming\GoApp\eshkolot_offline
    var dir = await CommonFuncs().getEshkolotWorkingDirectory(); //C:\Users\USER\AppData\Roaming\GoApp\eshkolot_offline
    await dioDownload.download(
      url,
      cancelToken: cancelToken,
      // '${dir.path}/videos$name.mp4',
      '${dir.path}/lessons/$courseId/$name.mp4',
      onReceiveProgress: (rec, total) {
        progress = ((rec / total) * 100).toStringAsFixed(0);
        // if(name=='/458587389') {
        //   debugPrint('progress $progress $name');
        //  }
      },
    ).then((_) {
      if (progress == '100') {
        numDownloadFiles++;
        debugPrint(
            "Video downloaded!!!!!!!!!! $name $numDownloadFiles $numOfAllVideos");
        Sentry.addBreadcrumb(Breadcrumb(
            message:
                "Video downloaded!!!!!!!!!! $name $numDownloadFiles $numOfAllVideos"));
        // Sentry.instance.client;
        isarVideoList
            .firstWhere((iv) => iv.id == int.parse(name.substring(1)))
            .isDownload = true;
        IsarService().updateIsarVideo(int.parse(name.substring(1)));
        if (numDownloadFiles == numOfAllVideos) {
          debugPrint('alllllllllll downloaded');
          Sentry.addBreadcrumb(Breadcrumb(message: 'alllllllllll downloaded'));

          downloadStatus = DownloadStatus.downloaded;
          notifyListeners();
        } else {
          checkErrors();
        }
      }
    }).catchError((e) {
      if (CancelToken.isCancel(e)) {
        // debugPrint(e.message);
        // Sentry.addBreadcrumb(
        //     Breadcrumb(message: e.message, level: SentryLevel.error));
      }
    });
  }

  deleteFilesInDirectoryBeforeDownloading() async {
    //Directory dir = await getApplicationSupportDirectory();
    Directory dir = await CommonFuncs().getEshkolotWorkingDirectory();
    // final targetFile = Directory("${dir.path}/books/$fileName.pdf");
    final targetFile = Directory('${dir.path}/lessons/$courseId');
    if (targetFile.existsSync()) {
      targetFile.deleteSync(recursive: true);
    }
    debugPrint('all delete');
  }

  setTimer() {
    if (timer == null || !timer!.isActive) {
      // int minuteToWait = ((numOfAllVideos * 12) / 60).ceil();
      int minuteToWait = 30;
      debugPrint('minuteToWait $minuteToWait');
      Sentry.addBreadcrumb(Breadcrumb(message: 'minuteToWait $minuteToWait'));
      timer = Timer(Duration(minutes: minuteToWait), () async {
        tryAgainFromStart();
      });
    }
  }

  checkErrors() async {
    if (blockLinks.length + numDownloadFiles + errorLinks.length ==
        numOfAllVideos) {
      debugPrint('problemmmmm');
      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }

      if (errorLinks.isNotEmpty) {
        debugPrint('errorrrr');
        Sentry.addBreadcrumb(
            Breadcrumb(message: 'errorrrr errorLinks.isNotEmpty'));

        errorTries++;
        if (errorTries < 3) {
          debugPrint('error links start again');
          await Sentry.captureMessage(
              'my downloading data error links trying again errorTries  $errorTries');
          startDownLoading();
        } else {
          await Sentry.captureMessage(
              'my downloading data error links display error errorTries $errorTries');
          downloadStatus = DownloadStatus.error;
          notifyListeners();
        }
      } else {
        if (blockLinks.isNotEmpty) {
          debugPrint('blocked linksssssssssss');

          Sentry.addBreadcrumb(Breadcrumb(message: 'blocked linksssssssssss'));
          await Sentry.captureMessage(
              'my downloading data blocked links error ');
          //todo change..
          downloadStatus = DownloadStatus.blockError;
          // downloadStatus = DownloadStatus.downloaded;

          notifyListeners();
        }
      }
    }
  }

  List<VideoIsar> getAllDownloaded() {
    return isarVideoList
        .where((element) => element.isDownload == true)
        .toList();
  }

  List<VideoIsar> getAllNotDownloaded() {
    return isarVideoList
        .where((element) => element.isDownload == false)
        .toList();
  }

  getCourseSteps() async {
    Dio dio = Dio();

    try {
      token = await AuthJWT();
      token = '';
      dio.options.headers['content-Type'] = 'application/json;charset=UTF-8';
      dio.options.headers['authorization'] = "bearer $token";
      String url =
          'https://eshkolot.net/wp-json/ldlms/v1/sfwd-courses/71/steps';

      Response response = await dio.get(url);
      debugPrint('course ${response.data}');
    } catch (error) {
      debugPrint('error 1111 $error');
    }
  }

  AuthJWT() async {
    String username = 'rivki.cholak@gmail.com';
    String password = 'Z)lakR1vk1';
    Dio dio = Dio();
    try {
      // const credentials = {
      //   username: process.env.EMAIL_ADMIN,
      //   password: process.env.PASSWORD_ADMIN
      // }
      // // console.log(credentials, 'credentials')
      // const headers = {
      //   "Content-Type": "application/json"
      // }
      String basicAuth =
          'Basic ${base64.encode(utf8.encode('$username:$password'))}';
      debugPrint('basicAuth $basicAuth');
      dio.options.headers['authorization'] = basicAuth;
      dio.options.headers['content-Type'] = 'application/json;charset=UTF-8';

      Response getToken = await dio.post(
          'https:/eshkolot.net/wp-json/jwt-auth/v1/token',
          data: <String, dynamic>{
            'username': 'rivki.cholak@gmail.com',
            'password': 'Z)lakR1vk1',
          });
      Map result = getToken.data;
      debugPrint('token ${result['token']}');
      return result['token'];
    } catch (error) {
      debugPrint('error 222 $error');
    }
  }

  @override
  void dispose() async {
    if (!isDispose) {
      debugPrint('disssss');
      // if (blockLinks.isNotEmpty) {
      //   await Sentry.captureMessage('my downloading data blocked links error ');
      // } else {
      //todo remove condition when disable block links options to go on
      if (blockLinks.isEmpty) {
        await Sentry.captureMessage(
            'my downloading data ok $captureMessageNum');
      }
      // }
      //   transaction.finish();
      isDispose = true;

      subscription.cancel();
      //makes a problem
      _networkConnectivity.disposeStream();
      _networkConnectivity.whileDownloading = false;

      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
      super.dispose();
    }
  }
}

enum DownloadStatus {
  blockError,
  downloading,
  downloaded,
  error,
  netWorkError,
  // allDownloaded
}
