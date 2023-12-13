import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/book_appointment/appointment/controller/date_controller.dart';
import 'package:healthpal/src/featuers/book_appointment/upload_test/view/uploadtest_screen.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen(
      {required this.experince,
      required this.doctorEmail,
      required this.doctorname,
      required this.imgname,
      required this.ratingNumber,
      required this.ratingLength,
      required this.medicialcenter,
      required this.description,
      required this.workingHours,
      required this.address,
      required this.patients,
      Key? key})
      : super(key: key);
  final String doctorEmail;

  final String doctorname;
  final String imgname;
  final String ratingNumber;
  final String ratingLength;
  final String medicialcenter;
  final String experince;
  final String description;
  final String workingHours;
  final String address;
  final String patients;
  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainAppColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextWidget.mainAppText(
                'Calendar Timeline',
              ),
            ),
            CalendarTimeline(
              showYears: true,
              initialDate: _selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
              onDateSelected: (date) => setState(() => _selectedDate = date),
              leftMargin: 10,
              monthColor: AppColor.textFiledcolor,
              dayColor: AppColor.buttonColor,
              dayNameColor: const Color(0xFF333A47),
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              dotsColor: const Color(0xFF333A47),
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'en',
            ),
            const SizedBox(height: 20),
            Expanded(
                child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                indent: 20.0,
                endIndent: 10.0,
                thickness: 1,
                color: AppColor.buttonColor,
              ),
              itemCount: DateController().timeList.length,
              itemBuilder: (context, index) {
                List<String> parts = _selectedDate.toString().split(' ');
                String datePart = parts[0];
                return ListTile(
                    title: GestureDetector(
                  onTap: () => Get.to(UploadTestScreen(
                    doctorname: widget.doctorname,
                    imgname: widget.imgname,
                    ratingNumber: widget.ratingNumber,
                    ratingLength: widget.ratingNumber,
                    medicialcenter: widget.medicialcenter,
                    experince: widget.experince,
                    description: widget.description,
                    address: widget.address,
                    workingHours: widget.workingHours,
                    patients: widget.patients,
                    date: datePart.toString(),
                    time: DateController().timeList[index],
                    doctorEmail: widget.doctorEmail,
                  )),
                  child: TextWidget.dateText(DateController().timeList[index]),
                ));
              },
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
