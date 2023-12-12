import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/constants/constants.dart';
import 'package:healthpal/src/core/model/form_model.dart';
import 'package:healthpal/src/core/usecase/local_storage/local_storage.dart';
import 'package:healthpal/src/core/usecase/user_repository/user_repository.dart';
import 'package:healthpal/src/core/widget/forms_container.dart';
import 'package:healthpal/src/core/widget/form_widget.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/login/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void clearText() {
    controller.email.clear();
    controller.password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              Image.asset('assets/Logo.png'),
              const Gap(5),
              TextWidget.mainAppText('HealthPal'),
              const Gap(20),
              TextWidget.mainAppText('Hi, Welcome Back! '),
              TextWidget.subAppText('Hope you’re doing fine.'),
              Form(
                key: controller.formkey,
                child: SizedBox(
                  height: 450,
                  width: double.infinity,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    children: [
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
                      formscontainer(
                          title: 'Sign In',
                          onTap: () => {
                                controller.onLogin(),
                                UserRepository()
                                    .getUserDetails(controller.email.text),
                                LocalStroageController().logIn()
                              })
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
