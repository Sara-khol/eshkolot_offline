import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../models/vimoe_download.dart';
import 'package:collection/src/iterable_extensions.dart';

import 'isar_service.dart';


class VimoeService with ChangeNotifier {
  String token = '1234e6802e12410d1130b9fa774d4cd0'; //privet video files

  int projectId = 0;//english
  int numCourses=0;
  int numCoursesDownloaded=0;
  // int projectId = 10390152; //
  Dio dio = Dio();

  List<VimoeVideo> videoList = [];
  int numDownloadFiles = 0;
  late DownloadStatus downloadStatus;
  late String currentLink;
  List<String> blockLinks = [];

  VimoeService() {
    print("VimoeService");
    dio.options.headers['content-Type'] = 'application/json;charset=UTF-8';
    dio.options.headers['authorization'] = "bearer ${token}";
    //connectToVimoe();
  }

  connectToVimoe({String url = '', bool notify = false}) async {
    print('idddddd $projectId');
    downloadStatus = DownloadStatus.downloading;
    if (notify) notifyListeners();
    if (url == '') videoList = [];
    numDownloadFiles = 0;
    blockLinks = [];
    url = url == ''
        ? 'https://api.vimeo.com/me/projects/${projectId}/videos'
            '?fields=uri,link,download.link,download.size_short,download.height,'
            'download.width,download.rendition,download.quality'
        : 'https://api.vimeo.com${url}';
    Response response = await dio.get(url);

    Map result = response.data;

    videoList.addAll(result['data']
        .map<VimoeVideo>((entry) => (VimoeVideo.fromJson(entry)))
        .toList());

    if (result['paging']['next'] != null) {
      connectToVimoe(url: result['paging']['next']);
    } else {
      int vimoeLength = videoList.length;
      print('length ${vimoeLength}');
      dio.interceptors.add(InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == 418) {
            downloadStatus = DownloadStatus.blockError;
            String url = error.requestOptions.path;
            blockLinks.add(currentLink);
            print('errorLinks $blockLinks');
          } else {
            downloadStatus = DownloadStatus.error;
            notifyListeners();
          }
          handler.reject(
              error); // Added this line to let error propagate outside the interceptor
        },
      ));
      //want to download only one for try
      // downloadFile(videoList[0].download[0].link!,
      //     videoList[0].uri.substring(videoList[0].uri.lastIndexOf('/'), videoList[0].uri.length),1);
      for (VimoeVideo v in videoList) {
        VimoeDownload? download =
            v.download.firstWhereOrNull((d) => d.rendition == '540p');
        currentLink = v.link;
        //not sepouse to be null
        if (download != null && download.link != null) {
          // if(v.uri=='/videos/467074198')
          //   await downloadFile('https://player.vimeo.com/progressive_redirect/download/707821702/container/d01890c4-df30-4dba-940d-0a6122b763fe/58988585/%D7%91%D7%98%D7%99%D7%97%D7%95%D7%AA_%D7%91%D7%A8%D7%97%D7%A6%D7%94_%D7%91%D7%91%D7%A8%D7%99%D7%9B%D7%94%20%28720p%29.mp4?expires=1675327220&loc=external&signature=40b5c811e0af7007bfeb001e0cc7a6ee944a9378696d7c169ef6feb7e10c5fa7',
          //      'blockkkk',vimoeLength);
          // else {
          /*await*/ downloadFile(
              download.link!,
              v.uri.substring(v.uri.lastIndexOf('/'), v.uri.length),
              vimoeLength);
          //  }
        }
      }
    }
  }

  Future<void> downloadFile(String url, String name, int videosLength) async {
    String progress = '';
    try {
      var dir =
          await getApplicationSupportDirectory(); //C:\Users\USER\AppData\Roaming\com.example\eshkolot_offline

      dio.download(
        url,
        '${dir.path}$name.mp4',
        onReceiveProgress: (rec, total) {
          progress = ((rec / total) * 100).toStringAsFixed(0);
        },
      ).then((_) {
        if (progress == '100') {
          numDownloadFiles++;
          print("Video downloaded!!!!!!!!!! $name $numDownloadFiles");
          if (numDownloadFiles == videosLength) {
            print('alllllllllll downloaded');
            downloadStatus = DownloadStatus.downloaded;
            numCoursesDownloaded++;
            updateDownload(projectId);
            if(numCoursesDownloaded==numCourses)
              {
                downloadStatus = DownloadStatus.allDownloaded;
              }
            notifyListeners();
          } else if (blockLinks.length + numDownloadFiles == videosLength) {
            print('blocked linksssssssssss');
            downloadStatus = DownloadStatus.blockError;
            notifyListeners();
          }
        }
      });
    } catch (e) {
      print(e);
      downloadStatus = DownloadStatus.error;
      notifyListeners();
    }
  }

  Future<void> updateDownload(int id) async {
    print('updateDownload $id');
    await IsarService.instance.updateDownloadCourse(id);
  }

  getCourseSteps() async {
    Dio dio = Dio();

    try {
      token = await AuthJWT();
      token = '';
      dio.options.headers['content-Type'] = 'application/json;charset=UTF-8';
      dio.options.headers['authorization'] = "bearer ${token}";
      // String url = `https://yourserver.com/wp-json/ldlms/v2/sfwd-lessons?course=${id}`
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
  allDownloaded
}
