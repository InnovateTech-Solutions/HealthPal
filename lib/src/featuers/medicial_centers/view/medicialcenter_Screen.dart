import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/medicial_centers/widget/list_doctors.dart';
import 'package:healthpal/src/featuers/medicial_centers/widget/medicialcenter_card.dart';

class MedicialCenterScreen extends StatefulWidget {
  const MedicialCenterScreen(
      {required this.medicialCenter,
      required this.imgname,
      required this.address,
      required this.review,
      super.key});
  final String medicialCenter;
  final String imgname;
  final String address;
  final String review;
  @override
  State<MedicialCenterScreen> createState() => _MedicialCenterScreenState();
}

class _MedicialCenterScreenState extends State<MedicialCenterScreen> {
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
        title: TextWidget.mainAppText('medicial center Details'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(30),
            medicialCard(
                name: widget.medicialCenter,
                address: widget.address,
                review: widget.review,
                imgname: widget.imgname),
            const Gap(20),
            DoctorList(
              medicial: widget.medicialCenter,
            )
          ],
        ),
      ),
    );
  }
}
