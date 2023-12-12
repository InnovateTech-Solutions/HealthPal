import 'package:flutter/material.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';

Column iconDoctor() {
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
            Icons.people,
            color: AppColor.mainAppColor,
            size: 30,
          ),
        ),
      ),
      TextWidget.widgetsubText('2000'),
      TextWidget.widgetsubText('patients')
    ],
  );
}
