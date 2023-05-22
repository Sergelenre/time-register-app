import 'package:flutter/material.dart';

class ListCate extends StatelessWidget {
  const ListCate({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text(
          "Огноо",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        Text(
          "Ирсэн",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        Text(
          "Явсан",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        Text(
          "Нийт",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
