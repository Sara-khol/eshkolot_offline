import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:eshkolot_offline/models/course.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/services/download_data_service.dart';
import 'package:eshkolot_offline/services/installationDataHelper.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:flutter/cupertino.dart';

class ApiService {
  final Dio _dio = Dio();
  final _baseUrl = 'https://dev2.eshkolot.net/wp-json/wp/v2/';
  // final _baseUrl = 'https://bibilease.quicksolutions.co.il/?rest_route=/wp/v2';

  CancelToken cancelToken = CancelToken();

  ApiService._privateConstructor(); // Private constructor for singleton

  static final ApiService _instance = ApiService._privateConstructor();

  factory ApiService() {

    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
    //   client.badCertificateCallback=(X509Certificate cert, String host, int port){
    //     return true;
    //   };
    // };
    return _instance;
  }


  sendPasswordRecoveryMail(
      {required int id,
      required Function() onSuccess,
      required Function() onError}) async {
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
        HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );

    Response response = await _dio.get('${_baseUrl}sent_email/$id');

    // Prints the raw data returned by the server
    debugPrint('data: ${response.data}');
    if (response.statusCode == 200 && response.data) {
      onSuccess();
    } else {
      onError();
    }
  }

  syncData(
      {required Function(bool b) onSuccess,
      required Function() onError,
      required Map<String, dynamic> jsonMap}) async {


    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
        HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );
    cancelToken = CancelToken();
    debugPrint('url: ${_baseUrl}update_user_data');
    debugPrint('data : ${json.encode(jsonMap)}');


    Response response = await _dio.post(
        '${_baseUrl}update_user_data',
        data: json.encode(jsonMap), /*: {"Content-Type": "application/json" }*/
        cancelToken: cancelToken
    );


    // Prints the raw data returned by the server
    debugPrint('response: ${response.data}');
    if (response.statusCode == 200) {
      DownloadService().init();
      await InstallationDataHelper().syncDataCourse(response.data, onSuccess);
      //todo where and how to put
      //  onSuccess();
    } else {
      onError();
    }
  }

  cancelRequests()
  {
    if(!cancelToken.isCancelled) {
      cancelToken.cancel('hhh');
      debugPrint('cancelRequests');
    }
  }

  Future<Course?> getCourseData(
      {required int id,
     /* required Function() onSuccess,*/
      required Function() onError,
        required bool isSingleInCourse}) async {
    String url = '${_baseUrl}get_course_data/$id';
    //גאומטריה
    // String url = '${_baseUrl}get_course_data/55058';
    Course? course;
    debugPrint('url: $url');
    cancelToken = CancelToken();
    Response response = await _dio.get(url,cancelToken: cancelToken);
    if (response.statusCode == 200) {
      debugPrint('okkkk');
      DownloadService().init();
      Course course = await InstallationDataHelper().setSyncNewCourse(response.data,isSingleInCourse);
      return course;
      // InstallationDataHelper().eventBusDialogs.fire(course);
      //onSuccess();
    } else {
      onError();
    }
    return course;
  }

  getPathCourses({required int id,required Function() onError}) async
  {
    // https://dev2.eshkolot.net/wp-json/wp/v2/get_courses_ids_for_learn_path/103471
    String url='${_baseUrl}get_courses_ids_for_learn_path/$id';
    debugPrint('url: $url');
    cancelToken = CancelToken();
    Response response = await _dio.get(url,cancelToken: cancelToken);
    if (response.statusCode == 200) {
      debugPrint('response: ${response.data}');
      // List<int> integerList = response.data.map<int>((item) => int.parse(item.toString())).toList();
      Map<String, dynamic> jsonData = jsonDecode(response.data);
      LearnPath path=LearnPath.fromJson(jsonData, id);
     // List<int> integerList = response.data['courses'] as List<int>;
      //LearnPath path=LearnPath(coursesIds:integerList,title: 'קבוצה מהסנכרון ',id: id );

      List<int> newCoursesIds=  await IsarService().setPath(path);

      // for (int courseId in path.coursesIds) {
      //   Course? c =await  IsarService().getCourseById(courseId);
      //   if (c != null) {
      //     path.coursesPath.add(c);
      //   }
      //   else {
      //
      //   }
      // }
      // IsarService().addLearnPath(path);
      return newCoursesIds;
      // DownloadService().init();
      // Course course = await InstallationDataHelper().setSyncNewCourse(response.data);
      // return course;
    } else {
      onError();
    }
  }

}

