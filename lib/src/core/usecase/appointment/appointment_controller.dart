import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/model/booking_model.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();
  RxList bookedTimelist = [].obs;
  RxList timeList = [].obs;


  Future<bool> isTimeSlotAvailable(Booking booking) async {
    final firestore = FirebaseFirestore.instance;
    final bookingsCollection = firestore.collection('Bookings');
    final bookingQuery = await bookingsCollection
        .where('docEmail', isEqualTo: booking.docEmail)
        .where('date', isEqualTo: booking.date)
        .where('time', isEqualTo: booking.time)
        .get();
    print(bookingQuery.docs.isEmpty);

    return bookingQuery.docs.isEmpty;
  }

  Future<void> createBooking(Booking booking) async {
    final isAvailable = await isTimeSlotAvailable(booking);

    if (isAvailable) {
      final firestore = FirebaseFirestore.instance;
      final bookingsCollection = firestore.collection('Bookings');
      await bookingsCollection.add(booking.toMap());
      timeList.remove(booking.time);
    } else {
      print('Chosen time slot is not available');
    }
  }




}
