import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/usecase/appointment/appointment_controller.dart';
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
  final bookingController = Get.put(BookingController());
  @override
  void initState() {
    super.initState();
    RxString defaultDate = (DateTime.now()).toString().obs;
    List<String> parts = defaultDate.value.split(' ');
    String datePart = parts[0];

    bookingController.generateTimeList(
        "00:00 - 22:00", datePart, widget.doctorEmail);
  }

  @override
  Widget build(BuildContext context) {
    RxString selectedDate = (DateTime.now()).toString().obs;
    DateTime parsingDate = DateTime.parse(selectedDate.value);
    List<String> parts = selectedDate.value.split(' ');
    String datePart = parts[0];
    RxString seletedTimeStamp = ''.obs;
    return Scaffold(
      backgroundColor: AppColor.mainAppColor,
      body: SafeArea(
          child: Column(
        children: [
          TimelineCalendar(
            calendarType: CalendarType.GREGORIAN,
            calendarLanguage: "en",
            calendarOptions: CalendarOptions(
              viewType: ViewType.DAILY,
              toggleViewType: true,
              headerMonthElevation: 10,
              headerMonthShadowColor: Colors.black26,
              headerMonthBackColor: Colors.transparent,
            ),
            dayOptions: DayOptions(
                selectedBackgroundColor: AppColor.textFiledcolor!,
                compactMode: true,
                weekDaySelectedColor: AppColor.textFiledcolor!,
                disableDaysBeforeNow: true),
            headerOptions: HeaderOptions(
                weekDayStringType: WeekDayStringTypes.SHORT,
                monthStringType: MonthStringTypes.FULL,
                backgroundColor: AppColor.mainAppColor,
                headerTextColor: AppColor.textFiledcolor!,
                resetDateColor: AppColor.textFiledcolor!,
                calendarIconColor: AppColor.textFiledcolor!,
                navigationColor: AppColor.textFiledcolor!),
            onChangeDateTime: (datetime) {
              RxString selectedDate1 = (datetime.getDate()).toString().obs;
              List<String> parts1 = selectedDate1.value.split(' ');
              datePart = parts1[0];
              print(datePart);

              bookingController.timeList.clear();
              bookingController.bookedTimelist.clear();
              bookingController.generateTimeList(
                  "00:00 - 22:00", datePart, widget.doctorEmail);
            },
          ),
          Obx(() => bookingController.timeList.isEmpty
              ? Container(
                  child: Center(
                    child: Text('All Day is booked selecet another day'),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                            indent: 20.0,
                            endIndent: 10.0,
                            thickness: 1,
                            color: AppColor.textFiledcolor,
                          ),
                      itemCount: bookingController.timeList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  Get.to(UploadTestScreen(
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
                                    date:
                                        datePart, // Remove the .toString() here
                                    time: bookingController.timeList[index],
                                    doctorEmail: widget.doctorEmail,
                                  )),
                                },
                                child: Text(
                                  bookingController.timeList[index],
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.textFiledcolor!,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })))
        ],
      )),
    );
  }
}
