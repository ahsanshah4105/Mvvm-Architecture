import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mvvm_architecture/%20Models/Services/App_Exception.dart';

abstract class BaseApiService {
  Future<dynamic> postApi(String url, dynamic data);
  Future<dynamic> getApi(String url);
}

class NetworkServiceApi extends BaseApiService {
  @override
  Future getApi(String url) async {
    try {
      print("Making GET request to: $url");

      http.Response response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 30));

      print("Raw API Response: ${response.body}");
      return apiResponse(response);
    } catch (e) {
      throw FetchDataException(
        message: "Failed to fetch API data: ${e.toString()}",
      );
    }
  }

  @override
  Future postApi(String url, dynamic data) async {
    try {
      http.Response response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 30));
      return apiResponse(response);
    } catch (e) {
      throw FetchDataException(
        message: "Failed to post API data: ${e.toString()}",
      );
    }
  }

  dynamic apiResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);

      case 401:
        throw UnAuthorizedException(message: response.body.toString());

      default:
        throw FetchDataException(
          message: "Error during communication: ${response.statusCode}",
        );
    }
  }
}
