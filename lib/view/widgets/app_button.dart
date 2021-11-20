import 'package:flutter/cupertino.dart';

import '../../res.dart';

class AppButton extends StatelessWidget {
  // Size _size;
  double width;
  String title;
  Color color;
  Color disabledColor;
  Color textColor;
  bool isEnabled;
  Function onClickButton;

  AppButton(this.title,
      {required this.onClickButton,
      this.isEnabled = true,
      this.width = 100,
      this.disabledColor = AppColors.color_grey_text,
      this.color = AppColors.primary_color,
      this.textColor = AppColors.color_white});

  @override
  Widget build(BuildContext context) {
    // _size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        height: 40,
        width: width,
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(
              const Radius.circular(50.0),
            ),
            color: isEnabled ? color : disabledColor),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: AppDimension.size14,
                color: textColor,
                fontWeight: AppFontWeight.MEDIUM),
            maxLines: 1,
          ),
        ),
      ),
      onTap: () {
        if (isEnabled) onClickButton();
      },
    );
  }
}
