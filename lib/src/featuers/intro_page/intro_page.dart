import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/widget/forms_container.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/doctor_register/view/doctor_register.dart';
import 'package:healthpal/src/featuers/login/view/login_page.dart';
import 'package:healthpal/src/featuers/regitser/view/register_screen.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Logo.png'),
              const Gap(5),
              TextWidget.mainAppText('HealthPal'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget.subAppText(
                    ' Explore a Vast Array of Online Medical Specialists, Offering an Extensive Range of Expertise Tailored\n to Your Healthcare Needs.'),
              ),
              const Gap(20),
              formscontainer(
                  title: 'register as Doctor',
                  onTap: () => Get.to(const DoctorRegisterScreen())),
              const Gap(10),
              formscontainer(
                  title: 'register as patint',
                  onTap: () => Get.to(const RegisterScreen())),
              const Gap(10),
              formscontainer(
                  title: 'login In', onTap: () => Get.to(const LoginScreen()))
            ],
          ),
        ),
      ),
    );
  }
}
