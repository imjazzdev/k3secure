import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../helper/preference.dart';

class MyApiClient extends GetConnect {
  final String _baseUrl = "http://10.127.28.171:8000/api/";

  final bool? token;

  MyApiClient({Key? key, this.token});

  Future<Response> getAsync(String path) async {
    httpClient.baseUrl = _baseUrl;
    if (token ?? false) {
      httpClient.addRequestModifier<dynamic>((request) async {
        request.headers.addAll({
          'Authorization':
              'Bearer ${await Preference.getString(Constant.jwtpreference)}',
          'Accept': 'application/json'
        });
        return request;
      });
    }

    final response = await get(path);

    if (response.statusCode != 200) {
      handleError(response);
    }

    return response;
  }

  Future<Response> postAsync(String path, dynamic data) async {
    httpClient.baseUrl = _baseUrl;
    if (token ?? false) {
      httpClient.addRequestModifier<dynamic>((request) async {
        request.headers.addAll({
          'Authorization':
              'Bearer ${await Preference.getString(Constant.jwtpreference)}',
          'Accept': 'application/json'
        });
        return request;
      });
    }

    final response = await post(path, data);

    if (response.statusCode != 200) {
      handleError(response);
    }

    return response;
  }

  void handleError(Response response) {
    ("ERROR CODE : ${response.statusCode}");

    switch (response.statusCode) {
      case 400:
        throw Exception('Bad request error');
      case 404:
        throw Exception('Not found error');
      case 500:
        throw Exception('Internal server error');
      default:
      // if ([Constant.codeTokenExpired, Constant.codeTokenInvalid]
      //     .contains(response.body['code'])) {
      //   // logout
      // }

      //throw Exception(response.body['message']);
    }
  }
}
