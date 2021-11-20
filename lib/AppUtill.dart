import 'dart:convert';
import 'dart:math';

import 'package:bluestack_assignment/res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtill {
  static printAppLog(String msg) {
    debugPrint(msg, wrapWidth: 1024);
  }

  static void LogPrint(Object object) async {
    int defaultPrintLength = 800;
    if (object == null || object
        .toString()
        .length <= defaultPrintLength) {
      print(object);
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
      }
    }
  }

  static bool isValid(var str)
  {
    if(str==null||str.toString().trim().length==0||str=="null")
      {
        return false;
      }
    return true;
  }

  static printClass(classObj) {
    AppUtill.printAppLog('printClass = ${jsonEncode(classObj)}');
  }

  static double getSize(double size, double percent) {
    size = size * percent / 100;
    return size;
  }

  // static showToast(String msg,context, {int duration=3, required int gravity}) {
  //   Toast.show(msg, context, duration: duration, gravity: gravity);
  // }




  static Color getColorFromString(String hexString, String opacity) {
    if (hexString.contains("#")) {
      hexString = hexString.replaceAll("#", opacity);
      return Color(int.parse(hexString, radix: 16));
    }
    return AppColors.color_white;
  }


  static int getRandom({int min = 0, int max = 100}) {
    Random rnd;
    rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    print("$r is in the range of $min and $max");
    return r;
  }

  static String ordinalNo(int value) {

    List sufixes = ["th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th"];
    switch (value % 100) {
    case 11:
    case 12:
    case 13:
    return"${value}th";
    default:
    return "${value}${sufixes[value % 10]}";

    }
  }

  static int toInteger(double number) {
    return number.toInt();
  }

  static getTrimString(double value) {
    if (value != null) {
      return value.toStringAsFixed(2);
    } else {
      return "${value}";
    }
  }


  // static openLoading(context) {
  //   AppDialog.showCircularProgressBarAlertDialog(context);
  // }

  static roundOffPrice(var price)
  {
    if(price==null)
      {
        price=0.0;
      }
    return price.toStringAsFixed(0);
  }

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static bool isValidMobileNo(String phoneNo)
  {
    RegExp validPhoneNumberRegExp = new RegExp(
      r"^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$",
      caseSensitive: false,
      multiLine: false,
    );

    return validPhoneNumberRegExp.hasMatch(phoneNo);
  }

  static bool isValidPanNo(String PANNo)
  {
    if(PANNo.length==15)
      {
        PANNo=PANNo.substring(2,PANNo.length-3);
      }
    RegExp validPANRegExp = new RegExp(
      r"^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$",
      caseSensitive: false,
      multiLine: false,
    );

    return validPANRegExp.hasMatch(PANNo);
  }

  static bool isValidEmail(String email)
  {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static void hideKeyboard(BuildContext context)
  {
    FocusScope.of(context).unfocus();
  }



}
