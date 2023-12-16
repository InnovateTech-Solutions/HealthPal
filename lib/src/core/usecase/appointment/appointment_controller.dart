// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/model/booking_model.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();
  RxList bookedTimelist = [].obs;
  RxList timeList = [].obs;
  late RxList<DocumentSnapshot<Map<String, dynamic>>> allbookings;
  @override
  void onInit() {
    super.onInit();
    allbookings = <DocumentSnapshot<Map<String, dynamic>>>[].obs;
  }

  Future<bool> isTimeSlotAvailable(Booking booking) async {
    final firestore = FirebaseFirestore.instance;
    final bookingsCollection = firestore.collection('Bookings');
    List<String> parts = booking.date.split(' ');
    String datePart = parts[0];
    final bookingQuery = await bookingsCollection
        .where('docEmail', isEqualTo: booking.docEmail)
        .where('date', isEqualTo: datePart)
        .where('time', isEqualTo: booking.time)
        .get();
    print(bookingQuery.docs.isEmpty);

    return bookingQuery.docs.isEmpty;
  }

  Future<bool> createBooking(Booking booking) async {
    final isAvailable = await isTimeSlotAvailable(booking);

    if (isAvailable) {
      final firestore = FirebaseFirestore.instance;
      final bookingsCollection = firestore.collection('Bookings');
      await bookingsCollection.add(booking.toMap());
      timeList.remove(booking.time);
      return true;
    } else {
      print('Chosen time slot is not available');
      return false;
    }
  }

  void fetchBookingsForUser(String userEmail) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('Bookings')
          .where('userEmail', isEqualTo: userEmail)
          .get();

      allbookings.assignAll(result.docs);
    } catch (error) {
      print('Error fetching bookings: $error');
    }
  }
}
