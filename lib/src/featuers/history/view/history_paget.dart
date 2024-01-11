import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/featuers/history/controller/histroy_controller.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Bookings'),
      ),
      body: const BookingsList(),
    );
  }
}

class BookingsList extends GetView<HistoryController> {
  const BookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HistoryController());
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('Bookings').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<QueryDocumentSnapshot<Map<String, dynamic>>> bookings =
              snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> bookingData = bookings[index].data();

              // Customize the display as per your data structure
              return GestureDetector(
                onTap: () => controller.showRatingDialog(context, bookingData),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date :${bookingData['date']}"),
                      const Gap(10),
                      Text("Time :${bookingData['time']}"),
                      const Gap(10),
                      Text("Doctor Email : ${bookingData['docEmail']}"),
                      const Gap(10),
                      Text("status :${bookingData['status']}"),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
