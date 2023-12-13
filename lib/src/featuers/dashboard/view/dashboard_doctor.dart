import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthpal/src/featuers/dashboard/widget/doctors/doctor_bookingg_card.dart';

class DoctorDashBoard extends StatefulWidget {
  const DoctorDashBoard({super.key});

  @override
  State<DoctorDashBoard> createState() => _DoctorDashBoardState();
}

class _DoctorDashBoardState extends State<DoctorDashBoard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(children: [
            SizedBox(
              height: 614,
              width: double.infinity,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return doctorBookingsCard(context,
                        image: '',
                        status: '',
                        patientEmail: '',
                        date: '',
                        time: '');
                  },
                  separatorBuilder: (context, index) {
                    return const Gap(30);
                  },
                  itemCount: 10),
            ),
          ]),
        ),
      ),
    );
  }
}
