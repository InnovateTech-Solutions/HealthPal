// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:healthpal/src/featuers/dashboard/controller/docDashboard_controller.dart';

// class DocDashboardUI extends StatelessWidget {
//   final DocDashboardController controller = Get.put(DocDashboardController());

//   Future<List<DocumentSnapshot<Map<String, dynamic>>>> _fetchBookings(String docEmail) async {
//     controller.fetchBookingsForDoctor('khaled@dr.com');
//     return controller.bookings;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Doctor Dashboard'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // Filter bookings based on status
//                 controller.filterBookings('khaled@dr.com', 'Upcoming');
//               },
//               child: Text('Filter Pending Bookings'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Fetch all bookings for the doctor
//                 _fetchBookings();
//               },
//               child: Text('Show All Bookings'),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: FutureBuilder(
//                 future: _fetchBookings(),
//                 builder: (context,
//                     AsyncSnapshot<List<DocumentSnapshot<Map<String, dynamic>>>>
//                         snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else {
//                     List<DocumentSnapshot<Map<String, dynamic>>> bookings =
//                         snapshot.data!;

//                     if (bookings.isEmpty) {
//                       return Center(child: Text('No bookings available.'));
//                     } else {
//                       return ListView.builder(
//                         itemCount: bookings.length,
//                         itemBuilder: (context, index) {
//                           var booking = bookings[index];
//                           return ListTile(
//                             title: Text('Booking ID: ${booking.id}'),
//                             subtitle: Text('Status: ${booking['status']}'),
//                             trailing: ElevatedButton(
//                               onPressed: () {
//                                 // Update booking status
//                                 controller.updateStatus(
//                                     'completed', booking.id);
//                               },
//                               child: Text('Mark as Completed'),
//                             ),
//                           );
//                         },
//                       );
//                     }
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(GetMaterialApp(home: DocDashboardUI()));
// }
