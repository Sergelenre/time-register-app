import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timo/pages/request/view/vac_request_detail.dart';

import '../../navigator/navigtor.dart';
import '../widgets/leave_list.dart';
import '../widgets/vac_list.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({Key? key}) : super(key: key);

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    _streamVRequestItems = _referenceVacationList.snapshots();

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  CollectionReference _referenceVacationList =
      FirebaseFirestore.instance.collection("vacations");
  Stream<QuerySnapshot>? _streamVRequestItems;

  @override
  Widget build(BuildContext context) {
    _referenceVacationList.get();
    _referenceVacationList.snapshots();

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
          'Ирсэн хүсэлтүүд',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 216, 216, 216)))),
                  child: Column(
                    children: [
                      TabBar(
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Color(0xFF6750A4),
                        labelColor: Color(0xFF6750A4),
                        controller: tabController,
                        tabs: [
                          Tab(text: 'Амралт'),
                          Tab(text: 'Чөлөө'),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      VacationList(),
                      LeaveList(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
