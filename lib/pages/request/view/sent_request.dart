import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timo/pages/navigator/slide_tab_bar.dart';
import 'package:timo/pages/request/widgets/sent_leave.dart';
import 'package:timo/pages/request/widgets/sent_vac.dart';

import '../../navigator/navigtor.dart';

class SentRequests extends StatefulWidget {
  const SentRequests({super.key});

  @override
  State<SentRequests> createState() => _SentRequestsState();
}

class _SentRequestsState extends State<SentRequests>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Ionicons.chevron_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen()));
          },
        ),
        title: Text(
          'Илгээсэн хүсэлтүүд',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      endDrawer: Drawer(
        backgroundColor: Color(0xFFE7E0EC),
        width: 200,
        child: SideTabBar(),
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
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Color.fromARGB(255, 51, 51, 51),
                        labelColor: Color.fromARGB(255, 51, 51, 51),
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
                      SentVac(),
                      SentLeave(),
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
