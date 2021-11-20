import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AppUtill.dart';
import '../res.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Size _size;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: AppColors.color_white,
        child: Center(
          child: Image.asset(Res.logo_game_tv),
        ),
      ),
    );
  }

  @override
  void initState() {
    _prefs.then((SharedPreferences prefs) {
      Timer(Duration(seconds: 5), () {
        AppUtill.printAppLog("isLogin == ");

        if (prefs.getBool(Keys.IS_LOGIN)!=null && prefs.getBool(Keys.IS_LOGIN)==true) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed('/home');
        } else {
          Navigator.pop(context);
          Navigator.of(context).pushNamed('/login');
        }
      });
    });


    super.initState();
  }

  void dispose() {
    super.dispose();
  }

}
