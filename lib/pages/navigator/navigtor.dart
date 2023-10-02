import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timo/pages/calendar/calendar_history.dart';
import 'package:timo/pages/history/view/history_screen.dart';
import 'package:timo/pages/home/view/home_screen.dart';
// import 'package:timo/pages/request/view/main_request.dart';

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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: BottomNavigationBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            selectedItemColor: Color.fromARGB(255, 0, 0, 0),
            unselectedItemColor: Color.fromARGB(255, 19, 19, 19),
            iconSize: 18,
            selectedFontSize: 12,
            unselectedFontSize: 10,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Ionicons.ellipse_outline,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                label: "Нүүр",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Ionicons.time_outline,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                label: "Түүх",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Ionicons.calendar_outline,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                label: "Календар",
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
