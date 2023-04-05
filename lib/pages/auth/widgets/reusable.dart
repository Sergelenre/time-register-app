import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 200,
    height: 200,
  );
}

TextFormField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  print("ggaggg");
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Color.fromARGB(255, 88, 88, 88)),
    decoration: InputDecoration(
      errorText: isPasswordType
          ? validatePassword(controller.text)
          : validateEmail(controller.text),
      prefixIcon: Icon(
        icon,
        color: Color.fromARGB(255, 196, 196, 196),
      ),
      labelText: text,
      labelStyle: TextStyle(color: Color.fromARGB(255, 196, 196, 196)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Color.fromARGB(255, 233, 233, 233),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

String nulll = "";
String validatePassword(String value) {
  if (!(value.length > 5) && value.isNotEmpty) {
    return "Password should contain more than 6 characters";
  }
  return nulll;
}

String validateEmail(String value) {
  print("aaa");
  if (!value.isNotEmpty) {
    return "Enter correctly pls";
  }
  return nulll;
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    margin: const EdgeInsets.only(top: 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'LOGIN' : 'SIGN UP',
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black;
            }
            return Color.fromARGB(255, 15, 15, 15);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
    ),
  );
}
