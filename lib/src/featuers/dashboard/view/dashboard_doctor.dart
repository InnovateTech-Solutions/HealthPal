// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/usecase/authentication/authentication.dart';
import 'package:healthpal/src/featuers/dashboard/widget/doctors/doctor_booking_card.dart';

class DoctorDashBoard extends StatefulWidget {
  const DoctorDashBoard({super.key});

  @override
  State<DoctorDashBoard> createState() => _DoctorDashBoardState();
}

class _DoctorDashBoardState extends State<DoctorDashBoard> {
  List<DocumentSnapshot> bookings = [];
  final _authRepo = Get.put(Authentication());

  late final email = _authRepo.firebaseUser.value?.email;

  @override
  void initState() {
    super.initState();
    fetchBookingsForDoctor(email ?? '');
  }

  void fetchBookingsForDoctor(String docEmail) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('Bookings')
          .where('docEmail', isEqualTo: docEmail)
          .get();

      setState(() {
        bookings = result.docs;
      });
    } catch (error) {
      print('Error fetching bookings: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: const Text('Upcomming Doctor Bookings'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          var bookingData = bookings[index].data() as Map<String, dynamic>;
          var documentId = bookings[index].id;
          return Column(children: [
            const Gap(15),
            doctorBookingsCard(context,
                status: bookingData['status'],
                patientEmail: bookingData['userEmail'],
                date: bookingData['date'],
                time: bookingData['time'],
                image: bookingData['testImg'],
                id: documentId,
                servue: bookingData['servue'] ?? ""),
            const Gap(15)
          ]);
        },
      ),
    );
  }
}
