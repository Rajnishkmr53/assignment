import 'package:bluestack_assignment/res.dart';
import 'package:bluestack_assignment/view/home_view.dart';
import 'package:bluestack_assignment/view/login_view.dart';
import 'package:bluestack_assignment/view/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BlueStack Assignment',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: AppColors.primary_color,
          accentColor: AppColors.color_white,
          primaryColorLight: AppColors.primary_color_light,

          fontFamily: AppFonts.app_font_family,

        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashView(),
          '/login': (context) => LoginView(),
          '/home': (context) => HomeView(),
        }
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}
