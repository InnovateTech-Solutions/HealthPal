import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServueController extends GetxController {
  final formkey = GlobalKey<FormState>();
  final TextEditingController servue = TextEditingController();

  vaildateServue(String? userName) {
    if (GetUtils.isUsername(userName!)) {
      return null;
    }
    return 'UserName is not vaild';
  }
}
