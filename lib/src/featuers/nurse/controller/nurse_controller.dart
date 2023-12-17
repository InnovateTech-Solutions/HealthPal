import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/featuers/nurse/model/nurse_model.dart';

class NuserController extends GetxController {
  final formkey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController nat = TextEditingController();

  final _db = FirebaseFirestore.instance;

  validateUsername(String? name) {
    if (GetUtils.isUsername(name!)) {
      return null;
    }
    return 'name is not vaild';
  }

  validateUsernat(String? nat) {
    if (GetUtils.isUsername(nat!)) {
      return null;
    }
    return 'nat is not vaild';
  }

  createNurse(NuserModel nuse) {
    _db
        .collection('nurse')
        .add(nuse.tojson())
        .whenComplete(() => Get.snackbar('suxess', 'nuse added'))
        .catchError((error) {
      Get.snackbar('title', '');
    });
  }

  onSubmit(NuserModel nuserModel) {
    if ((formkey.currentState!.validate())) {
      createNurse(nuserModel);
      Get.snackbar("Success", "Login Successful",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColor.mainAppColor,
          backgroundColor: AppColor.success);
    } else {
      Get.snackbar("ERROR", "Email or Password is invild",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColor.mainAppColor,
          backgroundColor: AppColor.error);
    }
  }
}
