import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../domain/device/dev_id.dart';
import '../navigator/navigtor.dart';
import '../navigator/slide_tab_bar.dart';
import 'helper/calendar_dot.dart';
import 'helper/date_format.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Stream<QuerySnapshot> users = FirebaseFirestore.instance
      .collection("users")
      .where('device', isEqualTo: "")
      .snapshots();
  @override
  void initState() {
    super.initState();
    // deviceIdHistory();
    dates();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Календар',
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
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 30.0, left: 30),
        child: Column(
          children: [
            TableCalendar(
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Color(0xFF6750A4),
                  shape: BoxShape.circle,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                showDialog(
                  context: context,
                  builder: (context) {
                    print(myMap[selectedDay]);
                    if (myMap[selectedDay]?.isNotEmpty ?? false) {
                      return AlertDialog(
                        title: Text("Ирсэн болон Явсан цаг"),
                        content: Text("Ирсэн :" +
                            myMap[selectedDay]![0].toString() +
                            "\n" +
                            "Явсан :" +
                            (myMap[selectedDay]!.length > 1
                                ? myMap[selectedDay]![1].toString()
                                : "")),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    } else {
                      return AlertDialog(
                        title: Text("Selected Date and Time"),
                        content: Text("Цаг байхгүй"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2050, 1, 1),
              focusedDay: today,
              eventLoader: (day) => myMap[day] ?? [],
              calendarBuilders: CalendarBuilders(
                  singleMarkerBuilder: (context, date, events) {
                String times = events.toString();
                print("AA $events");
                return Center(child: CalendarDot());
              }),
            ),
          ],
        ),
      ),
    );
  }
}
