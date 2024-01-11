// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/model/form_model.dart';
import 'package:healthpal/src/core/widget/form_widget.dart';
import 'package:healthpal/src/featuers/profile/widget/profile_container.dart';

class HistoryController extends GetxController {
  Future<void> showRatingDialog(
      BuildContext context, Map<String, dynamic> bookingData) async {
    double rating = 0.0;
    final feedBack = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rate Appointment'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("the status :  ${bookingData['status']}"),
              const Gap(10),
              const Text('Please rate your appointment:'),
              const Gap(30),
              RatingBar(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30.0,
                onRatingUpdate: (value) {
                  rating = value;
                },
                ratingWidget: RatingWidget(
                    full: const Icon(Icons.star),
                    half: const Icon(Icons.star_half),
                    empty: const Icon(Icons.star_outline_outlined)),
              ),
              const Gap(15),
              textFieldLabel("FeedBack"),
              FormWidget(
                  textForm: FormModel(
                      controller: feedBack,
                      enableText: false,
                      hintText: "feedBack",
                      icon: const Icon(Icons.edit),
                      invisible: false,
                      validator: null,
                      type: TextInputType.name,
                      onChange: null,
                      inputFormat: null,
                      onTap: null))
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Handle the rating submission logic here
                print('User rated $rating stars');
                await sendToReviewCollection(
                    bookingData, rating, feedBack.text);
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendToReviewCollection(
      Map<String, dynamic> bookingData, double rating, String feedBack) async {
    try {
      // Get a reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Define the data to be sent to the collection
      Map<String, dynamic> reviewData = {
        'note': bookingData['note'],
        'docEmail': bookingData['docEmail'],
        'time': bookingData['time'],
        'status': bookingData['status'],
        'testImg': bookingData['testImg'],
        'date': bookingData['date'],
        'rating': rating,
        'feedback': feedBack
      };

      // Reference to the 'reviews' collection in Firestore
      CollectionReference reviewsCollection = firestore.collection('reviews');

      // Add the data to the collection
      await reviewsCollection.add(reviewData);

      print('Data sent to review collection successfully!');
    } catch (e) {
      print('Error sending data to review collection: $e');
      // Handle the error as needed
    }
  }
}
