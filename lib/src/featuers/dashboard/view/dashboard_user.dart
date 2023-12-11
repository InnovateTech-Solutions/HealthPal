import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/core/usecase/authentication/authentication.dart';
import 'package:healthpal/src/core/usecase/user_repository/user_repository.dart';
import 'package:healthpal/src/core/widget/app_container.dart';
import 'package:healthpal/src/core/widget/search_widget.dart';
import 'package:healthpal/src/core/widget/text_widget.dart';
import 'package:healthpal/src/featuers/dashboard/controller/dashboard_controller.dart';
import 'package:healthpal/src/featuers/dashboard/controller/widget_controller.dart';
import 'package:healthpal/src/featuers/dashboard/widget/slider_widget.dart';

class UserDashBorad extends StatefulWidget {
  const UserDashBorad({Key? key}) : super(key: key);

  @override
  State<UserDashBorad> createState() => _UserDashBoradState();
}

class _UserDashBoradState extends State<UserDashBorad> {
  final authRepo = Get.put(Authentication());

  getUserData() async {
    late final email = authRepo.firebaseUser.value?.email;

    // print("fcmToken ${}");
    if (email != null) {
      return await UserRepository.instance.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to get email");
    }
  }

  final controller = Get.put(DashboardController());

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RxString searchResualt = ''.obs;
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: FutureBuilder(
              future: Future.delayed(
                const Duration(milliseconds: 500),
                () => controller.fetchAdsAndMedicalCentersDoctor(),
              ),
              builder: (context, snpshot) {
                if (snpshot.connectionState == ConnectionState.done) {
                  if (snpshot.hasData) {
                    final ads = snpshot.data!['ads'];
                    final medicalCenters = snpshot.data!['MedicalCenters'];

                    final doctors = snpshot.data!['Doctor'];
                    List<Widget> convertSnapshotsToWidgets(
                        List<DocumentSnapshot<Object?>>? documentSnapshots) {
                      List<Widget> widgetsList = [];

                      if (documentSnapshots != null) {
                        for (DocumentSnapshot<Object?> snapshot
                            in documentSnapshots) {
                          var data = snapshot.data() as Map<String, dynamic>?;

                          if (data != null) {
                            Widget documentWidget = AppContainer(
                                imgName: data['image'],
                                onTap: () => Get.to(const Scaffold(),
                                    transition: Transition.rightToLeft));

                            widgetsList.add(documentWidget);
                          }
                        }
                      }

                      return widgetsList;
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              width: 320,
                              child: SearchWidget(
                                search: SearchFormEntitiy(
                                  hintText: "Search",
                                  searchController: null,
                                  icon: const Icon(Icons.search,
                                      color: Colors.grey),
                                  type: TextInputType.text,
                                  onChange: (String? search) {
                                    search = searchResualt.value;
                                  },
                                ),
                              ),
                            ),
                          ),
                          const Gap(20),
                          SliderWidget(
                            item: convertSnapshotsToWidgets(ads),
                          ),
                          const Gap(20),
                          TextWidget.dashoboardMainText('Medicial centers'),
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                separatorBuilder: (conetxt, index) {
                                  return const Gap(15);
                                },
                                itemCount:
                                    WidgetController().medicialcenters.length,
                                itemBuilder: (context, index) {
                                  return WidgetController()
                                      .medicialcenters[index];
                                }),
                          ),
                          TextWidget.dashoboardMainText('Doctors'),
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                separatorBuilder: (conetxt, index) {
                                  return const Gap(15);
                                },
                                itemCount: WidgetController().doctors.length,
                                itemBuilder: (context, index) {
                                  return WidgetController().doctors[index];
                                }),
                          ),
                        ],
                      ),
                    );
                  } else if (snpshot.hasError) {
                    return Text('Erorr${snpshot.error}');
                  } else {
                    return const Text("somthing went wrong");
                  }
                } else if (snpshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snpshot.connectionState == ConnectionState.none) {
                  return const CircularProgressIndicator();
                } else {
                  return const Text("somthing went wrong");
                }
              }),
        ),
      ),
    );
  }
}
