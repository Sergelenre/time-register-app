import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: TextField(
        minLines: 5,
        controller: _textController,
        maxLines: null, // Set maxLines to null to allow unlimited lines
        keyboardType: TextInputType.multiline, // Set keyboardType to multiline
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          hintText: 'Шалтгаан',
          border: OutlineInputBorder(),
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
