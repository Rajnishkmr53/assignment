import 'package:flutter/material.dart';

import '../../res.dart';

class AppTextWidget extends StatelessWidget {
  String title;
  AppTextWidget(this.title);
  @override
  Widget build(BuildContext context) {
    return Text(
        title,
      style: TextStyle(
          fontSize: AppDimension.size18,
          color: AppColors.color_black_text,
          fontFamily: AppFonts.app_font_family,
          fontWeight: AppFontWeight.BOLD),
    );
  }
}
