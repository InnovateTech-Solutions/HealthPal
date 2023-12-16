// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:healthpal/src/featuers/user_history/widget/user_history_card.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({required this.userEmail, super.key});
  final String userEmail;
  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  List<DocumentSnapshot> allbookings = [];

  void fetchBookingsForUser(String userEmail) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('Bookings')
          .where('userEmail', isEqualTo: userEmail)
          .get();

      setState(() {
        allbookings = result.docs;
      });
    } catch (error) {
      print('Error fetching bookings: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBookingsForUser(widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    List<String> name = widget.userEmail.split('@');
    String nameSplit = name[0];
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(50),
              Text(
                'User History For $nameSplit ',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 600,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Gap(20);
                  },
                  itemCount: allbookings.length,
                  itemBuilder: (context, index) {
                    var booking = allbookings[index];
                    return historyCard(
                      status: booking['status'],
                      patientEmail: booking['userEmail'],
                      date: booking['date'],
                      time: booking['time'],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
