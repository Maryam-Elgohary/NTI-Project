import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiServices {
  final Dio _dio;
  ApiServices(this._dio);

  final String baseUrl = "https://fakestoreapi.com/";

  Future<dynamic> get({
    required String endPoint,
    @required String? token,
  }) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    var response = await _dio.get(
      '$baseUrl$endPoint',
      options: Options(headers: headers),
    );

    return response.data;
  }
}
