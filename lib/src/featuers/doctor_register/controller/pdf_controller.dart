// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/model/user_model.dart';

class PdfUpload extends GetxController {
  RxString pdfPath = ''.obs;
  Rx<PlatformFile?> selectedFile = Rx<PlatformFile?>(null);

  Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      selectedFile.value = result.files.single;
      pdfPath.value = result.files.single.path!;
    }
  }

  Future<void> saveToFirebase(UserModel userModel, String medicl) async {
    try {
      if (selectedFile.value == null) {
        // Handle case where no file is selected
        return;
      }
      String pdfFileName = 'user_${DateTime.now().millisecondsSinceEpoch}.pdf';
      await firebase_storage.FirebaseStorage.instance
          .ref('pdfs/$pdfFileName')
          .putFile(File(pdfPath.value));

      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('pdfs/$pdfFileName')
          .getDownloadURL();

      await FirebaseFirestore.instance.collection('users').add({
        "Email": userModel.email,
        "Password": userModel.password,
        "PhoneNumber": userModel.phone,
        "UserName": userModel.name,
        'usertype': 'Doctor',
        'pdfPath': downloadURL,
        'status': false,
        'MedicalCenter': medicl,
        'experince': '5 yes',
        'description':
            'I am 32 years  , i have got ,Bachelors degree in General Medicine , i have 3 years of expertise  general medicine ',
        'address': 'AL-JUBEIHA',
        'Working Time': '8 am - 12 am',
        'patients': '1200',
        'rating': '5'
      });

      // Reset form fields

      pdfPath.value = '';
      selectedFile.value = null;
    } catch (e) {
      print('Error: $e');
    }
  }

  void deleteSelectedFile() {
    if (selectedFile.value != null) {
      selectedFile.value = null;
      pdfPath.value = '';
    }
  }
}
