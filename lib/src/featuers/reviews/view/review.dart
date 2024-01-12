import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/usecase/authentication/authentication.dart';
import 'package:healthpal/src/core/widget/loding_widget.dart';
import 'package:healthpal/src/featuers/dashboard/controller/usercheck_controller.dart';
import 'package:healthpal/src/featuers/feedback/widget/doctor_feedback.dart';
import 'package:healthpal/src/featuers/history/view/history_paget.dart';
import 'package:healthpal/src/featuers/reviews/doctor_review.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
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
            return const DoctorReview();
          } else if (controller.userType == 'User') {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }
}
