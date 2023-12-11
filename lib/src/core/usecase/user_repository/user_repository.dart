// ignore_for_file: body_might_complete_normally_catch_error, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/model/user_model.dart';
import 'package:healthpal/src/core/usecase/local_storage/local_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final userController = Get.put(LocalStroageController());

  final _db = FirebaseFirestore.instance;

  late UserModel userModel;

  void setUserModel(UserModel userModel) {
    this.userModel = userModel;
  }

  createUser(UserModel user) {
    _db
        .collection("users")
        .add(user.tojason())
        .whenComplete(() => Get.snackbar(
            "Success", "Your account has been created",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppColor.mainAppColor,
            backgroundColor: AppColor.success))
        .catchError((error) {
      Get.snackbar(error.toString(), "Something went wrong , try agin",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColor.mainAppColor,
          backgroundColor: AppColor.error);
    });
  }

  Future<void> updateUserRecord(UserModel user) async {
    await _db.collection("users").doc(user.id).update(user.tojason());
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("users").where("Email", isEqualTo: email).get();
    final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    userModel = userdata;
    userController.saveUserInfo(userdata);
    return userdata;
  }

// to see if user is Exits to make google , Apple Authentication
  Future<bool> userExist(String email) async {
    try {
      CollectionReference users = _db.collection('users');

      QuerySnapshot userSnapshot =
          await users.where('Email', isEqualTo: email).get();

      return userSnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking user existence: $e');
      return false;
    }
  }

  Future<bool> checkEmailExists(String email) async {
    bool exists = false;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users') // Replace with your actual collection name
          .where('Email', isEqualTo: email)
          .get();

      exists = querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email existence: $e');
    }

    return exists;
  }

  getUserImageUrl() {
    if (userModel.imageUrl != null) {
      return CircleAvatar(
          radius: 70, // Adjust the radius as needed
          backgroundImage: NetworkImage(userModel.imageUrl!));
    } else {
      return SvgPicture.asset(
        "assets/Profilepic.svg",
        width: 100,
        height: 100,
      );
    }
  }

  void addImage() {
    _db
        .collection("users")
        .where('Email', isEqualTo: userModel.email)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        userDoc.reference.update({'imageUrl': userModel.imageUrl});
      }
    });
  }

  void pickUpImage() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 500,
      maxWidth: 500,
      imageQuality: 75,
    );
    if (file == null) return;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child("images");

    Reference referenceImageToUpload = referenceDirImage.child(file.path);
    try {
      await referenceImageToUpload.putFile(File(file.path));

      userModel.imageUrl = await referenceImageToUpload.getDownloadURL();

      addImage();
    } catch (error) {
      Text(error.toString());
    }
  }
}
