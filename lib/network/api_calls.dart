import 'dart:io';

import '../AppUtill.dart';
import '../model/ApiResponse.dart';
import 'Apis.dart';
import 'dart:convert';
import 'package:dio/dio.dart';


enum RequestType { POST, GET, FORM }

class ApiCalls {
  late Dio _dio;

  ApiCalls({baseUrl = Apis.BASE_URL}) {
    _dio = new Dio(BaseOptions(
      baseUrl: Apis.BASE_URL,
      headers: {HttpHeaders.acceptHeader: "application/json"},
    ));
  }

  Future forRequest(void ApiResult(ApiResponse apiResponce), url, requestType,
      {RequestParam = null}) async {
    AppUtill.printAppLog('request url = ${url}');
    if (RequestParam != null && requestType != RequestType.FORM)
      AppUtill.printAppLog('request data = ${jsonEncode(RequestParam)}');

    late Response response;

    try {
      if (requestType == RequestType.POST) {
        response = await _dio.post(url, data: jsonEncode(RequestParam));
      } else if (requestType == RequestType.FORM) {
        response = await _dio.post(url, data: RequestParam);
      } else if (requestType == RequestType.GET) {
        response = await _dio.get(url);
      }

      AppUtill.printAppLog("response status == ${response.statusCode}");
      AppUtill.printAppLog("response result == ${jsonEncode(response.data)}");

      if (response.statusCode == 200) {
     // Map resultSet = JsonCodec().decode(jsonEncode(response.data));

        ApiResponse apiResponce = ApiResponse.fromJson(response.data);

        ApiResult(apiResponce);
      }
    } catch (e, stackTrace) {

      AppUtill.printAppLog('Exception1==${e.toString()}');
      AppUtill.printAppLog('Exception2==$stackTrace');
    }
  }
}
