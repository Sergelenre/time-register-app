import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/vac_request_detail.dart';

class VacationList extends StatefulWidget {
  const VacationList({super.key});

  @override
  State<VacationList> createState() => _VacationListState();
}

class _VacationListState extends State<VacationList> {
  @override
  void initState() {
    super.initState();
    saveData();
  }

  CollectionReference referenceVacationList =
      FirebaseFirestore.instance.collection("vacations");
  Stream<QuerySnapshot>? streamVRequestItems;
  String name = "";
  void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name')!;
    });
    print(name);
    streamVRequestItems = referenceVacationList
        .where('Approvers', arrayContains: name)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: streamVRequestItems,
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FirestoreListWidget(document: document)));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 211, 211, 211))),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              document['name'],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(DateFormat('yyyy-MM-dd')
                                .format(document['startDate'].toDate())),
                            Text(' ~ '),
                            Text(DateFormat('yyyy-MM-dd')
                                .format(document['endDate'].toDate())),
                          ],
                        )
                      ],
                    ),
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
