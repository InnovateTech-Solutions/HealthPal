import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthpal/src/core/usecase/authentication/authentication.dart';
import 'package:healthpal/src/core/usecase/local_storage/local_storage.dart';
import 'package:healthpal/src/featuers/profile/model/profile_button_model.dart';

class ProfileController extends GetxController {
  List<ProfileButton> profileList = [
    ProfileButton(
        title: 'My Appointments',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15,
          height: 15,
        ),
        onTap: () =>
            Get.to(const Scaffold(), transition: Transition.rightToLeft)),
    ProfileButton(
        title: 'Setting',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15,
          height: 15,
        ),
        onTap: () =>
            Get.to(const Scaffold(), transition: Transition.rightToLeft)),
    ProfileButton(
        title: 'Favourites',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15,
          height: 15,
        ),
        onTap: () {}),
    ProfileButton(
        title: 'About',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15,
          height: 15,
        ),
        onTap: () {}),
    ProfileButton(
      title: 'Logout',
      icon: SvgPicture.asset(
        'assets/arrow.svg',
        matchTextDirection: true,
        width: 15,
        height: 15,
      ),
      onTap: () => {
        Authentication().logout(),
        LocalStroageController.instance.clearUserInfo()
      },
    ),
  ];
}
