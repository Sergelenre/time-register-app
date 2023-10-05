import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timo/pages/auth/sign_in.dart';
import 'package:timo/pages/auth/widgets/reusable.dart';
import 'package:timo/pages/navigator/navigtor.dart';

TextEditingController passwordTextController = TextEditingController();
TextEditingController nameTextController = TextEditingController();
TextEditingController emailTextController = TextEditingController();
TextEditingController phoneTextController = TextEditingController();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Define _formKey here
  bool hasClickedButton = false;
  bool isLoading = false;

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Нэрээ оруулна уу';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Имэйл хаягаа оруулна уу';
    }
    if (!EmailValidator.validate(value)) {
      return 'Зөв имэйл хаяг оруулна уу';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Нууц үгээ оруулна уу';
    }
    if (value.length < 6) {
      return 'Нууц үгийн урт 6-с дээш байх ёстой';
    }
    return null;
  }

  List<String> roles = ['PM', 'Team Leader', 'Developer', 'Admin'];
  String roleValue = 'PM';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Ionicons.chevron_back, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
            ),
            title: Text(
              'Бүртгэл',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 150, right: 30, left: 30),
                  child: Form(
                    key: _formKey, // Use _formKey here
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailTextController,
                          cursorColor: Colors.grey,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            icon: Icon(
                              Ionicons.mail_outline,
                              color: Color.fromARGB(255, 187, 187, 187),
                            ),
                            labelText: 'Цахим хаяг',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 212, 212, 212),
                              ),
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: emailValidator,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: nameTextController,
                          cursorColor: Colors.grey,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            icon: Icon(
                              Ionicons.person_outline,
                              color: Color.fromARGB(255, 187, 187, 187),
                            ),
                            labelText: 'Нэр',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 212, 212, 212),
                              ),
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: nameValidator,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordTextController,
                          cursorColor: Colors.grey,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            icon: Icon(
                              Ionicons.lock_closed_outline,
                              color: Color.fromARGB(255, 187, 187, 187),
                            ),
                            labelText: 'Нууц үг',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 212, 212, 212),
                              ),
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          obscureText: true,
                          validator: passwordValidator,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Role :", style: TextStyle(fontSize: 20)),
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButton<String>(
                                value: roleValue,
                                items: roles.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    roleValue = newValue ?? '';
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        signInSignUpButton(context, false, () async {
                          setState(() {
                            hasClickedButton = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            isLoading = true;
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                      email: emailTextController.text,
                                      password: passwordTextController.text);
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('role', roleValue);
                              prefs.setString(
                                  'email', emailTextController.text);
                              prefs.setString('name', nameTextController.text);

                              final FirebaseFirestore firestore =
                                  FirebaseFirestore.instance;
                              final Map<String, dynamic> data = {
                                'name': nameTextController.text,
                                'email': emailTextController.text,
                                'role': roleValue,
                              };
                              firestore
                                  .collection('workers')
                                  .add(data)
                                  .then((value) async {
                                Fluttertoast.showToast(
                                  msg: "Амжилттай Бүртгэгдлээ",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Color.fromARGB(255, 50, 138, 91),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigationScreen()));
                              }).catchError((error) {
                                Fluttertoast.showToast(
                                  msg: "Амжилтгүй",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Color.fromARGB(255, 253, 96, 65),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              });
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(e.message ?? "Амжилтгүй")),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Амжилтгүй")),
                              );
                            }
                            setState(() {
                              isLoading = false;
                            });
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.white.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color.fromARGB(255, 51, 51, 51),
              ),
            ),
          ),
      ],
    );
  }
}
