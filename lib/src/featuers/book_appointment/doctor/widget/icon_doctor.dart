import 'package:flutter/material.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';

Column iconDoctor(
    {required IconData iconData,
    required String title,
    required String number}) {
  return Column(
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColor.buttonColor,
        ),
        child: Center(
          child: Icon(
            iconData,
            color: AppColor.mainAppColor,
            size: 30,
          ),
        ),
      ),
      TextWidget.widgetsubText(number),
      TextWidget.widgetsubText(title)
    ],
  );
}
