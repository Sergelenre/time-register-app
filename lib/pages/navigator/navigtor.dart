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
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: const Color(0xFFE7E0EC),
          selectedItemColor: Color.fromARGB(255, 19, 19, 19),
          unselectedItemColor: Color.fromARGB(255, 19, 19, 19),
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
                size: 20,
                Icons.home_rounded,
                color: Color.fromARGB(255, 19, 19, 19),
              ),
              label: "Нүүр",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                size: 20,
                Icons.history_rounded,
                color: Color.fromARGB(255, 19, 19, 19),
              ),
              label: "Түүх",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month_outlined,
                size: 20,
                color: Color.fromARGB(255, 19, 19, 19),
              ),
              label: "Календар",
            ),
          ],
        ),
      ),
    );
  }
}
