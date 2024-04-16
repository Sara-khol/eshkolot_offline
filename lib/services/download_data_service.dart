import 'dart:async';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eshkolot_offline/models/course.dart';
import 'package:eshkolot_offline/models/linkQuizIsar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'installationDataHelper.dart';
import 'isar_service.dart';
import 'network_check.dart';
import 'package:eshkolot_offline/utils/constants.dart' as constants;

class DownloadService with ChangeNotifier {
  String token = '1234e6802e12410d1130b9fa774d4cd0'; //privet video files

  int projectId = 0; //english
  int quizId = 0; //english
  Dio dioDownload = Dio();
  List<LinkQuizIsar> isarLinksList = [];
  int numDownloadFiles = 0, numOfErrorFiles = 0;
  late DownloadStatusData downloadStatus, lastDownLoadStatus;
  late String currentLink;
  List<String> blockLinks = [];
  List<String> errorLinks = [];
  int errorTries = 0;
  List<Course> courses = [];
  int numOfAllFiles = 0;
  CancelToken cancelToken = CancelToken();
  late String path;
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  List<int> courseIds=[];

  Map _source = {ConnectivityResult.none: false};

  // final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  late bool isNetWorkConnection;
  bool isDispose = false;
  late StreamSubscription subscription;
  Timer? timer;
  int captureMessageNum = 1;
  bool wasInit = false;
  bool tryAgain=false;
  bool coursesNotCompleted=false;
  bool  didCheckCompleted=false;
  late SharedPreferences preferences;
  DownloadService._privateConstructor(); // Private constructor for singleton

  static final DownloadService _instance =
      DownloadService._privateConstructor();

  factory DownloadService() {
    return _instance;
  }

  init() async {
    if (!wasInit) {
      debugPrint("downloadService init");
      didCheckCompleted=false;
      // _networkConnectivity.whileDownloading = true;
     // _networkConnectivity.initialise();
       preferences = await SharedPreferences.getInstance();

      subscription = _networkConnectivity.myStream.listen((source) async {
        _source = source;
        debugPrint('source222 $_source');
        if (_source.keys.toList()[0] == ConnectivityResult.none) {
          // if (downloadStatus != DownloadStatus.netWorkError) {
          if (timer != null && timer!.isActive) {
            timer!.cancel();
          }
          isNetWorkConnection = false;
        //  downloadStatus = DownloadStatus.netWorkError;
          notifyListeners();
          cancelToken.cancel('wwwwwww');

          debugPrint('no connection so cancel downloading');
          Sentry.addBreadcrumb(
              Breadcrumb(message: 'no connection so cancel downloading'));
          // }
        } /*else {
          // if (downloadStatus == DownloadStatus.netWorkError) {
          downloadStatus = lastDownLoadStatus;
          notifyListeners();
          isNetWorkConnection = true;
          //if in middle to download videos

          debugPrint('jjjj ${getAllDownloaded().map((v) => v.id)}');
          debugPrint('jjjj ${getAllDownloaded().length}');

          debugPrint('aaaaagain');
          if (cancelToken.isCancelled) {
            cancelToken = CancelToken();
          }
          startDownLoading(wasNetWorkProblem: true);
        }*/
        //}
      });

      coursesNotCompleted=false;


      //dioDownload.interceptors.add(interceptorsWrapper);
      dioDownload.addSentry();
      wasInit = true;

    }
    else{
      debugPrint("downloadService already init");
    }
  }

  downloadQuizFiles(List<String> urls, int quizId, int courseId) {
    //  debugPrint("quizId $quizId length ${urls.length}");

    numOfAllFiles = urls.length;
    this.quizId = quizId;
    for (String s in urls) {
      String name = s.substring(s.lastIndexOf('/'), s.length);
      if (/*!name.endsWith('.pdf') &&*/
          /* !name.endsWith('.mp4') &&*/
          !s.contains('player.vimeo.com') /*&& !s.contains('wordpress')*/) {
        isarLinksList.add(LinkQuizIsar()
          ..quizId = quizId
          ..courseId = courseId
          ..name = name
          ..downloadLink = s);
        downloadFile(s, name, quizId, courseId);
      } else {
        numDownloadFiles++;
      }
    }
  }

 /* tryAgainFromStart() async {
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
      *//*} catch (e) {
        print('errorrrrrrr ${e.toString()}');
        if (e.toString() == 'The request was cancelled') {
          print('ooo');
        }
      }*//*
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
      downloadStatus = DownloadStatusData.error;
      notifyListeners();
    }
    captureMessageNum++;
  }*/

