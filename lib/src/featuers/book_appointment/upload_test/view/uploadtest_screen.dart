import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/book_appointment/upload_test/controller/uploadtest_controller.dart';

class UploadTestScreen extends StatelessWidget {
  const UploadTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pdfController = Get.put(UploadTestController());
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
            GestureDetector(
              onTap: () {
                // pdfController.pickPDF();
              },
              child: Container(
                height: 125,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.subappcolor),
                  color: const Color.fromARGB(255, 225, 254, 226),
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
                      if (pdfController.selectedFile.value == null) {
                        return Center(
                          child: Column(
                            children: [
                              const Gap(10),
                              TextWidget.subAppText('Add your proof')
                            ],
                          ),
                        ); // Empty container when no file is selected
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              width: 90,
                              height: 65,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://cdn-icons-png.flaticon.com/512/3997/3997608.png'))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () => {pdfController.pickPDF()},
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () =>
                                        {pdfController.deleteSelectedFile()},
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
          ],
        ),
      ),
    );
  }
}
