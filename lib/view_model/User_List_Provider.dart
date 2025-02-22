import 'package:flutter/cupertino.dart';
import 'package:mvvm_architecture/%20Models/Services/Api_Response.dart';
import 'package:mvvm_architecture/%20Models/Services/App_Exception.dart';
import 'package:mvvm_architecture/%20Models/models/User_List.dart';
import 'package:mvvm_architecture/%20Models/repository/repository.dart';
import 'package:mvvm_architecture/utils/Common_Toast.dart';

class UserListProvider with ChangeNotifier {
  final _appRepository = AppRepository();

  ApiResponse<UserList> userList = ApiResponse.loading();

  setUserList(ApiResponse<UserList> response) {
    userList = response;
    notifyListeners();
  }

  Future<void> fetchUserList(BuildContext context) async {
    setUserList(ApiResponse.loading());
    try {
      final value = await _appRepository.userList();
      if (value == null) {
        throw FetchDataException(message: "Received null data from API");
      }
      print("Fetched Data: $value");
      setUserList(ApiResponse.complete(value));
    } catch (error) {
      print("Error: $error");
      CustomToast.show(context, "Something went wrong");
      setUserList(ApiResponse.error(error.toString()));
    }
  }
}
