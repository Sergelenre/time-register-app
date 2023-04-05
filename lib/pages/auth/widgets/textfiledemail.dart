import 'package:flutter/material.dart';

import '../sign_up.dart';

class TextFieldEmail extends StatelessWidget {
  const TextFieldEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailTextController,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(labelText: 'Email'),
    );
  }
}
