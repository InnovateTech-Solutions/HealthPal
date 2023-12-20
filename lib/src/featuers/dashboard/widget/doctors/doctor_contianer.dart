import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthpal/src/featuers/book_appointment/doctor/view/doctor_screen.dart';
import 'package:healthpal/src/featuers/dashboard/widget/doctors/doctors_widget.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({super.key});

  Future<QuerySnapshot> getDoctorUsers() async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    return await usersCollection.where('usertype', isEqualTo: 'Doctor').get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDoctorUsers(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Display the list of doctor users
          List<Widget> doctorListTiles =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            // Access fields using document['field_name']

            return GestureDetector(
              onTap: () => Get.to(DoctorScrenn(
                doctorname: document['UserName'] ?? '',
                imgname: '${document['UserName']}',
                ratingNumber: '${document['rating']}',
                ratingLength: '${document['rating']}',
                medicialcenter: document['MedicalCenter'] ?? '',
                experince: document['experince'] ?? '',
                description: document['description'] ?? '',
                address: document['address'] ?? '',
                workingHours: document['Working Time'] ?? '',
                patients: document['patients'] ?? '',
                doctorEmail: document['Email'] ?? '',
              )),
              child: DoctorsWidget(
                doctorname: document['UserName'] ?? '',
                imgname: '${document['UserName']}' ?? '',
                ratingNumber: '${document['rating']}' ?? '',
                ratingLength: '${document['rating']}' ?? '',
                medicialcenter: document['MedicalCenter'] ?? '',
                experince: document['experince'] ?? '',
                description: document['description'] ?? '',
                address: document['address'] ?? '',
                workingHours: document['Working Time'] ?? '',
                patients: document['patients'] ?? '',
                doctorEmail: document['Email'] ?? '',
              ),
            );
          }).toList();
          return Column(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const Gap(15);
                    },
                    itemCount: doctorListTiles.length,
                    itemBuilder: (cotext, index) {
                      return doctorListTiles[index];
                    }),
              ),
            ],
          );
        }
      },
    );
  }
}
