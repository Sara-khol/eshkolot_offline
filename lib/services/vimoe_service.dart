import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eshkolot_offline/models/course.dart';
import 'package:eshkolot_offline/models/videoIsar.dart';
import 'package:flutter/cupertino.dart';

import 'package:path_provider/path_provider.dart';

import '../models/vimoe_download.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'isar_service.dart';
import 'network_check.dart';

class VimoeService with ChangeNotifier {
  String token = '1234e6802e12410d1130b9fa774d4cd0'; //privet video files

  int projectId = 0; //english

  Dio dio = Dio();

  List<VimoeVideo> videoList = [];
  List<VideoIsar> isarVideoList = [];
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
  bool finishConnectToVimoe=false;
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  late bool isNetWorkConnection;

  VimoeService() {
    print("VimoeService");

    dio.options.headers['content-Type'] = 'application/json;charset=UTF-8';
    dio.options.headers['authorization'] = "bearer ${token}";
    dio.options.headers['Connection'] = "keep-alive";

    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) async {
      _source = source;
      print('source $_source');
      if (_source.keys.toList()[0] == ConnectivityResult.none) {
        if (downloadStatus != DownloadStatus.netWorkError) {
          isNetWorkConnection=false;
          downloadStatus = DownloadStatus.netWorkError;
          notifyListeners();
          if(finishConnectToVimoe) {
            print('cancel');
            cancelToken.cancel('wwwwwww');
          }
        }
      } else {
        if (downloadStatus == DownloadStatus.netWorkError) {
          downloadStatus = lastDownLoadStatus;
          notifyListeners();
          isNetWorkConnection=true;
          //if in middle to download videos
          if(finishConnectToVimoe) {

            print('jjjj ${getAllDownloaded().map((v) => v.id)}');
            print('jjjj ${getAllDownloaded().length}');

            print('aaaaagain');
            if (cancelToken.isCancelled) {
              cancelToken = CancelToken();
            }
            startDownLoading(wasNetWorkProblem: true);
          }
          else{
            print('start');
            start();
          }
        }
      }
    });


    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("::: Api Url : ${options.uri}");
        //print("::: Api header : ${options.headers}");
        isarVideoList
            .firstWhereOrNull((iv) => iv.downloadLink == options.path)
            ?.requestOptions = options;

        return handler.next(options);
        // super.onRequest(options, handler);
      },
      // onResponse: (response, handler) {
      //   // print("::: response : ${response.data.toString()}");
      //   return handler.next(response);
      // },
      onError: (error, handler) async {
        if (error.response?.statusCode == 418) {
          String url = error.requestOptions.path;
          String start = 'download/';
          final startIndex = url.indexOf(start);
          final endIndex = url.indexOf('/', startIndex + start.length);
          String vimoeId = url.substring(startIndex + start.length, endIndex);
          blockLinks.add('https://vimeo.com/$vimoeId');
        } else {
          print('my error ${error}');
          // if(error.error is SocketException) {
          //   print('SocketException');
          errorLinks.add(error.requestOptions.path);
        }
        checkErrors();
        handler.reject(
            error); // Added this line to let error propagate outside the interceptor
      },
    ));

  }

  start({bool notify = false}) async {
    if(isNetWorkConnection) {
      downloadStatus = DownloadStatus.downloading;
      lastDownLoadStatus = DownloadStatus.downloading;
      numOfAllVideos = 0;
      numDownloadFiles = 0;
      blockLinks = [];
      errorLinks = [];
      finishConnectToVimoe = false;

      if (notify) notifyListeners();
      if (courses.isEmpty) {
        courses = await IsarService.instance.getAllCourses();
      }
      for (Course course in courses) {
        if (course.serverId != 0) {
          projectId = course.serverId;
          await connectToVimoe();
        }
      }
      next();
    }
    else{
      downloadStatus=DownloadStatus.netWorkError;
      lastDownLoadStatus=DownloadStatus.netWorkError;
      print('no network');
    }
  }

  connectToVimoe({String url = '', bool notify = false}) async {
    print('idddddd $projectId');
    downloadStatus = DownloadStatus.downloading;
    if (notify) notifyListeners();

    // url = url == ''
    //     ? 'https://api.vimeo.com/me/projects/${projectId}/videos'
    //         '?fields=uri,link,download.link,download.size_short,download.height,'
    //         'download.width,download.rendition,download.quality'

    url = url == ''
        ? 'https://api.vimeo.com/me/projects/${projectId}/videos'
        '?fields=uri,link,files.link,files.size_short,files.height,'
        'files.width,files.rendition,files.quality'
        : 'https://api.vimeo.com${url}';
    Response response = await dio.get(url);

    Map result = response.data;

    videoList.addAll(result['data']
        .map<VimoeVideo>((entry) => (VimoeVideo.fromJson(entry)))
        .toList());


    if (result['paging']['next'] != null) {
      await connectToVimoe(url: result['paging']['next']);
    }
  }

  next() async {
    numOfAllVideos =videoList.length;
    print('numOfAllVideos ${numOfAllVideos}');
     finishConnectToVimoe=true;
    for (VimoeVideo v in videoList) {
      VimoeFile? download =
          v.files.firstWhereOrNull((d) => d.rendition == '540p');
      currentLink = v.link;
      //not sepouse to be null
      if (download != null && download.link != null) {
        String name = v.uri.substring(v.uri.lastIndexOf('/'), v.uri.length);
        isarVideoList.add(VideoIsar()
          ..id = int.parse(name.substring(1))
          ..downloadLink = download.link!
          ..name = name);
        await IsarService.instance.addIsarVideo(VideoIsar()
          ..id = int.parse(name.substring(1))
          ..downloadLink = download.link!..name = name);
          /*await*/ downloadFile(download.link!, name, true);
      }
    }
  }

  startDownLoading({bool wasNetWorkProblem=false}) async {
    print('=====');
    if(isNetWorkConnection) {
      print('startDownLoading');
      downloadStatus = DownloadStatus.downloading;
      lastDownLoadStatus = DownloadStatus.downloading;
      numDownloadFiles = 0;
      blockLinks = [];
      errorLinks = [];
      int i = 0;
      isarVideoList.removeWhere((item) => item.isDownload == true);

      numOfAllVideos = isarVideoList.length;
      print('numOfAllVideos $numOfAllVideos');
      if (numOfAllVideos == 0) {
        downloadStatus = DownloadStatus.downloaded;
        notifyListeners();
      }
      for (VideoIsar v in isarVideoList) {
        print('i $i');
        i++;
        if(wasNetWorkProblem) {
          print('awaittttttttt');
          await downloadFile(v.downloadLink, v.name, false);
        }
        else
          {
            print('nooo await');
            downloadFile(v.downloadLink, v.name, false);
          }
      }
    }
    else {
      downloadStatus = DownloadStatus.netWorkError;
      lastDownLoadStatus = DownloadStatus.netWorkError;
      print('no network');
    }
  }

  Future<void> downloadFile(String url, String name, bool regular) async {
    String progress = '';
      var dir =
      await getApplicationSupportDirectory(); //C:\Users\USER\AppData\Roaming\com.example\eshkolot_offline
      await dio.download(
        url,
        cancelToken: cancelToken,

        '${dir.path}$name.mp4',
        onReceiveProgress: (rec, total) {
          progress = ((rec / total) * 100).toStringAsFixed(0);
        },
      ).then((_) {
        if (progress == '100') {
          numDownloadFiles++;
          print(
              "Video downloaded!!!!!!!!!! $name $numDownloadFiles $numOfAllVideos");
          isarVideoList
              .firstWhere((iv) => iv.id == int.parse(name.substring(1)))
              .isDownload = true;
          IsarService.instance.updateIsarVideo(int.parse(name.substring(1)));
          if (numDownloadFiles == numOfAllVideos) {
            print('alllllllllll downloaded');
            downloadStatus = DownloadStatus.downloaded;
            notifyListeners();
          }
          else {
            checkErrors();
          }

        }
      }).catchError((e) {
        if (CancelToken.isCancel(e)) {
          print( e.message);
        }
      });

  }

  checkErrors() {
    if (blockLinks.length + numDownloadFiles + errorLinks.length == numOfAllVideos) {
      print('problemmmmm');

      if (errorLinks.isNotEmpty) {
        print('errorrrr');
        errorTries++;
        if (errorTries < 3) {
          print('error links start again');
          startDownLoading();
        } else {
          downloadStatus = DownloadStatus.error;
          notifyListeners();
        }
      } else {
        if (blockLinks.isNotEmpty) {
          print('blocked linksssssssssss');
          downloadStatus = DownloadStatus.blockError;
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

  getCourseSteps() async {
    Dio dio = Dio();

    try {
      token = await AuthJWT();
      token = '';
      dio.options.headers['content-Type'] = 'application/json;charset=UTF-8';
      dio.options.headers['authorization'] = "bearer ${token}";
      String url =
          'https://eshkolot.net/wp-json/ldlms/v1/sfwd-courses/71/steps';

      Response response = await dio.get(url);
      print('course ${response.data}');
    } catch (error) {
      print('error 1111 $error');
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
          'Basic ' + base64.encode(utf8.encode('$username:$password'));
      print('basicAuth $basicAuth');
      dio.options.headers['authorization'] = basicAuth;
      dio.options.headers['content-Type'] = 'application/json;charset=UTF-8';

      Response getToken = await dio.post(
          'https:/eshkolot.net/wp-json/jwt-auth/v1/token',
          data: <String, dynamic>{
            'username': 'rivki.cholak@gmail.com',
            'password': 'Z)lakR1vk1',
          });
      Map result = getToken.data;
      print('token ${result['token']}');
      return result['token'];
    } catch (error) {
      print('error 222 $error');
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
