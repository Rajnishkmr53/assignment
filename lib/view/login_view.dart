import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bluestack_assignment/AppUtill.dart';
import 'package:bluestack_assignment/app_dialog.dart';
import 'package:bluestack_assignment/block/login_bloc.dart';
import 'package:bluestack_assignment/data/datbase_provider.dart';
import 'package:bluestack_assignment/model/validation_status.dart';
import 'package:bluestack_assignment/res.dart';
import 'package:bluestack_assignment/view/widgets/app_button.dart';
import 'package:bluestack_assignment/view/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginView extends StatefulWidget {
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late Size _size;
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginBloc _loginBloc = LoginBloc();



  @override
  void initState() {
    phoneCtrl.addListener(() {
      _loginBloc.userNameSink.add(phoneCtrl.text.trim());
    });

    passwordController.addListener(() {
      _loginBloc.passwordSink.add(passwordController.text.trim());
    });

    _loginBloc.loginStream.listen((isLogedin) {
      AppUtill.printAppLog("value isLogedin::${isLogedin}");

      if (isLogedin == null || !isLogedin) {
        AppDialog.showErrorDialog(context, "Invalid login details");
      }else{
        Navigator.pop(context);
        Navigator.of(context).pushNamed('/home');
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.color_white,
            body: ListView(
              children: [
                Container(
                  height: _size.height,
                  child: Center(
                      child: StreamBuilder(
                          stream: _loginBloc.validationStream,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  Res.logo_game_tv,
                                  fit: BoxFit.contain,
                                ),
                                AppTextField(
                                  phoneCtrl,
                                  hint: "Username",
                                  isShowIcon:
                                  (snapshot.data != null && snapshot.data.usernameStatus!=Status.NONE),
                                  isError: (snapshot.data != null && snapshot.data.usernameStatus==Status.ERROR),
                                  msg: (snapshot.data != null && snapshot.data.usernameStatus==Status.ERROR)?"User name should be min 3 characters and max 10":"",
                                ),
                                AppTextField(
                                  passwordController,
                                  hint: "Password",
                                  isSecure: true,
                                  isShowIcon:
                                  (snapshot.data != null && snapshot.data.passwordStatus!=Status.NONE),
                                  isError: (snapshot.data == null || snapshot.data.passwordStatus==Status.ERROR),
                                  msg: (snapshot.data == null || snapshot.data.passwordStatus==Status.ERROR)?"Password should be min 3 characters and max 10":"",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                AppButton(
                                  "Submit",
                                  onClickButton: () {
                                    _loginBloc.eventSink.add(Event.LOGIN);
                                  },
                                  isEnabled: (snapshot.data != null && snapshot.data.bothStatus==Status.VALID),
                                )
                              ],
                            );
                          })),
                )
              ],
            ),
          ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          exit(0);
        });
  }
}
