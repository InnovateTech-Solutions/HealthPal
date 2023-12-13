import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/featuers/dashboard/widget/medicial/medicial_widget.dart';
import 'package:healthpal/src/featuers/medicial_centers/view/medicialcenter_Screen.dart';

class MedicalCenterContainer extends StatefulWidget {
  const MedicalCenterContainer({super.key});

  @override
  State<MedicalCenterContainer> createState() => _MedicalCenterContainerState();
}

class _MedicalCenterContainerState extends State<MedicalCenterContainer> {
  final CollectionReference medicalCenterCollection =
      FirebaseFirestore.instance.collection('MedicalCenter');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: medicalCenterCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // If the query is successful, display the data
        return SizedBox(
          height: 200,
          width: double.infinity,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const Gap(20);
            },
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var medicalCenter = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () => Get.to(MedicialCenterScreen(
                  medicialCenter: medicalCenter['title'],
                  imgname: medicalCenter['image'],
                  address: medicalCenter['address'],
                  review: medicalCenter['review'],
                )),
                child: MedicicalCenterWidget(
                    title: medicalCenter['title'],
                    address: medicalCenter['address'],
                    entrereview: medicalCenter['review'],
                    review: medicalCenter['review'],
                    image: medicalCenter['image']),
              );
            },
          ),
        );
      },
    );
  }
}
