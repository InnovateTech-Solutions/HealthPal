import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthpal/src/core/usecase/authentication/authentication.dart';

class MyController extends GetxController {
  RxString email = ''.obs;
  RxString pdfPath = ''.obs;
  Rx<PlatformFile?> selectedFile = Rx<PlatformFile?>(null);

  void setEmail(String value) => email.value = value;

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

  Future<void> saveToFirebase() async {
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

      await FirebaseFirestore.instance.collection('userspdf').add({
        'email': email.value,
        'pdfPath': downloadURL,
      });

      // Reset form fields
      email.value = '';
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

class MyForm extends StatelessWidget {
  const MyForm({super.key});

  @override
  Widget build(BuildContext context) {
    final MyController controller = Get.put(MyController());
    final authRepo = Get.put(Authentication());

    final email = authRepo.firebaseUser.value?.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(email ?? ''),
            TextField(
              onChanged: (value) => controller.setEmail(value),
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.pickPDF(),
              child: const Text('Select PDF'),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.selectedFile.value != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.grey[200],
                      child: Text(
                          'Selected PDF: ${controller.selectedFile.value!.name}'),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => controller.deleteSelectedFile(),
                          child: const Text('Clear Selected PDF'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => controller.deleteSelectedFile(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: const Text('Delete PDF'),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Container(); // Empty container when no file is selected
              }
            }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.saveToFirebase(),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
