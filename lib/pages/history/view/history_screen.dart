import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timo/pages/home/view/home_screen.dart';
import 'package:timo/pages/navigator/navigtor.dart';

import '../../navigator/slide_tab_bar.dart';
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
    emailHistory();
    getDeviceId();
    savedRole();
  }

  String emails = "";

  void emailHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    print("AAAAAAAAAAAAAAAAAAAAAAAAAA");
    print(email);
    if (email != null) {
      setState(() {
        emails = email;
        users = FirebaseFirestore.instance
            .collection("users")
            .where('email', isEqualTo: email)
            .snapshots();
      });
    }
  }

  var role;
  void savedRole() async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
    print("role");
    print(role);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
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
            'Түүх',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        endDrawer: Drawer(
          backgroundColor: Color(0xFFE7E0EC),
          width: 200,
          child: SideTabBar(),
        ),
        body: emails != ""
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
                              border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(255, 219, 219, 219),
                                    width: 1),
                              ),
                            ),
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
