class Booking {
  String docEmail;
  String date;
  String time;
  String userEmail;
  String testImg;
  String note;
  String status;

  Booking({
    required this.docEmail,
    required this.date,
    required this.time,
    required this.userEmail,
    required this.testImg,
    required this.note,
    required this.status,
  });

  factory Booking.fromMap(Map<String, dynamic> data) {
    return Booking(
      userEmail: data['userEmail'],
      docEmail: data['docEmail'],
      date: data['date'],
      time: data['time'],
      note: data['note'],
      testImg: data["testImg"],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'docEmail': docEmail,
      'date': date,
      'time': time,
      'testImg': testImg,
      'note': note,
      'status': status,
    };
  }
}
