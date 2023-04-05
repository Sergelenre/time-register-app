import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timo/pages/request/view/request_detail.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({Key? key}) : super(key: key);

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  CollectionReference _referenceVacationList =
      FirebaseFirestore.instance.collection("vacations");
  Stream<QuerySnapshot>? _streamVRequestItems;

  @override
  void initState() {
    super.initState();
    _streamVRequestItems = _referenceVacationList.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    _referenceVacationList.get();
    _referenceVacationList.snapshots();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Requests",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _streamVRequestItems,
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
                                  FirestoreListWidget(name: document['name'])));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 30, left: 30),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 211, 211, 211))),
                      ),
                      child: Text(document['name']),
                    ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