  /*start({bool notify = false, oldLinks = false}) async {
    debugPrint('kkk');
    if (isNetWorkConnection) {
      downloadStatus = DownloadStatusData.downloading;
      lastDownLoadStatus = DownloadStatusData.downloading;
      numOfAllFiles = 0;
      numDownloadFiles = 0;
      blockLinks = [];
      errorLinks = [];
      videoList.clear();

      if (cancelToken.isCancelled) {
        cancelToken = CancelToken();
      }
      if (!oldLinks) {
        debugPrint('isarVideoList clear');
        isarLinksList.clear();
      }

      if (notify) notifyListeners();
      // if (courses.isEmpty) {
      //   courses = await IsarService().getAllCourses();
      // }
      for (Course course in courses) {
        debugPrint('ggg ${course.title}');
        projectId = course.vimeoId != '' ? int.parse(course.vimeoId) : 10390152;
        quizId = course.id;
        //     await connectToVimoe();
      }
      //todo

      if (isNetWorkConnection) next();
    } else {
      downloadStatus = DownloadStatusData.netWorkError;
      lastDownLoadStatus = DownloadStatusData.netWorkError;
      debugPrint('no network');
    }
  }*/

/*  next() async {
    // numOfAllVideos = videoList.length;
    numOfAllFiles = isarLinksList.length + isarLinksList.length;

    debugPrint('numOfAllFiles $numOfAllFiles');
    Sentry.addBreadcrumb(Breadcrumb(message: 'numOfAllVideos $numOfAllFiles'));

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

    if (isarLinksList.isNotEmpty) {
      debugPrint('old links');
      for (LinkQuizIsar link in isarLinksList) {
        downloadFile(link.downloadLink, link.name, link.quizId, link.courseId);
      }
    }
    int i = 0;
    for (VimoeVideo v in videoList) {
      //todo change???
      // VimoeFile? download =
      //     v.files.firstWhereOrNull((d) => d.rendition == '540p');
      VimoeDownload? download =
          v.download.firstWhereOrNull((d) => d.rendition == '540p');
      currentLink = v.link;
      download ??= v.download.first;
      if (download.rendition != '540p') {
        debugPrint('fff ${download.public_name}');
        debugPrint('fff ${download.link}');
      }
      //not sepouse to be null
      if (*//*download != null &&*//* download.link != null) {
        //i++;
        String name = v.uri.substring(v.uri.lastIndexOf('/'), v.uri.length);
        // isarVideoList.add(VideoIsar()
        //   ..id = int.parse(name.substring(1))
        //   ..courseId = v.courseId
        //   ..downloadLink = download.link!
        //   ..name = name);
        // if(expiredDate==-1) {
        //   expiredDate = extractExpiryTimestamp(download.link!);
        // }
        //debugPrint('name id ${name.substring(1)} $i');

        await IsarService().addIsarVideo(VideoIsar()
          ..id = int.parse(name.substring(1))
          ..courseId = v.courseId
          ..downloadLink = download.link!
          ..name = name);

        *//*await*//*
        //todo problem!!
        downloadFile(download.link!, name, v.courseId, v.courseId);
      } else {
        debugPrint('hhh ??');
      }
    }
  }*/

 /* startDownLoading(
      {bool wasNetWorkProblem = false, bool notify = false}) async {
    debugPrint('=====');
    if (isNetWorkConnection) {
      debugPrint('startDownLoading Downloading service');
      downloadStatus = DownloadStatusData.downloading;
      lastDownLoadStatus = DownloadStatusData.downloading;
      if (notify) notifyListeners();

      if (cancelToken.isCancelled) {
        cancelToken = CancelToken();
      }

      numDownloadFiles = 0;
      blockLinks = [];
      errorLinks = [];
      isarLinksList.removeWhere((item) => item.isDownload == true);

      numOfAllFiles = isarLinksList.length;
      debugPrint('numOfAllVideos $numOfAllFiles');
      Sentry.addBreadcrumb(
          Breadcrumb(message: 'numOfAllVideos $numOfAllFiles'));

      if (numOfAllFiles == 0) {
        downloadStatus = DownloadStatusData.downloaded;
        notifyListeners();
      } else {
        setTimer();

        for (LinkQuizIsar v in isarLinksList) {
          if (wasNetWorkProblem) {
            // debugPrint('awaittttttttt');
            await downloadFile(v.downloadLink, v.name, v.quizId, v.courseId);
          } else {
            // debugPrint('nooo await');
            downloadFile(v.downloadLink, v.name, v.quizId, v.courseId);
          }
        }
      }
    } else {
      downloadStatus = DownloadStatusData.netWorkError;
      lastDownLoadStatus = DownloadStatusData.netWorkError;
      if (notify) notifyListeners();
      debugPrint('no network');
      Sentry.addBreadcrumb(Breadcrumb(message: 'no network'));
    }
  }*/

