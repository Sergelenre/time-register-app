import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timo/pages/auth/sign_up.dart';

import '../navigator/navigtor.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String role = "";
  String name = "";
  String email = "";
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();

  Future<void> getData() async {
    print("asdadd");
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("workers")
        .where('email', isEqualTo: emailTextController.text)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      return querySnapshot.docs.first;
    });
    if (snapshot != null) {
      role = snapshot.get('role');
      name = snapshot.get('name');
      email = snapshot.get('email');
      print('NAME: $name');
      print('Role: $role');
      print('Email: $email');
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('role', role);
    prefs.setString('email', email);
    prefs.setString('name', name);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => BottomNavigationScreen()));
  }

  String? passwordError = "";
  String? emailError = "";

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'Хэрэглэгч олдсонгүй';
        emailTextController.clear();
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Нууц үг буруу байна';
        passwordTextController.clear();
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Цахим хаяг буруу байна';
        emailTextController.clear();
      }
      if (errorMessage.isNotEmpty) {
        setState(() {
          emailError = errorMessage;
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset('assets/imgs/logo.jpg', width: 280),
                    SizedBox(height: 40),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Цахим хаяг оруулна уу';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Цахим хаяг буруу байна';
                        }
                        return null;
                      },
                      controller: emailTextController,
                      cursorColor: Colors.grey,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorText: emailError,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Нууц үгээ оруулна уу';
                        }
                        if (value.length < 6) {
                          return 'Нууц үг хамгийн багадаа 6 тэмдэгт байх ёстой';
                        }
                        return null;
                      },
                      controller: passwordTextController,
                      cursorColor: Colors.grey,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        errorText: passwordError,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(52),
                          backgroundColor: Color(0xFF6750A4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text('Нэвтрэх'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            await signIn();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Color(0xFF6750A4),
                              duration: Duration(seconds: 1),
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height - 100,
                                  right: 20,
                                  left: 20),
                              content: Text(
                                'Амжилттай нэвтэрлээ.',
                                style: TextStyle(color: Colors.white),
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ));
                          }
                        }),
                    SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        "Бүртгүүлэх",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
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
      ),
    );
  }
}
