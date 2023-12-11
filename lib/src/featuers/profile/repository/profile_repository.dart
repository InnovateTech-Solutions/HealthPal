import 'package:get/get.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/core/model/user_model.dart';
import 'package:healthpal/src/core/usecase/authentication/authentication.dart';
import 'package:healthpal/src/core/usecase/user_repository/user_repository.dart';

class ProfileRepository extends GetxController {
  final _authRepo = Get.put(Authentication());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to get email");
    }
  }

  updateRecord(UserModel user) async {
    try {
      print(' User data : ${user.email}');
      await _userRepo.updateUserRecord(user);
      Get.snackbar("Success", " Account  Created Successfullly",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColor.mainAppColor,
          backgroundColor: AppColor.success);
    } catch (e) {}
  }
}
