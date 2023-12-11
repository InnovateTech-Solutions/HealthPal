import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/constants/constants.dart';
import 'package:healthpal/src/core/model/form_model.dart';
import 'package:healthpal/src/core/model/user_model.dart';
import 'package:healthpal/src/core/widget/forms_container.dart';
import 'package:healthpal/src/core/widget/form_widget.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/doctor_register/controller/doctor_register_controller.dart';
import 'package:healthpal/src/featuers/doctor_register/controller/pdf_controller.dart';

class DoctorRegisterScreen extends StatelessWidget {
  const DoctorRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorRegisterController());

    final pdfController = Get.put(PdfUpload());
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  height: 500,
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
                                  controller.vaildPhoneNumber(phone),
                              type: TextInputType.phone,
                              onChange: null,
                              inputFormat: [controller.maskFormatterPhone],
                              onTap: null)),
                      const Gap(15),
                      GestureDetector(
                        onTap: () {
                          pdfController.pickPDF();
                        },
                        child: Container(
                          height: 125,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.subappcolor),
                            color: const Color.fromARGB(255, 225, 254, 226),
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2)),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                if (pdfController.selectedFile.value == null) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        const Gap(10),
                                        TextWidget.subAppText('Add your proof')
                                      ],
                                    ),
                                  ); // Empty container when no file is selected
                                } else {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        width: 90,
                                        height: 65,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://cdn-icons-png.flaticon.com/512/3997/3997608.png'))),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () =>
                                                  {pdfController.pickPDF()},
                                              icon: const Icon(Icons.edit)),
                                          IconButton(
                                              onPressed: () => {
                                                    pdfController
                                                        .deleteSelectedFile()
                                                  },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ))
                                        ],
                                      )
                                    ],
                                  );
                                }
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              formscontainer(
                  title: 'Sign In',
                  onTap: () => {
                        controller.onSignup(UserModel(
                            email: controller.email.text,
                            name: controller.userName.text,
                            password: controller.password.text,
                            phone: controller.password.text,
                            userType: 'Doctor',
                            imageUrl: '')),
                        pdfController.saveToFirebase(UserModel(
                            email: controller.email.text,
                            name: controller.userName.text,
                            password: controller.password.text,
                            phone: controller.password.text,
                            userType: 'Doctor',
                            imageUrl: ''))
                      })
            ],
          ),
        ),
      ),
    );
  }
}
