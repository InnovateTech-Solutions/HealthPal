import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:healthpal/src/core/widget/text_widget.dart';

class DoctorsWidget extends StatelessWidget {
  const DoctorsWidget(
      {super.key,
      required this.doctorEmail,
      required this.experince,
      required this.doctorname,
      required this.imgname,
      required this.ratingNumber,
      required this.ratingLength,
      required this.medicialcenter,
      required this.description,
      required this.workingHours,
      required this.address,
      required this.patients});
  final String doctorEmail;
  final String doctorname;
  final String imgname;
  final String ratingNumber;
  final String ratingLength;
  final String medicialcenter;
  final String experince;
  final String description;
  final String workingHours;
  final String address;
  final String patients;

  @override
  Widget build(BuildContext context) {
    var ratingint = double.parse(ratingNumber);
    var ratlength = double.parse(ratingNumber) * 20;
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
                    image: NetworkImage(imgname), fit: BoxFit.fill)),
          ),
          TextWidget.widgetsText(doctorname),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              children: [
                TextWidget.widgetsubText(ratingNumber),
                Expanded(
                  child: Container(),
                ),
                RatingBar(
                  itemSize: 20,
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
                TextWidget.widgetsubText(("(${ratlength.round().toString()})")),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on),
              TextWidget.widgetsubText(medicialcenter)
            ],
          )
        ],
      ),
    );
  }
}
