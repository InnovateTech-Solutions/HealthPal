import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserTypeCheckController extends ChangeNotifier {
  String userType = '';
  bool status = false;

  Future<void> checkUserTypeAndStatus(String email) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('Email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first;

        // Assuming 'userType' and 'status' are fields in the document
        userType = userDoc['usertype'];
        status = userDoc['status'];
      } else {
        // Handle case where user with the specified email is not found
        userType = 'Unknown';
        status = false;
      }
    } catch (e) {
      // Handle any errors that may occur during the Firestore query
      print('Error: $e');
    }
    notifyListeners();
  }
}
