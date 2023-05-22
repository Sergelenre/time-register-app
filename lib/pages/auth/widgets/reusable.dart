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
    return "Нууц үг хамгийн багадаа 6 тэмдэгт байх ёстой";
  }
  return nulll;
}

String validateEmail(String value) {
  print("aaa");
  if (!value.isNotEmpty) {
    return "Цахим хаяг аа зөв хийнэ үү";
  }
  return nulll;
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 52,
    margin: const EdgeInsets.only(top: 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'LOGIN' : 'Бүртгүүлэх',
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Color(0xFF6750A4);
            }
            return Color(0xFF6750A4);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)))),
    ),
  );
}