  startDownLoadingBlockedLinks(List<LinkQuizIsar> list,
      {bool wasNetWorkProblem = false, bool notify = false}) async {
    tryAgain=true;
    didCheckCompleted=false;
    // if (isNetWorkConnection) {
    debugPrint('startDownLoadingBlockedLinks');
    numOfErrorFiles=0;
    downloadStatus = DownloadStatusData.downloading;
    lastDownLoadStatus = DownloadStatusData.downloading;
    if (notify) notifyListeners();

    if (cancelToken.isCancelled) {
      cancelToken = CancelToken();
    }

    numDownloadFiles = 0;
    blockLinks = [];
    errorLinks = [];

    numOfAllFiles = list.length;
    debugPrint('numOfAllFiles $numOfAllFiles');
    Sentry.addBreadcrumb(Breadcrumb(message: 'numOfAllVideos $numOfAllFiles'));

    if (numOfAllFiles == 0) {
      downloadStatus = DownloadStatusData.downloaded;
      notifyListeners();
    } else {
     // setTimer();

      for (LinkQuizIsar l in list) {
        if (wasNetWorkProblem) {
          // debugPrint('awaittttttttt');
          await downloadFile(l.downloadLink, l.name, l.quizId, l.courseId,id: l.id);
        } else {
          // debugPrint('nooo await');
          downloadFile(l.downloadLink, l.name, l.quizId, l.courseId,id: l.id);
        }
      }
    }
    /* } else {
      downloadStatus = DownloadStatusData.netWorkError;
      lastDownLoadStatus = DownloadStatusData.netWorkError;
      if (notify) notifyListeners();
      debugPrint('no network');
      Sentry.addBreadcrumb(Breadcrumb(message: 'no network'));
    }*/
  }

  Future<void> downloadFile(String url, String name, int qId, int courseId,
      {int id = 0}) async {
    String progress = '';
    var dir =
        await getApplicationSupportDirectory(); //C:\Users\USER\AppData\Roaming\GoApp\eshkolot_offline
    String path='${dir.path}/${constants.quizPath}/$qId$name';
   // dir = Directory(path);
    // if(!dir.existsSync())
    //   {
    //     await dir.create();
    //   }
    await dioDownload.download(
      url,
      cancelToken: cancelToken,
      '${dir.path}/${constants.quizPath}/$qId$name',
      onReceiveProgress: (rec, total) {
        progress = ((rec / total) * 100).toStringAsFixed(0);
      },
    ).then((_) {
      if (name.split('.').last != 'mp4' || progress == '100') {
        numDownloadFiles++;
        debugPrint(
            'name $name qId $qId numDownloadFiles $numDownloadFiles courseId $courseId');
       if(isarLinksList.isNotEmpty) {
         isarLinksList.firstWhere((iv) => iv.name == name && iv.quizId == qId).isDownload=true;
       }
       //when downloading again blocked links
       if(id!=0) {
         IsarService().updateLinkQuiz(id);
       }
        checkCompleted();


         // IsarService().updateIsarLinkQuiz(int.parse(name.substring(1)));
      }

    }).catchError((e) async {
      if (e is DioException && CancelToken.isCancel(e)) {
        debugPrint('CancelToken.isCancel');
        numOfErrorFiles++;
        if (!blockLinks.contains(url)) {
          blockLinks.add(url);
        }
        if (id == 0 || !await IsarService().checkIsarQuizExistes(id)) {
          IsarService().addIsarQuiz(LinkQuizIsar()
            ..courseId = courseId
            ..downloadLink = url
            ..quizId = qId
            ..name = name
            ..isBlock = false
            ..isDownload = false);
        }
        // debugPrint(e.message);
        // Sentry.addBreadcrumb(
        //     Breadcrumb(message: e.message, level: SentryLevel.error));
      } else {
        numOfErrorFiles++;
        if (!blockLinks.contains(url)) {
          blockLinks.add(url);
        }
        if (id == 0 || !await IsarService().checkIsarQuizExistes(id)) {
        await  IsarService().addIsarQuiz(LinkQuizIsar()
            ..courseId = courseId
            ..downloadLink = url
            ..quizId = qId
            ..name = name
            ..isBlock = e.message!=null  && e.message.contains('418')
            ..isDownload = false);
        }
        if (e is DioException &&
            e.message != null &&
            e.message!.contains('418')) {
          debugPrint('block $url quizId: $qId courseId $courseId');
          Sentry.addBreadcrumb(Breadcrumb(
              message: 'block $url quizId: $qId courseId $courseId'));
        } else {
          debugPrint('erorrrr download quiz file: ${e} quizId: $qId url $url');
          Sentry.addBreadcrumb(
              Breadcrumb(
                  message: 'erorrrr download quiz file: ${e} quizId: $qId url $url'));
        }
        checkCompleted();
      }
    }
    );
  }

