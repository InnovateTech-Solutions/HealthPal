import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final _db = FirebaseFirestore.instance;

  Future<Map<String, List<DocumentSnapshot>>>
      fetchAdsAndMedicalCentersDoctor() async {
    ////that query fetch all categories , that used in Dashboard widget
    final adsQuery = _db.collection('ads').get();
    final medicalCentersQuery = _db.collection('MedicalCenters').get();
    final doctorsQuary = _db.collection('Doctor').get();

    final results =
        await Future.wait([adsQuery, medicalCentersQuery, doctorsQuary]);

    List<DocumentSnapshot> ads = results[0].docs;
    List<DocumentSnapshot> medicalCenters = results[1].docs;

    List<DocumentSnapshot> doctors = results[2].docs;
    return {'ads': ads, 'MedicalCenters': medicalCenters, 'Doctor': doctors};
  }
}
