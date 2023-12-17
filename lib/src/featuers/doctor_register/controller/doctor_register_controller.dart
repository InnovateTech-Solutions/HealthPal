import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/model/user_model.dart';
import 'package:healthpal/src/core/usecase/authentication/authentication.dart';
import 'package:healthpal/src/core/usecase/user_repository/user_repository.dart';
import 'package:healthpal/src/featuers/nav_bar/nav_bar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DoctorRegisterController extends GetxController {
  final formkey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController editingController = TextEditingController();
  final TextEditingController addreas = TextEditingController();
  final TextEditingController expirans = TextEditingController();
  final TextEditingController pashint = TextEditingController();
  var maskFormatterPhone = MaskTextInputFormatter(
      mask: '### ### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void registerUser(String email, String password) {
    Authentication().createUserWithEmailAndPassword(email, password);
  }

  Future<void> createUser(UserModel user) async {
    await UserRepository().createUser(user);
    Get.to(const MainPage());
  }

  validateEmail(String? email) {
    if (GetUtils.isEmail(email!)) {
      return null;
    }
    return 'Email is not vaild';
  }

  vaildateUserName(String? userName) {
    if (GetUtils.isUsername(userName!)) {
      return null;
    }
    return 'UserName is not vaild';
  }

  vaildeEdit(String? email) {
    if (GetUtils.isUsername(email!)) {
      return null;
    }
    return 'edit is not vaild';
  }

  vailaddreas(String? addreas) {
    if (GetUtils.isUsername(addreas!)) {
      return null;
    }
    return 'edit is not vaild';
  }

  vailexpirans(String? expirans) {
    if (GetUtils.isPhoneNumber(expirans!)) {
      return null;
    }
    return 'edit is not vaild';
  }

  vailpashint(String? pashint) {
    if (GetUtils.isPhoneNumber(pashint!)) {
      return null;
    }
    return 'edit is not vaild';
  }

  vaildatePassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return 'Password is not vaild';
    }
    return null;
  }

  vaildateUserNameFiled(String? userName) {
    if (GetUtils.isUsername(userName!)) {
      return null;
    }
    return 'UserName is not vaild';
  }

  vaildPhoneNumber(String? phoneNumber) {
    if (GetUtils.isPhoneNumber(phoneNumber!)) {
      return null;
    }
    return 'Phone Number is not vaild';
  }

  Future<bool> isUsernameTaken(String username) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('User')
          .where('UserName', isEqualTo: username)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      Get.snackbar("Error", "Error checking username: $error",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColor.mainAppColor,
          backgroundColor: AppColor.error);
      return false;
    }
  }

  Future<void> onSignup(UserModel user) async {
    if (formkey.currentState!.validate()) {
      Future<bool> code = Authentication()
          .createUserWithEmailAndPassword(user.email, user.password);
      if (await code) {
        Get.snackbar("Success", " Account  Created Successfullly",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppColor.mainAppColor,
            backgroundColor: AppColor.success);
      } else {
        Get.snackbar("ERROR", "Username  is taken",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppColor.mainAppColor,
            backgroundColor: AppColor.error);
      }
    }
  }
}
