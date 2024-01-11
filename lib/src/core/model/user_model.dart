import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  late String name;
  late String password;
  late String email;
  late String phone;
  late String userType;
  late String? servue;
  late bool status;
  late String? imageUrl;

  UserModel(
      {this.id,
      required this.email,
      required this.name,
      required this.password,
      required this.phone,
      required this.userType,
      required this.imageUrl,
      this.servue});

  tojason() {
    return {
      "Email": email,
      "Password": password,
      "PhoneNumber": phone,
      "UserName": name,
      'usertype': userType,
      "servue": servue
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return UserModel(
      id: documentSnapshot.id,
      email: data["Email"],
      name: data["UserName"],
      password: data["Password"],
      phone: data["PhoneNumber"],
      userType: data['usertype'],
      imageUrl: data["imageUrl"],
      servue: data['servue'],
    );
  }
}
