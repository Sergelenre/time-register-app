import 'package:flutter/material.dart';

class TextSnackbar extends StatelessWidget {
  const TextSnackbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Та нэрээ оруулаад сануулах товчин дээр дарна уу',
      style: TextStyle(color: Colors.white),
    );
  }
}
