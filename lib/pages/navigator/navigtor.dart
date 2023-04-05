import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:timo/pages/request/view/main_request.dart';

import '../calendar/calendar_history.dart';
import '../history/view/history_screen.dart';
import '../home/view/home_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 0;

  final screens = [
    const HomeScreen(),
    const HistoryScreen(),
    CalendarScreen(),
    RequestScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 15, 15, 15),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          iconSize: 30,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) => setState(
            () => _currentIndex = index,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                color: Colors.white,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history_rounded,
                color: Colors.white,
              ),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month_outlined,
                color: Colors.white,
              ),
              label: "Calendar",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.note_outlined,
                color: Colors.white,
              ),
              label: "Requests",
            ),
          ],
        ),
      ),
    );
  }
}