  checkCompleted() async {
    int myNum=tryAgain?numOfAllFiles:InstallationDataHelper().numOfQuizUrls;
    if (numDownloadFiles + numOfErrorFiles ==myNum ) {
      if (!didCheckCompleted) {
        debugPrint('all downloaded!! $myNum $numDownloadFiles $numOfErrorFiles');
        didCheckCompleted = true;
        preferences.setBool('downloadFiles', true);
        //added this condition - coursesNotCompleted when internet stops in middle of
        // downloading quiz when starts again it will download videos from start
        List<int> idsNotCompleted;
        // coursesNotCompleted= await IsarService().checkCoursesNotCompleted(courseIds);
        idsNotCompleted =
        await IsarService().checkCoursesNotCompleted(courseIds);
        for (int id in idsNotCompleted) {
          debugPrint('idNotCompleted $id');
        }
        if (courseIds.isNotEmpty) {
          debugPrint('courseIds $courseIds');
          coursesNotCompleted = courseIds.length == idsNotCompleted.length;
        }
        else {
          coursesNotCompleted = idsNotCompleted.isNotEmpty;
          courseIds = idsNotCompleted;
        }
        debugPrint('coursesNotCompleted $coursesNotCompleted');
        if (!tryAgain || coursesNotCompleted) {
          // IsarService().updateCourseDownloaded(courseIds);
          debugPrint('sending event full');
          InstallationDataHelper()
              .eventBusDialogs
              .fire(InstallationDataHelper().coursesList);
          InstallationDataHelper().coursesList = [];
        }
        else {
          InstallationDataHelper()
              .eventBusDialogs.fire('quiz');
        }
      }
    }
    debugPrint('didCheckCompleted $didCheckCompleted');
  }

/*  deleteFilesInDirectoryBeforeDownloading() async {
    Directory dir = await getApplicationSupportDirectory();
    // final targetFile = Directory("${dir.path}/books/$fileName.pdf");
    final targetFile = Directory('${dir.path}/${constants.quizPath}/$quizId');
    if (targetFile.existsSync()) {
      targetFile.deleteSync(recursive: true);
    }
    debugPrint('all delete');
  }*/

 /* setTimer() {
    if (timer == null || !timer!.isActive) {
      // int minuteToWait = ((numOfAllVideos * 12) / 60).ceil();
      int minuteToWait = 30;
      debugPrint('minuteToWait $minuteToWait');
      Sentry.addBreadcrumb(Breadcrumb(message: 'minuteToWait $minuteToWait'));
      timer = Timer(Duration(minutes: minuteToWait), () async {
        tryAgainFromStart();
      });
    }
  }*/

 /* checkErrors() async {
    if (blockLinks.length + numDownloadFiles + errorLinks.length ==
        numOfAllFiles) {
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
          downloadStatus = DownloadStatusData.error;
          notifyListeners();
        }
      } else {
        if (blockLinks.isNotEmpty) {
          debugPrint('blocked linksssssssssss');

          Sentry.addBreadcrumb(Breadcrumb(message: 'blocked linksssssssssss'));
          await Sentry.captureMessage(
              'my downloading data blocked links error ');
          //todo change..
          downloadStatus = DownloadStatusData.blockError;
          //downloadStatus = DownloadStatus.downloaded;

          notifyListeners();
        }
      }
    }
  }*/

  List<LinkQuizIsar> getAllDownloaded() {
    return isarLinksList
        .where((element) => element.isDownload == true)
        .toList();
  }

  List<LinkQuizIsar> getAllNotDownloaded() {
    return isarLinksList
        .where((element) => element.isDownload == false)
        .toList();
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
      // _networkConnectivity.disposeStream();
      // _networkConnectivity.whileDownloading = false;

      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
      super.dispose();
    }
  }
}

enum DownloadStatusData {
  blockError,
  downloading,
  downloaded,
  error,
  netWorkError,
  // allDownloaded
}
