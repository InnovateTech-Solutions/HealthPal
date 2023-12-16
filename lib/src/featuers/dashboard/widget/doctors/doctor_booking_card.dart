// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/dashboard/controller/docdashboard_controller.dart';
import 'package:healthpal/src/featuers/user_history/view/booking_history.dart';

GestureDetector doctorBookingsCard(
  BuildContext context, {
  required String id,
  required String image,
  required String status,
  required String patientEmail,
  required String date,
  required String time,
}) {
  return GestureDetector(
    onTap: () => DialogsHelp._showMyDialog(
        context: context,
        imgTest: image,
        status: status,
        id: id,
        userEmail: patientEmail),
    child: Container(
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
    ),
  );
}

class DialogsHelp {
  static Future<void> _showMyDialog(
      {required BuildContext context,
      required String userEmail,
      required String id,
      required String imgTest,
      required String status}) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextWidget.mainAppText('Patient Test'),
          content: Column(
            children: [
              Image.network(imgTest, height: 250, width: 150),
              // StatusDropdown(status: status)
              DropdownExample(
                status: status,
                id: id,
              ),

              TextButton(
                onPressed: () {
                  Get.to(BookingHistoryScreen(
                    userEmail: userEmail,
                  ));
                },
                child: const Text('See user History'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DropdownExample extends StatefulWidget {
  const DropdownExample({required this.status, required this.id, super.key});
  final String status;
  final String id;
  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  late String selectedValue = widget.status; // Default selected value

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DocDashboardController());
    return SizedBox(
      width: 150,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          TextWidget.widgetsubText('update the status'),
          DropdownButton<String>(
            value: selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
              });
            },
            items: <String>['Upcoming', 'cancel', 'coming']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  controller.updateStatus(selectedValue, widget.id);
                },
                child: const Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  // Handle 'Cancel' button click
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
