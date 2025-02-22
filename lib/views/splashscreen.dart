import 'package:flutter/material.dart';
import 'package:mvvm_architecture/appStore/App_Store.dart';
import 'package:mvvm_architecture/routes/routesNames.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = "";
  void _getToken() async {
    String storedToken = await AppStore().getUserToken();
    setState(() {
      token = storedToken;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (token.isEmpty) {
        Navigator.pushReplacementNamed(
          context,
          RouteName.logInScreen,
          arguments: {'title': 'Login'},
        );
      } else {
        Navigator.pushReplacementNamed(context, RouteName.homeScreen);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getToken();
  }
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          child: Image.asset('assets/splash_screen_image.gif'),
        ),
      ),
    );
  }
}
