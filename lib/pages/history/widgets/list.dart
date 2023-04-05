import 'package:flutter/material.dart';

class List extends StatelessWidget {
  final dynamic data;
  final dynamic index;

  const List({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: const BoxDecoration(
          border: Border(
        bottom:
            BorderSide(width: 1.0, color: Color.fromARGB(255, 207, 207, 207)),
      )),
      margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            style: const TextStyle(color: Colors.black),
            '${data.docs[index]['arrival']}',
          ),
          Text(
            style: const TextStyle(color: Colors.black),
            '${data.docs[index]['endDate']}',
          ),
          Text(
            style: const TextStyle(color: Colors.black),
            '${data.docs[index]['date']}',
          ),
          Text(
            style: const TextStyle(color: Colors.black),
            '${data.docs[index]['difference']['hours']}:${data.docs[index]['difference']['min']} мин',
          ),
        ],
      ),
    );
  }
}
