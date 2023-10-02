import 'package:flutter/material.dart';

class EndButton extends StatelessWidget {
  const EndButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color.fromARGB(255, 233, 240, 242),
      ),
      child: Center(
        child: const Text(
          'Явсан',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
