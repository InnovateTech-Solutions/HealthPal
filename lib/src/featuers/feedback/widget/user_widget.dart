import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/featuers/feedback/controller/feedback_controller.dart';

class UserFeedBack extends GetView<FeedBackController> {
  const UserFeedBack({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FeedBackController());
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('reviews').get(),
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
                      Text("status :${bookingData['status']}"),
                      const Gap(10),
                      Text("FeedBack :${bookingData['feedback']}"),
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
    CollectionReference reviewsCollection = firestore.collection('reviews');

    QuerySnapshot querySnapshot =
        await reviewsCollection.where('docEmail', isEqualTo: email).get();

    return querySnapshot;
  } catch (e) {
    throw e;
  }
}
