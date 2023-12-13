import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/widget/forms_container.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/book_appointment/appointment/view/appointment_screen.dart';
import 'package:healthpal/src/featuers/book_appointment/doctor/widget/doctor_card.dart';
import 'package:healthpal/src/featuers/book_appointment/doctor/widget/icon_doctor.dart';

class DoctorScrenn extends StatefulWidget {
  const DoctorScrenn(
      {super.key,
      required this.doctorEmail,
      required this.experince,
      required this.doctorname,
      required this.imgname,
      required this.ratingNumber,
      required this.ratingLength,
      required this.medicialcenter,
      required this.description,
      required this.workingHours,
      required this.address,
      required this.patients});
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
  State<DoctorScrenn> createState() => _DoctorScrennState();
}

class _DoctorScrennState extends State<DoctorScrenn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        elevation: 1,
        backgroundColor: AppColor.subappcolor,
        title: TextWidget.mainAppText('Doctor Details'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            doctorCard(
                name: widget.doctorname, medicialCenter: widget.medicialcenter),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                iconDoctor(
                    iconData: Icons.people,
                    title: 'patinets',
                    number: widget.patients),
                iconDoctor(
                    iconData: Icons.star_purple500_outlined,
                    title: 'reviews',
                    number: widget.ratingNumber),
                iconDoctor(
                    iconData: Icons.badge,
                    title: 'experince',
                    number: widget.experince),
              ],
            ),
            const Gap(20),
            TextWidget.mainAppText('about me'),
            const Gap(20),
            TextWidget.widgetsubText(widget.description),
            const Gap(20),
            TextWidget.mainAppText('Working Hours'),
            const Gap(20),
            TextWidget.subAppText('Monday-Friday, ${widget.workingHours}'),
            Expanded(child: Container()),
            formscontainer(
                title: 'Book appointment ',
                onTap: () => Get.to(AppointmentScreen(
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
                      doctorEmail: widget.doctorEmail,
                    )))
          ],
        ),
      ),
    );
  }
}
