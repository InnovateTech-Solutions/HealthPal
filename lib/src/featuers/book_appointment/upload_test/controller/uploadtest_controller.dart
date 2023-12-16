// ignore_for_file: avoid_print

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/model/booking_model.dart';
import 'package:healthpal/src/core/usecase/appointment/appointment_controller.dart';
import 'package:healthpal/src/featuers/nav_bar/nav_bar.dart';

class UploadTestController extends GetxController {
  RxString imagePath = ''.obs;
  Rx<PlatformFile?> selectedFile = Rx<PlatformFile?>(null);

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      selectedFile.value = result.files.single;
      imagePath.value = result.files.single.path!;
    }
  }

  Future<void> saveToFirebase(
      {required String docEmail,
      required String date,
      required String time,
      required String userEmail}) async {
    try {
      if (selectedFile.value == null) {
        // Handle case where no file is selected
        return;
      }
      String imageFileName =
          'user_${DateTime.now().millisecondsSinceEpoch}.jpg'; // Change file extension to jpg or preferred image format
      await firebase_storage.FirebaseStorage.instance
          .ref('images/$imageFileName') // Change folder to images
          .putFile(File(imagePath.value));

      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('images/$imageFileName')
          .getDownloadURL();

      bool code = await BookingController().createBooking(Booking(
          docEmail: docEmail,
          date: date,
          time: time,
          userEmail: userEmail,
          testImg: downloadURL,
          note: 'note',
          status: 'Upcoming'));

      // Reset form fields
      imagePath.value = '';
      selectedFile.value = null;

      if (code) {
        Get.snackbar("Sucess ", "Booking success",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppColor.mainAppColor,
            backgroundColor: AppColor.success);
        Get.offAll(const MainPage());
      } else {
        Get.snackbar("ERROR ", "the appointment is already booked",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppColor.mainAppColor,
            backgroundColor: AppColor.error);
      }
    } catch (e) {
      print('Error: $e');

      Get.snackbar("ERROR ", "$e",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColor.mainAppColor,
          backgroundColor: AppColor.error);
    }
  }

  void deleteSelectedFile() {
    if (selectedFile.value != null) {
      selectedFile.value = null;
      imagePath.value = '';
    }
  }
}
