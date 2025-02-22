import 'package:flutter/material.dart';
import 'package:mvvm_architecture/routes/route.dart';
import 'package:mvvm_architecture/routes/routesNames.dart';
import 'package:mvvm_architecture/utils/Colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: darkBlue),
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
