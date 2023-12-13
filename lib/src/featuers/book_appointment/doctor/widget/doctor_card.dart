import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/test/chat_flutter.dart';

Center doctorCard({required String name, required String medicialCenter}) {
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
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/564x/16/96/71/169671343ef815d20808e6c9e43c5c19.jpg'),
                    fit: BoxFit.cover)),
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget.mainAppText(name),
              const Gap(5),
              Row(
                children: [
                  const Icon(Icons.location_on),
                  const Gap(15),
                  TextWidget.subAppText(medicialCenter)
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () => Get.to(const ChatPage()),
                      icon: const Icon(Icons.chat)),
                  TextButton(
                      onPressed: () => Get.to(const ChatPage()),
                      child: TextWidget.widgetsubText('chat with Doctor!!')),
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}
