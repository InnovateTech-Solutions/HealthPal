import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/usecase/authentication/authentication.dart';
import 'package:healthpal/src/featuers/history/controller/histroy_controller.dart';

class DoctorHistoryPage extends StatelessWidget {
  const DoctorHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('All Doctor Bookings'),
      ),
      body: const BookingsList(),
    );
  }
}

class BookingsList extends GetView<HistoryController> {
  const BookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = Get.put(Authentication());
    late final email = authRepo.firebaseUser.value?.email;
    Get.put(HistoryController());
    return FutureBuilder(
      future: fetchData(email ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> bookingData =
                  document.data() as Map<String, dynamic>;
              // Customize the display as per your data structure
              return GestureDetector(
                onTap: () => bookingData['status'] == "complete"
                    ? controller.showRatingDialog(context, bookingData)
                    : null,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
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

Future<QuerySnapshot> fetchData(String email) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference reviewsCollection = firestore.collection('Bookings');

    QuerySnapshot querySnapshot =
        await reviewsCollection.where('docEmail', isEqualTo: email).get();

    return querySnapshot;
  } catch (e) {
    throw e;
  }
}
