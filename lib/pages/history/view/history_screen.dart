import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/list-cat.dart';
import '../widgets/list.dart';
import '../../../domain/device/dev_id.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final storage = const FlutterSecureStorage();
  var sharedPreferences = SharedPreferences.getInstance();

  late Stream<QuerySnapshot> users = FirebaseFirestore.instance
      .collection("users")
      .where('device', isEqualTo: "")
      .orderBy('date', descending: true)
      .snapshots();
  @override
  void initState() {
    super.initState();
    deviceIdHistory();
    getDeviceId();
  }

  String deviceId = "";

  void deviceIdHistory() async {
    String? deviceId1 = await getDeviceId();
    print("AAAAAAAAAAAAAAAAAAAAAAAAAA");
    print(deviceId1);
    if (deviceId1 != null) {
      setState(() {
        deviceId = deviceId1;
        users = FirebaseFirestore.instance
            .collection("users")
            .where('device', isEqualTo: deviceId1)
            .snapshots();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          toolbarHeight: 110,
          title: const Padding(
            padding: EdgeInsets.only(top: 40, left: 10),
            child: Text(
              "Таны ажлын цагын\nтүүх",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        body: deviceId != ""
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: StreamBuilder<QuerySnapshot>(
                  stream: users,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
                    if (snapshot.hasError) {
                      return const Text("aldaa");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("loading..");
                    }

                    final data = snapshot.requireData;
                    return Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 30, right: 30),
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 223, 223, 223),
                                borderRadius: BorderRadius.circular(10)),
                            child: const ListCate()),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.size,
                          itemBuilder: (context, index) {
                            if (index == 0 ||
                                data.docs[index]["date"] !=
                                    data.docs[index == 0 ? 0 : index - 1]
                                        ["date"]) {
                              if (data.docs[index]['arrival'] != "") {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    List(data: data, index: index),
                                  ],
                                );
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    List(data: data, index: index),
                                  ],
                                );
                              }
                            } else {
                              if (data.docs[index]['arrival'] != "") {
                                return List(data: data, index: index);
                              } else {
                                return List(data: data, index: index);
                              }
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              )
            : const ListCate(),
      ),
    );
  }
}
