import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:healthpal/src/config/theme/theme.dart';
import 'package:healthpal/src/featuers/book_appointment/appointment/view/appointment_screen.dart';
import 'package:healthpal/src/featuers/book_appointment/doctor/view/doctor_screen.dart';
import 'package:healthpal/src/featuers/dashboard/view/dashboard_page.dart';
import 'package:healthpal/src/featuers/dashboard/widget/medicial/medicial_continer.dart';
import 'package:healthpal/src/featuers/profile/view/profile_page.dart';
import 'package:healthpal/test/doctors_view.dart';
import 'package:healthpal/test/upload_test.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetsOptions = [
    const DashBoardPgae(),
    BookingScreen(),
    const DoctorScrenn(),
    const AppointmentScreen(),
    const ProfileWidget()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainAppColor,
      body: Center(
        child: _widgetsOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColor.buttonColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 5,
              activeColor: AppColor.buttonColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: AppColor.mainAppColor,
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                ),
                GButton(
                  icon: Icons.category_outlined,
                ),
                GButton(
                  icon: Icons.location_on_outlined,
                ),
                GButton(
                  icon: Icons.access_time_outlined,
                ),
                GButton(
                  icon: Icons.account_circle_outlined,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
