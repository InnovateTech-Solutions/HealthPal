// ignore_for_file: avoid_print, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DocDashboardController extends GetxController {
  late RxList<DocumentSnapshot<Map<String, dynamic>>> bookings;

  @override
  void onInit() {
    super.onInit();
    bookings = <DocumentSnapshot<Map<String, dynamic>>>[].obs;
    // fetchBookingsForDoctor('');
  }

  void fetchBookingsForDoctor(String docEmail) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('Bookings')
          .where('docEmail', isEqualTo: docEmail)
          .get();

      bookings.assignAll(result.docs);
    } catch (error) {
      print('Error fetching bookings: $error');
    }
  }

  void filterBookings(String docEmail, String status) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('Bookings')
          .where('docEmail', isEqualTo: docEmail)
          .where('status', isEqualTo: status)
          .get();

      bookings.assignAll(result.docs);
    } catch (error) {
      print('Error fetching bookings: $error');
    }
  }

  Future<void> updateStatus(String status, String bookignId) async {
    await FirebaseFirestore.instance
        .collection("Bookings")
        .doc(bookignId)
        .get()
        .then((bookingDoc) {
      if (bookingDoc.exists) {
        bookingDoc.reference.update({'status': status});
        Get.back();
      } else {
        print('Document with ID $bookignId does not exist.');
      }
    });
  }
}
