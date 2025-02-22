import 'package:mvvm_architecture/%20Models/Services/Network_Service.dart';
import 'package:mvvm_architecture/%20Models/models/User_List.dart';

class AppRepository {
  final BaseApiService _apiService = NetworkServiceApi();

  String baseUrl = 'https://reqres.in';

  Future<dynamic> userLogin(dynamic data) async {
    var response = await _apiService.postApi("$baseUrl${"/api/login"}", data);

    try {
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserList?> userList() async {
    try {
      var response = await _apiService.getApi("$baseUrl/api/users?page=2");

      print("Raw API Response: $response");
      return UserList.fromJson(response); // No need for "response ="
    } catch (e) {
      print("Error: ${e.toString()}");
      return null;
    }
  }
}
