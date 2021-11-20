import 'package:flutter/material.dart';

import '../../res.dart';

class AppTextField extends StatefulWidget {
  String hint, value,msg;
  int length;
  TextEditingController textEditingController;
  TextInputType inputType;
  bool isSecure, isError, isShowIcon;

  AppTextField(this.textEditingController,
      {this.isShowIcon = false,
      this.isError = false,
      this.hint = "",
      this.msg = "",
      this.value = "",
      this.length = 50,
      this.inputType = TextInputType.text,
      this.isSecure = false});

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 45,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: AppColors.color_white,
            border: Border.all(
              color: AppColors.color_black_text,
              width: 1,
            ),
          ),
          child:
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hint,
                      contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                      hintStyle: new TextStyle(color: AppColors.color_grey_text),
                      counterText: "",
                    ),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.color_black_text,
                    ),
                    maxLines: 1,
                    maxLength: widget.length,
                    controller: widget.textEditingController,
                    keyboardType: widget.inputType,
                    obscureText: widget.isSecure,
                  )),
              SizedBox(
                width: 5,
              ),
              widget.isShowIcon
                  ? Icon(
                widget.isError ? Icons.error : Icons.check_circle,
                color: widget.isError
                    ? AppColors.color_red
                    : AppColors.color_green,
              )
                  : SizedBox(),
              SizedBox(
                width: 5,
              ),
            ],
          ),



        ),
        widget.isShowIcon
            ? Padding(padding: EdgeInsets.only(right: 30),
        child: Text(
          "${widget.msg}",
          style: TextStyle(
              fontSize: AppDimension.size10,
              color: AppColors.color_red,
              fontWeight: AppFontWeight.REGULAR),
        ),)
            : SizedBox(),
      ],
    )

      ;
  }
}
