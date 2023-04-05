import 'package:flutter/material.dart';

class BlueSnackbar extends StatelessWidget {
  const BlueSnackbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 100,
      decoration: BoxDecoration(
        border:
            Border.all(width: 6, color: const Color.fromARGB(255, 20, 20, 20)),
        color: const Color.fromARGB(255, 63, 164, 204),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Явсан : ${DateTime.now()}",
            style: const TextStyle(
                color: Colors.black, fontSize: 20),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
