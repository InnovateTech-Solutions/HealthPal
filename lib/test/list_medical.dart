import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('MedicalCenters')
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
                        color: AppColor.buttonColor,
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                      child: DropdownButton(
                        dropdownColor: AppColor.buttonColor,
                        icon: Icon(
                          Icons.arrow_drop_down_circle_sharp,
                          color: AppColor.mainAppColor,
                        ),
                        hint: const Text('Select category'),
                        value: selectedCategory,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });

                          // Handle any other actions on selection if needed
                          print(newValue);
                        },
                        items: categoryTitles.map((title) {
                          return DropdownMenuItem(
                            value: title,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                title,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: AppColor.subappcolor,
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
          ),
        ],
      ),
    );
  }
}
