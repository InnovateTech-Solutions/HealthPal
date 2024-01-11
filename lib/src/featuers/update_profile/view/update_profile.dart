import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/usecase/authentication/authentication.dart';
import 'package:healthpal/src/core/widget/loding_widget.dart';
import 'package:healthpal/src/featuers/dashboard/controller/usercheck_controller.dart';

import 'package:healthpal/src/featuers/update_profile/view/widget/doctor_profile.dart';
import 'package:healthpal/src/featuers/update_profile/view/widget/user_profile.dart';

class UpdateProfileWidget extends StatefulWidget {
  const UpdateProfileWidget({super.key});

  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  final _authRepo = Get.put(Authentication());
  late final email = _authRepo.firebaseUser.value?.email;
  // final userRepository = Get.put(UserRepository());
  // @override
  // void initState() {
  //   super.initState();
  //   userRepository.getUserDetails(email ?? '');
  // }

  @override
  Widget build(BuildContext context) {
    final UserTypeCheckController controller = UserTypeCheckController();

    return FutureBuilder<void>(
      future: controller.checkUserTypeAndStatus(email ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (controller.userType == 'Doctor') {
            if (!controller.status) {
              return const LoadingPage();
            }
            return const UpdateDoctorWidget();
          } else if (controller.userType == 'User') {
            return const UpdateUserWidget();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }
}
