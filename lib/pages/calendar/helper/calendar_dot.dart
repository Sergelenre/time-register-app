import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CalendarDot extends StatelessWidget {
  const CalendarDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 7,
      width: 7,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromARGB(255, 121, 121, 121),
      ),
      child: Text(
        ".",
        style: const TextStyle(fontSize: 10, color: Color(0xFF21005D)),
      ),
    );
  }
}
