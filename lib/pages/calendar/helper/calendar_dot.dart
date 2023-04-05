import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CalendarDot extends StatelessWidget {
  const CalendarDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 10,
      width: 10,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 0, 88, 170),
      ),
      child: Text(
        ".",
        style: const TextStyle(
            fontSize: 10, color: Color.fromARGB(255, 0, 88, 170)),
      ),
    );
  }
}
