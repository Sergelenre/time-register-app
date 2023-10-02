import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../navigator/navigtor.dart';

class FirestoreListWidgetLeave extends StatefulWidget {
  final QueryDocumentSnapshot document;

  FirestoreListWidgetLeave({required this.document});

  @override
  _FirestoreListWidgetLeaveState createState() =>
      _FirestoreListWidgetLeaveState();
}

class _FirestoreListWidgetLeaveState extends State<FirestoreListWidgetLeave> {
  late Stream<QuerySnapshot> _stream;
  String name = "";
  void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name')!;
    });
    print("aaa" + name);
  }

  @override
  void initState() {
    super.initState();
    saveData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen()));
          },
        ),
        title: Text(
          'Чөлөөний хүсэлт',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text('Нэр'),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 226, 226, 226)),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(widget.document['name']),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text('Шалтгаан'),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 226, 226, 226)),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(widget.document['reason']),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text('Хугацаа'),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 226, 226, 226)),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        DateFormat('MMM d, yyyy, HH:mm')
                            .format(widget.document['startDate'].toDate()),
                      ),
                      Text(" - "),
                      Text(
                        DateFormat('MMM d, yyyy, HH:mm')
                            .format(widget.document['endDate'].toDate()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    final FirebaseFirestore firestore =
                        FirebaseFirestore.instance;
                    final QuerySnapshot querySnapshot = await firestore
                        .collection('leave')
                        .where('Approvers', arrayContains: name)
                        .get();

                    querySnapshot.docs.forEach((document) async {
                      final dynamic approverField =
                          (document.data() as dynamic)['Approver'];
                      if (approverField is List) {
                        final List<dynamic> approvers = approverField;
                        for (var i = 0; i < approvers.length; i++) {
                          final dynamic approver = approvers[i];
                          if (approver is Map<String, dynamic>) {
                            if (approver['name'] == name) {
                              approver['status'] = 'Зөвшөөрсөн';
                              approver['date'] = DateTime.now().toString();
                              print(
                                  'Updating document ${document.id}: $approvers');
                              await document.reference
                                  .update({'Approver': approvers});
                            }
                          } else {
                            print('Unexpected data type: $approver');
                          }
                        }
                      } else {
                        print('Unexpected data type: $approverField');
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Color(0xFF6750A4),
                      duration: Duration(seconds: 1),
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 100,
                          right: 20,
                          left: 20),
                      content: Text(
                        'Амжилттай',
                        style: TextStyle(color: Colors.white),
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 10, left: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF6750A4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check, color: Colors.white, size: 18),
                        SizedBox(width: 5),
                        Text(
                          'Зөвшөөрөх',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 50),
                InkWell(
                  onTap: () async {
                    final FirebaseFirestore firestore =
                        FirebaseFirestore.instance;
                    final QuerySnapshot querySnapshot = await firestore
                        .collection('leave')
                        .where('Approvers', arrayContains: name)
                        .get();

                    querySnapshot.docs.forEach((document) async {
                      final dynamic approverField =
                          (document.data() as dynamic)['Approver'];
                      if (approverField is List) {
                        final List<dynamic> approvers = approverField;
                        for (var i = 0; i < approvers.length; i++) {
                          final dynamic approver = approvers[i];
                          if (approver is Map<String, dynamic>) {
                            if (approver['name'] == name) {
                              approver['status'] = 'Татгалзсан';
                              approver['date'] = DateTime.now().toString();
                              print(
                                  'Updating document ${document.id}: $approvers');
                              await document.reference
                                  .update({'Approver': approvers});
                            }
                          } else {
                            print('Unexpected data type: $approver');
                          }
                        }
                      } else {
                        print('Unexpected data type: $approverField');
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Color(0xFF6750A4),
                      duration: Duration(seconds: 1),
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 170,
                          right: 20,
                          left: 20),
                      content: Text(
                        'Амжилттай',
                        style: TextStyle(color: Colors.white),
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 10, left: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF625B71),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.cancel_outlined,
                            color: Colors.white, size: 18),
                        SizedBox(width: 5),
                        Text(
                          'Татгалзах',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
