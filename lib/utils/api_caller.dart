import 'dart:io';
import "dart:async";
import 'package:http/http.dart' as http;
import "dart:convert";

import 'app_exceptions.dart';
import 'constant.dart';

class APICaller {
  var url = Constants.mainUrl;

  setUrl(String uri) {
    url = Constants.mainUrl + uri;
  }

  Future<dynamic> getData({Map<String, String> headers}) async {
    if (headers == null) {
      headers = {};
      headers["Accept"] = "application/json";
    } else {
      headers["Accept"] = "application/json";
    }
    try {
      final res = await http.get(Uri.encodeFull(url), headers: headers).timeout(
          const Duration(
            seconds: 20,
          ), onTimeout: () {
        throw RequestTimeOutException(
            "Poor internet or no internet connectivity");
      });
      var dataRetrived = _returnResponse(res);
      return dataRetrived;
    } on SocketException {
      return [];
    }
  }

  Future<dynamic> postData({Map body, Map<String, String> headers}) async {
    if (headers == null) {
      headers = {};
      headers["Accept"] = "application/json";
    } else {
      headers["Accept"] = "application/json";
    }
    if (body == null) {
      body = {};
    }
    try {
      final res = await http
          .post(Uri.encodeFull(url), headers: headers, body: body)
          .timeout(
              const Duration(
                seconds: 5,
              ), onTimeout: () {
        throw RequestTimeOutException(
            "Poor internet or no internet connectivity");
      });
      var dataRetrived = _returnResponse(res);
      return dataRetrived;
    } on SocketException {
      return [];
    }
  }

  Future<dynamic> deleteData({Map<String, String> headers}) async {
    if (headers == null) {
      headers = {};
      headers["Accept"] = "application/json";
    } else {
      headers["Accept"] = "application/json";
    }
    try {
      final res =
          await http.delete(Uri.encodeFull(url), headers: headers).timeout(
              const Duration(
                seconds: 5,
              ), onTimeout: () {
        throw RequestTimeOutException(
            "Poor internet or no internet connectivity");
      });
      var dataRetrived = _returnResponse(res);
      return dataRetrived;
    } on SocketException {
      return [];
    }
  }

  Future<dynamic> putData({Map body, Map<String, String> headers}) async {
    if (headers == null) {
      headers = {};
      headers["Accept"] = "application/json";
    } else {
      headers["Accept"] = "application/json";
    }
    if (body == null) {
      body = {};
    }
    try {
      final res = await http
          .put(Uri.encodeFull(url), headers: headers, body: body)
          .timeout(
              const Duration(
                seconds: 5,
              ), onTimeout: () {
        throw RequestTimeOutException(
            "Poor internet or no internet connectivity");
      });
      var dataRetrived = _returnResponse(res);
      return dataRetrived;
    } on SocketException {
      return [];
    }
  }

  _returnResponse(http.Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        final responseBody = json.decode(response.body);
        return responseBody;
      case 400:
        throw BadRequestException("Server error please try again later.");
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw BadRequestException(
            "Internal server error, please try again later");
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

  Future<int> returnRSC({Map<String, String> headers}) async {
    if (headers == null) {
      headers = {};
      headers["Accept"] = "application/json";
    } else {
      headers["Accept"] = "application/json";
    }
    try {
      final res = await http.get(Uri.encodeFull(url), headers: headers).timeout(
          const Duration(
            seconds: 5,
          ), onTimeout: () {
        throw RequestTimeOutException(
            "Poor internet or no internet connectivity");
      });
      return res.statusCode;
    } on SocketException {
      return -1;
    } on RequestTimeOutException {
      return -2;
    }
  }
}
