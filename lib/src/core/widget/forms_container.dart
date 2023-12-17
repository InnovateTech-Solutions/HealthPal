import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthpal/src/config/theme/theme.dart';

GestureDetector formscontainer(
    {required String title, required Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: AppColor.buttonColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 221, 212, 212).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Center(
        child: Text(title,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColor.mainAppColor))),
      ),
    ),
  );
}

GestureDetector formscontainerr(
    {required String title, required Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 221, 212, 212).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Center(
        child: Text(title,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColor.mainAppColor))),
      ),
    ),
  );
}
