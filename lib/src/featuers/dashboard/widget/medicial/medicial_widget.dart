import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';

class MedicicalCenterWidget extends StatelessWidget {
  const MedicicalCenterWidget(
      {super.key,
      required this.title,
      required this.address,
      required this.entrereview,
      required this.review,
      required this.image});

  final String title;
  final String entrereview;
  final String address;

  final String review;
  final String image;
  @override
  Widget build(BuildContext context) {
    String first20Characters = address.substring(0, 10);
    var ratingint = double.parse(review);
    var ratlength = double.parse(review) * 20;
    return Container(
      width: 220,
      height: 115,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white70,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 2)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),
          const Gap(10),
          Row(
            children: [
              const Gap(5),
              TextWidget.widgetsText(title),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              children: [
                TextWidget.subAppText(review),
                const Gap(5),
                RatingBar(
                  itemSize: 15,
                  initialRating: 5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: ratingint.round(),
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star_rate,
                        color: Colors.yellow,
                      ),
                      half: const Icon(Icons.star_half_rounded,
                          color: Colors.yellow),
                      empty:
                          const Icon(Icons.star_sharp, color: Colors.yellow)),
                  onRatingUpdate: (double value) {},
                ),
                TextWidget.widgetsubText("(${ratlength.round().toString()})"),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on),
              TextWidget.widgetsubText(first20Characters)
            ],
          )
        ],
      ),
    );
  }
}
