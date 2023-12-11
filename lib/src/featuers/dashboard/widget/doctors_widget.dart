import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';

class DoctorsWidget extends StatelessWidget {
  const DoctorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 215,
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
                image: const DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/564x/78/13/46/78134681e49076cb43861e7d0e03f7ca.jpg'),
                    fit: BoxFit.cover)),
          ),
          TextWidget.widgetsText('Dr. David Patel'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              children: [
                TextWidget.subAppText('5'),
                const Gap(5),
                RatingBar(
                  itemSize: 15,
                  initialRating: 5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
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
                TextWidget.widgetsubText('(58)'),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on),
              TextWidget.widgetsubText('Golden Cardiology Center')
            ],
          )
        ],
      ),
    );
  }
}
