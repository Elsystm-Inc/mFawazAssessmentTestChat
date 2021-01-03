import 'dart:io';
import "dart:async";
import 'package:mfawazTestChat/utils/constants.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'app_exceptions.dart';

class APICaller {
  String url = Constants.baseUrl;

  setUrl(String uri) {
    url = Constants.baseUrl + uri;
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<dynamic> getData({Map<String, String> headers, bool needAuthorization = false}) async {
    if (headers == null) {
      headers = {};
    }
    headers["Accept"] = "application/json";
    headers["Content-Type"] = "application/json";
    headers["Accept-Language"] = Root.locale.languageCode;
    headers["currency"] = "1";
    if (needAuthorization) {
      String token = await getToken();
      if (token != null) {
        headers["Authorization"] = token;
      }
    }
    try {
      final res =
          await http.get(Uri.encodeFull(url), headers: headers).timeout(const Duration(seconds: 50), onTimeout: () {
        throw RequestTimeOutException("Poor internet or no internet connectivity");
      });
      var dataRetrived = _returnResponse(res);
      return dataRetrived;
    } on SocketException {
      return [];
    }
  }

  Future<dynamic> postData({Map body, Map<String, String> headers, bool needAuthorization = false}) async {
    if (headers == null) {
      headers = {};
    }
    headers["Accept"] = "application/json";
    headers["Content-Type"] = "application/json";
    headers["Accept-Language"] = Root.locale.languageCode;
    headers["currency"] = "1";
    if (needAuthorization) {
      String token = await getToken();
      if (token != null) {
        headers["Authorization"] = token;
      }
    }
    if (body == null) {
      body = {};
    }
    try {
      final res = await http.post(Uri.encodeFull(url), headers: headers, body: json.encode(body)).timeout(
          const Duration(
            seconds: 50,
          ), onTimeout: () {
        throw RequestTimeOutException("Poor internet or no internet connectivity");
      });
      var dataRetrived = _returnResponse(res);
      return dataRetrived;
    } on SocketException {
      return [];
    }
  }

  Future<dynamic> deleteData({Map<String, String> headers, bool needAuthorization = false}) async {
    if (headers == null) {
      headers = {};
    }
    headers["Accept"] = "application/json";
    headers["Content-Type"] = "application/json";
    headers["Accept-Language"] = Root.locale.languageCode;
    headers["currency"] = "1";
    if (needAuthorization) {
      String token = await getToken();
      if (token != null) {
        headers["Authorization"] = token;
      }
    }
    print(url);
    try {
      final res = await http.delete(Uri.encodeFull(url), headers: headers).timeout(
          const Duration(
            seconds: 50,
          ), onTimeout: () {
        throw RequestTimeOutException("Poor internet or no internet connectivity");
      });
      var dataRetrived = _returnResponse(res);
      return dataRetrived;
    } on SocketException {
      return [];
    }
  }

  Future<dynamic> putData({Map body, Map<String, String> headers, bool needAuthorization}) async {
    if (headers == null) {
      headers = {};
    }
    headers["Accept"] = "application/json";
    headers["Content-Type"] = "application/json";
    headers["Accept-Language"] = Root.locale.languageCode;
    headers["currency"] = "1";
    if (needAuthorization) {
      String token = await getToken();
      if (token != null) {
        headers["Authorization"] = token;
      }
    }
    try {
      final res = await http.put(Uri.encodeFull(url), headers: headers, body: json.encode(body)).timeout(
          const Duration(
            seconds: 50,
          ), onTimeout: () {
        throw RequestTimeOutException("Poor internet or no internet connectivity");
      });
      var dataRetrived = _returnResponse(res);
      return dataRetrived;
    } on SocketException {
      return [];
    }
  }

  _returnResponse(http.Response response) {
    print(response.statusCode);
    // print(response.headers);
    print(response.body);
    print(response.request);
    switch (response.statusCode) {
      case 201:
      case 200:
        final responseBody = json.decode(response.body);
        return responseBody;
      case 204:
        return [];
      case 400:
        throw BadRequestException("Server error please try again later.");
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw BadRequestException("Internal server error, please try again later");
      case 422:
        throw UnprocessableEntity(response.body.toString());
      case 500:
        throw ServerErrorException(response.statusCode);
      case 503:
        break;
      default:
        throw FetchDataException(
          "Error occured while communicating with Server with StatusCode : ${response.statusCode}",
        );
    }
  }
}
