import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/widget/forms_container.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/book_appointment/doctor/widget/doctor_card.dart';
import 'package:healthpal/src/featuers/book_appointment/doctor/widget/icon_doctor.dart';

class DoctorScrenn extends StatefulWidget {
  const DoctorScrenn({
    super.key,
    // required this.experince,
    // required this.doctorname,
    // required this.imgname,
    // required this.ratingNumber,
    // required this.ratingLength,
    // required this.medicialcenter
  });
  // final String doctorname;
  // final String imgname;
  // final String ratingNumber;
  // final String ratingLength;
  // final String medicialcenter;
  // final String experince;

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
            doctorCard(),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                iconDoctor(),
                iconDoctor(),
                iconDoctor(),
              ],
            ),
            const Gap(20),
            TextWidget.mainAppText('about me'),
            const Gap(20),
            TextWidget.widgetsubText(
                'Dr. David Patel, a dedicated cardiologist, brings a wealth of experience to Golden Gate Cardiology Center in Golden Gate, CA'),
            const Gap(20),
            TextWidget.mainAppText('Working Hours'),
            const Gap(20),
            TextWidget.subAppText('Monday-Friday, 08.00 AM-18.00 pM'),
            Expanded(child: Container()),
            formscontainer(title: 'Book appointment ', onTap: () => null)
          ],
        ),
      ),
    );
  }
}
