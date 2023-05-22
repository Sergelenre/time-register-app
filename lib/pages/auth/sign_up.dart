import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timo/pages/auth/sign_in.dart';
import 'package:timo/pages/auth/widgets/reusable.dart';

import '../navigator/navigtor.dart';

TextEditingController passwordTextController = TextEditingController();
TextEditingController nameTextController = TextEditingController();
TextEditingController emailTextController = TextEditingController();
TextEditingController phoneTextController = TextEditingController();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool hasClickedButton = false;
  @override
  void initState() {
    super.initState();
  }

  String? nameValidator(String? value) {
    if (value! == null || value.isEmpty) {
      return 'Нэрээ оруулна уу';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value! == null || value.isEmpty) {
      return 'Имэйл хаягаа оруулна уу';
    }
    if (!EmailValidator.validate(value)) {
      return 'Зөв имэйл хаяг оруулна уу';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value! == null || value.isEmpty) {
      return 'Нууц үгээ оруулна уу';
    }
    if (value.length < 6) {
      return 'Нууц үгийн урт 6-с дээш байх ёстой';
    }
    return null;
  }

  List<String> roles = ['PM', 'Team Leader', 'Developer', 'Admin'];
  String roleValue = 'PM';
  bool isLoading = false;

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
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop(SignInScreen());
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
                  padding: EdgeInsets.only(top: 150, right: 30, left: 30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailTextController,
                        cursorColor: Colors.grey,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          errorText: hasClickedButton
                              ? emailValidator(emailTextController.text)
                              : null,
                          labelText: 'Цахим хаяг',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nameTextController,
                        cursorColor: Colors.grey,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          errorText: hasClickedButton
                              ? nameValidator(nameTextController.text)
                              : null,
                          labelText: 'Нэр',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordTextController,
                        cursorColor: Colors.grey,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          errorText: hasClickedButton
                              ? passwordValidator(passwordTextController.text)
                              : null,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Role :", style: TextStyle(fontSize: 20)),
                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: DropdownButton<String>(
                              value: roleValue,
                              items: roles.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    value: value, child: Text(value));
                              }).toList(),
                              onChanged: (String? newValue) {
                                print("click  sss");
                                setState(() {
                                  roleValue = newValue ?? '';
                                });
                                print(roleValue);
                              },
                            ),
                          ),
                        ],
                      ),
                      signInSignUpButton(context, false, () async {
                        setState(() {
                          isLoading = true;
                          hasClickedButton = true;
                        });
                        if (nameTextController.text.isEmpty ||
                            emailTextController.text.isEmpty ||
                            passwordTextController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Бүгдийг нь бөглөнө үү")),
                          );
                          return;
                        }

                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: emailTextController.text,
                                  password: passwordTextController.text);
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('role', roleValue);
                          prefs.setString('email', emailTextController.text);
                          prefs.setString('name', nameTextController.text);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BottomNavigationScreen()));
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
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Color(0xFF6750A4),
                              duration: Duration(seconds: 1),
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height - 150,
                                  right: 20,
                                  left: 20),
                              content: Text(
                                'Амжилттай бүртгэгдлээ.',
                                style: TextStyle(color: Colors.white),
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ));
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Color(0xFF6750A4),
                              duration: Duration(seconds: 1),
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height - 170,
                                  right: 20,
                                  left: 20),
                              content: Text(
                                'Амжилтгүй.',
                                style: TextStyle(color: Colors.white),
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ));
                          });
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.message ?? "Амжилтгүй")),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Амжилтгүй")),
                          );
                        }
                        setState(() {
                          isLoading = false; // hide loading indicator
                        });
                      })
                    ],
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
                color: Color(0xFF6750A4),
              ),
            ),
          ),
      ],
    );
  }
}
