// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthpal/src/core/model/user_model.dart';

class LoginRepository extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String userType,
    required String name,
    required String phone,
    required String imageUrl,
    required String age,
    required String gander,
    required String userTest,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user != null) {
        await _userCollection.doc(user.uid).set({
          "Email": email,
          "Password": password,
          "PhoneNumber": phone,
          "UserName": name,
          "Age": age,
          "Gander": gander,
          'pdf': userTest,
          'usertype': userType,
          'imageUrl': imageUrl,
        });

        return UserModel(
          id: user.uid,
          email: email,
          name: name,
          password: password,
          phone: phone,
          userType: userType,
          imageUrl: '',
        );
      }

      return null;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
