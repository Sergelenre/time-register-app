import 'package:flutter/material.dart';
import 'package:timo/pages/request/view/leave.dart';
import 'package:timo/pages/request/view/vacation.dart';

class ReqButtons extends StatelessWidget {
  const ReqButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VacationScreen()));
          },
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding:
                EdgeInsets.only(right: 125, left: 125, top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Color.fromARGB(255, 36, 36, 36),
            ),
            child: Text(
              'Амралт',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LeaveFormScreen()));
          },
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding:
                EdgeInsets.only(right: 130, left: 130, top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Color.fromARGB(255, 36, 36, 36),
            ),
            child: Text(
              'Чөлөө',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding:
                EdgeInsets.only(right: 130, left: 130, top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Color.fromARGB(255, 36, 36, 36),
            ),
            child: Text(
              'Бусад',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding:
                EdgeInsets.only(right: 130, left: 130, top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Color.fromARGB(255, 36, 36, 36),
            ),
            child: Text(
              'Бусад',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
