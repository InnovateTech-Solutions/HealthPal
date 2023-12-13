import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthpal/src/config/theme/theme.dart';

class TextWidget {
  static Text mainAppText(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              color: AppColor.buttonColor,
              fontWeight: FontWeight.bold,
              fontSize: 20)),
    );
  }

  static Text subAppText(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              color: AppColor.buttonColor,
              fontWeight: FontWeight.w400,
              fontSize: 12)),
    );
  }

  static loadingText(String title) {
    return Center(
      child: Text(title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColor.buttonColor))),
    );
  }

  static dashoboardMainText(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColor.buttonColor,
              fontSize: 20)),
    );
  }

  static widgetsText(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.buttonColor,
              fontSize: 14)),
    );
  }

  static widgetsubText(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColor.buttonColor,
              fontSize: 14)),
    );
  }

  static dateText(String title) {
    return Text(title,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.buttonColor)));
  }

  static selectTest(String title) {
    return Text(title,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColor.mainAppColor)));
  }
}
