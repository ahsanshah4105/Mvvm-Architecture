import 'package:flutter/cupertino.dart';
import 'package:mvvm_architecture/%20Models/repository/repository.dart';
import 'package:mvvm_architecture/appStore/App_Store.dart';
import 'package:mvvm_architecture/routes/routesNames.dart';
import 'package:mvvm_architecture/utils/Common_Toast.dart';

class LogInProvider with ChangeNotifier {
  final _appRepository = AppRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> userLogin(BuildContext context, dynamic data) async {
    setLoading(true);

    try {
      var response = await _appRepository.userLogin(data);

      if (response == null || !response.containsKey('token')) {
        CustomToast.show(context, 'Something went wrong');
      } else {
        String token = response['token'];
        AppStore().setUserToken(token);

        Navigator.pushNamed(context, RouteName.homeScreen);
      }

      print(response);
    } catch (error) {
      CustomToast.show(context, "Something went wrong");
      print(error);
    }

    setLoading(false);
  }
}
