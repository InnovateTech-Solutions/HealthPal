// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/model/form_model.dart';
import 'package:healthpal/src/core/model/user_model.dart';
import 'package:healthpal/src/core/usecase/user_repository/user_repository.dart';
import 'package:healthpal/src/core/widget/forms_container.dart';
import 'package:healthpal/src/core/widget/form_widget.dart';
import 'package:healthpal/src/featuers/profile/repository/profile_repository.dart';
import 'package:healthpal/src/featuers/profile/widget/profile_container.dart';
import 'package:healthpal/src/featuers/regitser/controller/register_controller.dart';

class UpdateProfileWidget extends StatefulWidget {
  const UpdateProfileWidget({Key? key}) : super(key: key);

  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  final usercontroller = Get.put(UserRepository());
  final controller = Get.put(ProfileRepository());
  final validator = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    @override
    dispose() {
      super.dispose();
      controller.dispose();
      validator.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE Profile',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.buttonColor))),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: Future.delayed(
              const Duration(milliseconds: 500),
              () => controller.getUserData(),
            ),
            builder: ((context, snapShot) {
              if (snapShot.connectionState == ConnectionState.done) {
                if (snapShot.hasData) {
                  UserModel userData = snapShot.data as UserModel;
                  final id = TextEditingController(text: userData.id);
                  final email = TextEditingController(text: userData.email);
                  final userName = TextEditingController(text: userData.name);
                  final phoneNumber =
                      TextEditingController(text: userData.phone);
                  final password =
                      TextEditingController(text: userData.password);
                  final usertype =
                      TextEditingController(text: userData.userType);
                  RxString usernameTitle = userName.text.obs;
                  return Form(
                      key: validator.updateKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: AppColor.mainAppColor,
                                  ))
                            ],
                          ),
                          imagepicker(),
                          SizedBox(
                            height: 500,
                            width: double.infinity,
                            child: ListView(
                              physics: const FixedExtentScrollPhysics(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              children: [
                                textFieldLabel('Email'),
                                FormWidget(
                                  textForm: FormModel(
                                      enableText: false,
                                      controller: email,
                                      hintText: 'Email',
                                      icon: const Icon(Icons.email_rounded),
                                      invisible: false,
                                      validator: (email) =>
                                          validator.validateEmail(email),
                                      type: TextInputType.emailAddress,
                                      onChange: null,
                                      inputFormat: [],
                                      onTap: () {}),
                                ),
                                const Gap(15),
                                textFieldLabel('user Name'),
                                FormWidget(
                                  textForm: FormModel(
                                      enableText: false,
                                      controller: userName,
                                      hintText: 'Username',
                                      icon: const Icon(Icons.person),
                                      invisible: false,
                                      validator: (userName) =>
                                          validator.vaildateUserName(userName),
                                      type: TextInputType.name,
                                      onChange: null,
                                      inputFormat: [],
                                      onTap: () {}),
                                ),
                                const Gap(15),
                                textFieldLabel('user Type'),
                                FormWidget(
                                  textForm: FormModel(
                                      enableText: false,
                                      controller: phoneNumber,
                                      hintText: 'Phone Number',
                                      icon: const Icon(Icons.phone),
                                      invisible: false,
                                      validator: (phoneNumber) => validator
                                          .vaildateUserName(phoneNumber),
                                      type: TextInputType.number,
                                      onChange: null,
                                      inputFormat: [],
                                      onTap: () {}),
                                ),
                                const Gap(15),
                                textFieldLabel('phone number'),
                                FormWidget(
                                  textForm: FormModel(
                                      enableText: true,
                                      controller: usertype,
                                      hintText: 'Phone Number',
                                      icon: const Icon(Icons.phone),
                                      invisible: false,
                                      validator: (phoneNumber) => validator
                                          .vaildateUserName(phoneNumber),
                                      type: TextInputType.number,
                                      onChange: null,
                                      inputFormat: [],
                                      onTap: () {}),
                                ),
                                const Gap(15),
                                formscontainer(
                                    onTap: () async {
                                      if ((validator.updateKey.currentState!
                                          .validate())) {
                                        final userData = UserModel(
                                            id: id.text.trim(),
                                            email: email.text.trim(),
                                            name: userName.text.trim(),
                                            password: password.text.trim(),
                                            phone: phoneNumber.text.trim(),
                                            imageUrl: "",
                                            userType: usertype.text);
                                        await controller.updateRecord(userData);
                                      }
                                      dispose();
                                      usernameTitle.value =
                                          userName.text.trim();
                                      print(usernameTitle.value);
                                    },
                                    title: 'UPDATE')
                              ],
                            ),
                          ),
                        ],
                      ));
                } else if (snapShot.hasError) {
                  return Center(child: Text(snapShot.error.toString()));
                } else {
                  return const Text("somthing went wrong");
                }
              } else if (snapShot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Text("somthing went wrong");
              }
            })),
      ),
    );
  }
}

GestureDetector imagepicker() {
  final usercontroller = Get.put(UserRepository());

  return GestureDetector(
    onTap: () async {
      usercontroller.pickUpImage();
    },
    child: Container(
      width: 150,
      height: 100,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: usercontroller.getUserImageUrl(),
    ),
  );
}
