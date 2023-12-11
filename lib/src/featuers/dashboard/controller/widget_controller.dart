import 'package:get/get.dart';
import 'package:healthpal/src/featuers/dashboard/widget/doctors_widget.dart';
import 'package:healthpal/src/featuers/dashboard/widget/medicial_widget.dart';

class WidgetController extends GetxController {
  List<MedicicalCenterWidget> medicialcenters = [
    const MedicicalCenterWidget(),
    const MedicicalCenterWidget(),
    const MedicicalCenterWidget(),
  ];

  List<DoctorsWidget> doctors = [
    const DoctorsWidget(),
    const DoctorsWidget(),
    const DoctorsWidget(),
    const DoctorsWidget()
  ];
}
