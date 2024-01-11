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

    Future<void> getTimeList(String enteredDate, String docEmail) async {
    final CollectionReference bookingsCollection =
        FirebaseFirestore.instance.collection('Bookings');

    QuerySnapshot querySnapshot = await bookingsCollection
        .where('docEmail', isEqualTo: docEmail)
        .where('date', isEqualTo: enteredDate)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        final time = doc['time'];
        if (!bookedTimelist.contains(time)) bookedTimelist.add(time);
      });
    }
//  print("bookedTimelist:   ${bookedTimelist}");
  }

  Future<void> generateTimeList(
      String timeRange, String date, String vendor) async {
    final parts = timeRange.split(' -');

    if (parts.length != 2) {
      print("error: start and end time should be specified");
      return;
    }
    final startTime = parts[0];
    final endTime = parts[1];

    final startHour = int.parse(startTime.split(':')[0]);
    final startMinute = int.parse(startTime.split(':')[1]);
    final endHour = int.parse(endTime.split(':')[0]);
    final endMinute = int.parse(endTime.split(':')[1]);
    DateTime currentTime = DateTime(2023, 1, 1, startHour, startMinute);
    await getTimeList(date, vendor);
    print(date);
    print("bookedTimelist: ${bookedTimelist}");

    while (currentTime.hour < endHour ||
        (currentTime.hour == endHour && currentTime.minute <= endMinute)) {
      final time = 
        '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}';

      if (!bookedTimelist.contains(time) && !timeList.contains(time)) {
        timeList.add(time);

        print("Checking time: $time");
      }

      currentTime =
          currentTime.add(Duration(minutes: 30)); 
    }

    print("timeList: ${timeList}");
  }
}
