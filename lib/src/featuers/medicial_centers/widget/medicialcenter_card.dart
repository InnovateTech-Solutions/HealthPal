import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';

Center medicialCard(
    {required String name,
    required String address,
    required String review,
    required String imgname}) {
  String newadress = address.substring(0, 10);
  String newName = name.substring(0, 10);
  String truncatedadress = '$newadress..';

  String truncatedname = '$newName..';
  return Center(
    child: Container(
      height: 133,
      width: 342,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white70,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 2)),
          ]),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imgname), fit: BoxFit.cover)),
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget.mainAppText(truncatedname),
              const Gap(5),
              Row(
                children: [
                  const Icon(Icons.location_on),
                  const Gap(15),
                  TextWidget.subAppText(truncatedadress)
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}
