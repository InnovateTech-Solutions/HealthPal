import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthpal/test/test.dart';
import 'package:image_picker/image_picker.dart';

class Booking {
  String date;
  String time;
  String userEmail;
  String doctorName;
  String testUrl;

  Booking({
    required this.date,
    required this.time,
    required this.userEmail,
    required this.doctorName,
    required this.testUrl,
  });
}

class BookingController extends GetxController {
  RxList<Booking> bookings = <Booking>[].obs;

  void addBooking(Booking booking) {
    bookings.add(booking);
  }
}

Future<String?> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return pickedFile.path;
  } else {
    return null;
  }
}

Future<String> uploadImageToStorage(String imagePath) async {
  Reference ref = FirebaseStorage.instance
      .ref()
      .child('images/${DateTime.now().toString()}');
  UploadTask uploadTask = ref.putFile(File(imagePath));
  TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  return downloadUrl;
}

Future<void> saveBookingToFirestore(Booking booking) async {
  await FirebaseFirestore.instance.collection('Bookings').add({
    'date': booking.date,
    'time': booking.time,
    'userEmail': booking.userEmail,
    'doctorName': booking.doctorName,
    'testUrl': booking.testUrl,
  });
}

// Assuming you have a StatefulWidget
class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookingController bookingController = Get.put(BookingController());

  Future<void> submitBooking() async {
    // Get other booking details (date, time, userEmail, doctorName)
    String? imagePath = await pickImage();
    String imageUrl = await uploadImageToStorage(imagePath ?? '');

    Booking booking = Booking(
      date: '...',
      time: '...',
      userEmail: '...',
      doctorName: '...',
      testUrl: imageUrl,
    );

    bookingController.addBooking(booking);
    await saveBookingToFirestore(booking);
    Get.to(TestPage(imageUrl: imageUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: submitBooking,
          child: Text('Submit Booking'),
        ),
      ),
    );
  }
}
