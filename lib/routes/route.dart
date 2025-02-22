import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_architecture/routes/routesNames.dart';
import 'package:mvvm_architecture/view_model/Login_Provider.dart';
import 'package:mvvm_architecture/views/HomeScreen.dart';
import 'package:mvvm_architecture/views/splashscreen.dart';
import 'package:mvvm_architecture/views/LoginScreen.dart';
import 'package:provider/provider.dart'; // Import LoginScreen

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RouteName.logInScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder:
              (context) => ChangeNotifierProvider(
                create: (BuildContext context) => LogInProvider(),
                child: LoginScreen(args: args),
              ),
        );

      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => Homescreen());

      default:
        return MaterialPageRoute(
          builder:
              (context) => const Scaffold(
                body: Center(child: Text('Something went Wrong')),
              ),
        );
    }
  }
}
