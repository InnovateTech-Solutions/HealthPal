import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/model/form_model.dart';
import 'package:healthpal/src/core/model/user_model.dart';
import 'package:healthpal/src/core/widget/form_widget.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/add_servus/controller/controller.dart';

class AddsSrvus extends GetView<ServueController> {
  const AddsSrvus({required this.user, super.key});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    Get.put(ServueController());
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/Logo.png'),
              const Gap(5),
              TextWidget.mainAppText('HealthPal'),
              const Gap(20),
              TextWidget.mainAppText('Add  your Srvus'),
              TextWidget.subAppText('We are here to help you!'),
              Form(
                  key: controller.formkey,
                  child: Column(
                    children: [
                      FormWidget(
                          textForm: FormModel(
                              controller: controller.servue,
                              enableText: false,
                              hintText: 'Servue',
                              icon: const Icon(Icons.person),
                              invisible: false,
                              validator: (username) =>
                                  controller.vaildateServue(username),
                              type: TextInputType.name,
                              onChange: null,
                              inputFormat: [],
                              onTap: null)),
                      const Gap(30)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
