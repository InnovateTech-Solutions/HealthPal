import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/constants/constants.dart';
import 'package:healthpal/src/core/model/form_model.dart';
import 'package:healthpal/src/core/model/user_model.dart';
import 'package:healthpal/src/core/widget/forms_container.dart';
import 'package:healthpal/src/core/widget/form_widget.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/regitser/controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
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
              TextWidget.mainAppText('Create Account '),
              TextWidget.subAppText('We are here to help you!'),
              Form(
                key: controller.formkey,
                child: SizedBox(
                  height: 550,
                  width: double.infinity,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    children: [
                      FormWidget(
                          textForm: FormModel(
                              controller: controller.userName,
                              enableText: false,
                              hintText: AppConst.username,
                              icon: const Icon(Icons.person),
                              invisible: false,
                              validator: (username) =>
                                  controller.vaildateUserName(username),
                              type: TextInputType.name,
                              onChange: null,
                              inputFormat: [],
                              onTap: null)),
                      const Gap(15),
                      FormWidget(
                          textForm: FormModel(
                              controller: controller.email,
                              enableText: false,
                              hintText: AppConst.email,
                              icon: const Icon(Icons.email),
                              invisible: false,
                              validator: (email) =>
                                  controller.validateEmail(email),
                              type: TextInputType.emailAddress,
                              onChange: null,
                              inputFormat: [],
                              onTap: null)),
                      const Gap(15),
                      FormWidget(
                          textForm: FormModel(
                              controller: controller.password,
                              enableText: false,
                              hintText: AppConst.password,
                              icon: const Icon(Icons.password),
                              invisible: true,
                              validator: (password) =>
                                  controller.vaildatePassword(password),
                              type: TextInputType.visiblePassword,
                              onChange: null,
                              inputFormat: [],
                              onTap: null)),
                      const Gap(15),
                      FormWidget(
                          textForm: FormModel(
                              controller: controller.phoneNumber,
                              enableText: false,
                              hintText: AppConst.phoneNumber,
                              icon: const Icon(Icons.phone),
                              invisible: false,
                              validator: (phone) =>
                                  controller.vaildatePassword(phone),
                              type: TextInputType.phone,
                              onChange: null,
                              inputFormat: null,
                              onTap: null)),
                      const Gap(30),
                      formscontainer(
                          title: 'Sign In',
                          onTap: () => controller.onSignup(UserModel(
                              email: controller.email.text,
                              name: controller.userName.text,
                              password: controller.password.text,
                              phone: controller.phoneNumber.text,
                              userType: 'User',
                              imageUrl: '')))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
