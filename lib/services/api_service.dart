import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiService {
  final Dio _dio = Dio();

  final _baseUrl = 'https://eshkolot.net/wp-json/wp/v2/';

  sendPasswordRecoveryMail({required int id,required Function() onSuccess,required Function() onError}) async {
    Response response = await _dio.get('${_baseUrl}sent_email/$id');

    // Prints the raw data returned by the server
    debugPrint('data: ${response.data}');
    if (response.statusCode==200 && response.data) {
      onSuccess();
    } else {
      onError();
    }
  }

  syncData({required Function() onSuccess,required Function() onError,required Map<String, dynamic> jsonMap}) async {

    debugPrint('url: ${_baseUrl}update_user_data');
    debugPrint('data : ${ json.encode(jsonMap)}');


    Response response = await _dio.post('${_baseUrl}update_user_data',data: json.encode(jsonMap), /*: {"Content-Type": "application/json" }*/);

    // Prints the raw data returned by the server
    debugPrint('data: ${response.data}');
    if (response.statusCode==200 ) {
      onSuccess();
    } else {
      onError();
    }
  }
}
