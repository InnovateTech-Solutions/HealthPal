import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:healthpal/src/featuers/dashboard/widget/doctors/doctors_widget.dart';

class DoctorUsersList extends StatelessWidget {
  const DoctorUsersList({super.key});

  Future<QuerySnapshot> getDoctorUsers() async {
    // Get a reference to the users collection
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Use a query to get documents where the field 'usertype' is equal to 'Doctor'
    return await usersCollection.where('usertype', isEqualTo: 'Doctor').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: getDoctorUsers(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // Display the list of doctor users
                List<Widget> doctorListTiles =
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                  // Access fields using document['field_name']

                  return DoctorsWidget(
                    doctorname: document['UserName'],
                    imgname: '${document['UserName']}',
                    ratingNumber: '${document['rating']}',
                    ratingLength: '${document['rating']}',
                    medicialcenter: document['MedicalCenter'],
                    experince: document['experince'],
                    description: document['description'],
                    address: document['address'],
                    workingHours: document['Working Time'],
                    patients: document['patients'],
                    doctorEmail: document['Email'],
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
          ),
        ],
      ),
    );
  }
}
