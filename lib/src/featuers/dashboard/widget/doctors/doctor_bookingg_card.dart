import 'package:flutter/material.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';

GestureDetector doctorBookingsCard(
  BuildContext context, {
  required String image,
  required String status,
  required String patientEmail,
  required String date,
  required String time,
}) {
  return GestureDetector(
    onTap: () => DialogsHelp._showMyDialog(
        context: context, imgTest: image, status: status),
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
      required String imgTest,
      required String status}) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextWidget.mainAppText('Patient Test'),
          content: Column(
            children: [
              // Your image widget
              Image.network(imgTest, height: 250, width: 150),
              StatusDropdown(status: status)
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Handle 'Save' button click
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                // Handle 'Cancel' button click
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class StatusDropdown extends StatefulWidget {
  const StatusDropdown({required this.status, super.key});
  final String status;
  @override
  _StatusDropdownState createState() => _StatusDropdownState();
}

class _StatusDropdownState extends State<StatusDropdown> {
  late String selectedStatus = widget.status; // Default status

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedStatus,
      onChanged: (String? newValue) {
        setState(() {
          selectedStatus = newValue!;
        });
      },
      items: <String>['Pending', 'In Progress', 'Completed']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
