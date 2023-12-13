import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/usecase/authentication/authentication.dart';
import 'package:healthpal/src/core/widget/forms_container.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/book_appointment/upload_test/controller/uploadtest_controller.dart';

class UploadTestScreen extends StatelessWidget {
  const UploadTestScreen(
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
      required this.date,
      required this.time,
      super.key});
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
  final String time;
  final String date;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadTestController());
    final authRepo = Get.put(Authentication());

    late final email = authRepo.firebaseUser.value?.email;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        elevation: 1,
        backgroundColor: AppColor.subappcolor,
        title: TextWidget.mainAppText('Upalod Test'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget.mainAppText('Uplaod YOUR Test '),
            const Gap(60),
            GestureDetector(
              onTap: () {
                controller.pickImage();
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.subappcolor),
                  color: AppColor.buttonColor,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      if (controller.selectedFile.value == null) {
                        return Center(
                          child: Column(
                            children: [
                              const Gap(60),
                              TextWidget.selectTest('please add image')
                            ],
                          ),
                        ); // Empty container when no file is selected
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Gap(30),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              width: 90,
                              height: 100,
                              child: Image.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Picture_icon_BLACK.svg/1200px-Picture_icon_BLACK.svg.png'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () => {controller.pickImage()},
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () =>
                                        {controller.deleteSelectedFile()},
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ],
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
            const Gap(15),
            formscontainer(
                title: 'make the appointment',
                onTap: () => controller.saveToFirebase(
                    docEmail: doctorEmail,
                    date: date,
                    time: time,
                    userEmail: email ?? ''))
          ],
        ),
      ),
    );
  }
}
