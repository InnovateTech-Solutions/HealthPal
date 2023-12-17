import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/model/form_model.dart';
import 'package:healthpal/src/core/widget/form_widget.dart';
import 'package:healthpal/src/core/widget/forms_container.dart';
import 'package:healthpal/src/featuers/nurse/controller/nurse_controller.dart';
import 'package:healthpal/src/featuers/nurse/model/nurse_model.dart';
import 'package:healthpal/src/featuers/profile/widget/profile_container.dart';

class NurseView extends StatelessWidget {
  const NurseView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NuserController());
    var age = int.parse(controller.age.text);
    return Scaffold(
      body: Column(
        children: [
          Form(
              key: controller.formkey,
              child: Column(
                children: [
                  FormWidget(
                      textForm: FormModel(
                          controller: controller.name,
                          enableText: false,
                          hintText: 'name',
                          icon: Icon(Icons.near_me),
                          invisible: false,
                          validator: (name) =>
                              controller.validateUsername(name),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          onTap: null)),
                  Gap(20),
                  FormWidget(
                      textForm: FormModel(
                          controller: controller.nat,
                          enableText: false,
                          hintText: 'nat',
                          icon: Icon(Icons.near_me),
                          invisible: false,
                          validator: (name) => controller.validateUsernat(name),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          onTap: null)),
                  Gap(20),
                  FormWidget(
                      maxlength: 2,
                      textForm: FormModel(
                          controller: controller.age,
                          enableText: false,
                          hintText: 'age',
                          icon: Icon(Icons.near_me),
                          invisible: false,
                          validator: (name) =>
                              controller.validateUsername(name),
                          type: TextInputType.phone,
                          onChange: null,
                          inputFormat: null,
                          onTap: null)),
                  Gap(20),
                  formscontainer(
                      title: 'nurse submit',
                      onTap: () => controller.onSubmit(NuserModel(
                          name: controller.name.text,
                          age: age,
                          nat: controller.nat.text)))
                ],
              ))
        ],
      ),
    );
  }
}
