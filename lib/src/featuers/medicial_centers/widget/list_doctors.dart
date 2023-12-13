import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({required this.medicial, super.key});
  final String medicial;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: fetchData(medicial),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<DocumentSnapshot> doctors = snapshot.data!;
          return Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    var doctorData =
                        doctors[index].data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        ListTile(
                          title: Text(doctorData['Email']),
                          subtitle: Text(doctorData['UserName']),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future<List<DocumentSnapshot>> fetchData(String medicial) async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      CollectionReference medicalCenterCollection =
          FirebaseFirestore.instance.collection('MedicalCenter');

      // Query the medical center collection based on the title
      QuerySnapshot medicalCenterQuery = await medicalCenterCollection
          .where('title', isEqualTo: medicial)
          .get();

      // Extract the title from the medical center query
      String medicalCenterTitle = medicalCenterQuery.docs.first['title'];

      // Query the users collection based on usertype and title
      QuerySnapshot usersQuery = await usersCollection
          .where('usertype', isEqualTo: 'Doctor')
          .where('title', isEqualTo: medicalCenterTitle)
          .get();

      // Return the list of documents from the users query
      return usersQuery.docs;
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}
