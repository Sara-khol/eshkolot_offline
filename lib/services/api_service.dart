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
}
