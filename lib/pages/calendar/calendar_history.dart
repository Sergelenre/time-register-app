import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../domain/device/dev_id.dart';
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
    deviceIdHistory();
    dates();
  }

  void deviceIdHistory() async {
    String? deviceId1 = await getDeviceId();
    print("AAAAAAAAAAAAAAsdaAAAAAAAAAAAA");
    print(deviceId1);
    if (deviceId1 != null) {
      setState(() {
        dates();
      });
    }
  }

  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: CalendarStyle(
              cellMargin: EdgeInsets.all(1.0),
              cellPadding: EdgeInsets.only(right: 20, bottom: 20),
              todayDecoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                shape: BoxShape.rectangle,
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
                          myMap[selectedDay]![1].toString()),
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
            calendarBuilders:
                CalendarBuilders(singleMarkerBuilder: (context, date, events) {
              String times = events.toString();
              print("AA $events");
              return Center(child: CalendarDot());
            }),
          ),
        ],
      ),
    );
  }
}
