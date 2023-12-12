import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthpal/src/config/theme/theme.dart';

class MyDropdownWidget extends StatefulWidget {
  const MyDropdownWidget({super.key});

  @override
  State<MyDropdownWidget> createState() => _MyDropdownWidgetState();
}

class _MyDropdownWidgetState extends State<MyDropdownWidget> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('MedicalCenter')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            List<DocumentSnapshot> categories = snapshot.data!.docs;

            List<String> categoryTitles =
                categories.map((e) => e['title'].toString()).toList();

            return Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 225, 254, 226)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2)),
                  ],
                  color: AppColor.subappcolor,
                  borderRadius: BorderRadius.circular(7)),
              child: Center(
                child: DropdownButton(
                  dropdownColor: AppColor.subappcolor,
                  icon: Icon(
                    Icons.arrow_drop_down_circle_sharp,
                    color: AppColor.buttonColor,
                  ),
                  hint: const Text('Select category'),
                  value: selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });

                    // Handle any other actions on selection if needed
                  },
                  items: categoryTitles.map((title) {
                    return DropdownMenuItem(
                      value: title,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: AppColor.mainAppColor,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    );
                  }).toList(), // Remove the underline
                  underline: Container(),
                  isExpanded: true,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
