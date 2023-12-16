import 'package:flutter/material.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';

Widget historyCard(
    {required String status,
    required String patientEmail,
    required String date,
    required String time}) {
  return Container(
    width: double.infinity,
    height: 150,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2)),
        ]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget.widgetsubText('Patient Email : $patientEmail '),
        TextWidget.widgetsubText('Date : $date'),
        TextWidget.widgetsubText('Time : $time'),
        TextWidget.widgetsubText('status : $status'),
      ],
    ),
  );
}
