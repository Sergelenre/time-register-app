import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirestoreListWidget extends StatefulWidget {
  final String name;

  FirestoreListWidget({required this.name});

  @override
  _FirestoreListWidgetState createState() => _FirestoreListWidgetState();
}

class _FirestoreListWidgetState extends State<FirestoreListWidget> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();

    _stream = FirebaseFirestore.instance
        .collection('vacations')
        .where('name', isEqualTo: widget.name)
        .snapshots();
  }

  // void date() {
  //   print("GGGGGGGGGGGGGGGGGGGGGGGGGGG $document");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Detail",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  (documents[index].data() as Map<String, dynamic>);
              return Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text('Нэр'),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 280, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 224, 224, 224),
                        ),
                        child: Text(data['name']),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text('Шалтгаан'),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 300, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 224, 224, 224),
                        ),
                        child: Text(data['reason']),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text('Хугацаа'),
                        SizedBox(height: 10),
                        Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(255, 224, 224, 224),
                          ),
                          child: Row(
                            children: [
                              Text(
                                DateFormat('MMM d, yyyy')
                                    .format(data['startDate'].toDate()),
                              ),
                              Text(" - "),
                              Text(
                                DateFormat('MMM d, yyyy')
                                    .format(data['endDate'].toDate()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          print("tes");
                        },
                        child: Container(
                          padding: EdgeInsets.all(50),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 56, 163, 92),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'YES',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                      InkWell(
                        onTap: () {
                          print("ates");
                        },
                        child: Container(
                          padding: EdgeInsets.all(50),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 163, 56, 56),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'NO',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
