import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/vac_request_detail.dart';

class SentLeave extends StatefulWidget {
  const SentLeave({super.key});

  @override
  State<SentLeave> createState() => _SentLeaveState();
}

class _SentLeaveState extends State<SentLeave> {
  late Stream<QuerySnapshot> users = FirebaseFirestore.instance
      .collection("users")
      .where('device', isEqualTo: "")
      .orderBy('date', descending: true)
      .snapshots();
  @override
  void initState() {
    super.initState();
    emailHistory();
  }

  void emailHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    print("AAAAAAAAAAAAAAAAAAAAAAAAAA");
    if (name != null) {
      setState(() {
        users = FirebaseFirestore.instance
            .collection("leave")
            .where('name', isEqualTo: name)
            .snapshots();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: users,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.active) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                querySnapshot.docs;
            return ListView.builder(
              itemCount: listQueryDocumentSnapshot.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot document =
                    listQueryDocumentSnapshot[index];
                List<dynamic> approvers = document['Approver'];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 211, 211, 211),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: approvers.length,
                        itemBuilder: (context, index) {
                          Map<dynamic, dynamic> approver = approvers[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Approver",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Name:   ${approver['name']}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Status:  ${approver['status']}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Date:     ${approver['date']}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
