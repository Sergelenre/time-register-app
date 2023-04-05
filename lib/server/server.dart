import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

final storage = new FlutterSecureStorage();
String identifier = "";
String startTime = "";
String endTime = "";

// Future<void> checkUser(
//     {required String name, required String identifier}) async {
//   final snapshot = await FirebaseFirestore.instance
//       .collection('workers')
//       .where('name', isEqualTo: name)
//       .get();
//   if (snapshot.docs.isNotEmpty) {
//     return;
//   } else {
//     final docWorker = FirebaseFirestore.instance.collection('workers').doc();
//     final json = {
//       'name': name,
//       'device': identifier,
//     };
//     await docWorker.set(json);
//   }
// }

Future createStartDate(
    {required String name,
    required String startDate,
    required String identifier}) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc();
  DateTime monthdayyear = DateTime.now();
  String formattedDateMY = DateFormat('MM-dd-yyyy').format(monthdayyear);
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('HH:mm:ss').format(now);
  var findDay = false;
  final arrivalTimestamp = DateTime.now().millisecondsSinceEpoch;
  FirebaseFirestore.instance
      .collection('users')
      .where('date', isEqualTo: formattedDateMY)
      .where('device', isEqualTo: identifier)
      .get()
      .then((QuerySnapshot querysnapshot) async {
    querysnapshot.docs.forEach((document) {
      findDay = true;
    });

    if (findDay) {
      print("olson");
    } else {
      print("oldogui");
      final json = {
        'name': name,
        'device': identifier,
        'arrival': formattedDate,
        'date': formattedDateMY,
        'endDate': "",
        'difference': {"hours": 00, "min": 00},
        'arrivalTimestamp': arrivalTimestamp,
        'endTimestamp': ""
      };
      await docUser.set(json);
    }
    print("document.id sasad");
  });
}

Future getdocId({required String name, required String identifier}) async {
  var findDay1 = false;
  DateTime monthdayyear = DateTime.now();
  String formattedDateMY = DateFormat('MM-dd-yyyy').format(monthdayyear);
  final docUser = FirebaseFirestore.instance.collection('users').doc();
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('HH:mm:ss').format(now);
  FirebaseFirestore.instance
      .collection('users')
      .where('date', isEqualTo: formattedDateMY)
      .where('device', isEqualTo: identifier)
      .get()
      .then((QuerySnapshot querysnapshot) async {
    querysnapshot.docs.forEach((document) async {
      findDay1 = true;
      String Id = document.id;
      final docUser = FirebaseFirestore.instance.collection('users').doc(Id);
      final endTimestamp = DateTime.now().millisecondsSinceEpoch;
      final arrivalTimestamp = document.get('arrivalTimestamp');
      final difference = endTimestamp - arrivalTimestamp;
      final duration = Duration(milliseconds: difference.toInt());
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);
      print(
          'Time difference: ${hours.toInt()} hours ${minutes.toInt()} minutes');
      final json = {
        'name': document.get('name'),
        'device': document.get('device'),
        'arrival': document.get('arrival'),
        'date': document.get('date'),
        'endDate': formattedDate,
        'difference': {"hours": hours, "min": minutes},
        'arrivalTimestamp': document.get('arrivalTimestamp'),
        'endTimestamp': endTimestamp
      };
      await docUser.set(json);
    });
    if (findDay1) {
      print("olson");
    } else {
      final json = {
        'name': name,
        'device': identifier,
        'arrival': "",
        'date': formattedDateMY,
        'endDate': formattedDate,
        'difference': "",
      };
      await docUser.set(json);
    }
    print("document.id sasad");
  });
}
