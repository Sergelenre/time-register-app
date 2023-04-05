import 'package:flutter/material.dart';

class EndButton extends StatelessWidget {
  const EndButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(width: 6, color: const Color.fromARGB(255, 20, 20, 20)),
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 63, 164, 204),
      ),
      padding: const EdgeInsets.only(right: 40, left: 40, top: 20, bottom: 20),
      child: const Text(
        'Явсан',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
