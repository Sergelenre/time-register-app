import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timo/pages/auth/sign_up.dart';
import 'package:timo/pages/navigator/navigtor.dart';
// import 'package:timo/navigator/navigtor.dart';
// import 'package:timo/pages/signUpPage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();
  String role = "";
  String name = "";
  String email = "";
  String? passwordError;
  String? emailError;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

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
  }

  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
      passwordError = null;
      emailError = null;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      await getData();
      Fluttertoast.showToast(
        msg: "Амжилттай",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 50, 138, 91),
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          emailError = 'Хэрэглэгч олдсонгүй';
        } else if (e.code == 'wrong-password') {
          passwordError = 'Нууц үг буруу байна';
        } else if (e.code == 'invalid-email') {
          emailError = 'Цахим хаяг буруу байна';
        }
      });
    } catch (e) {
      print('Error during sign-in: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/imgs/logo.jpg',
                      width: 280,
                    ),
                    const SizedBox(height: 40),
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
                        icon: Icon(
                          Ionicons.mail_outline,
                          color: Color.fromARGB(255, 187, 187, 187),
                        ),
                        labelText: 'Цахим хаяг',
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 212, 212, 212)),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorText: emailError,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                        icon: Icon(
                          Ionicons.lock_closed_outline,
                          color: Color.fromARGB(255, 187, 187, 187),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 212, 212, 212)),
                        ),
                        errorText: passwordError,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(52),
                        backgroundColor: Color.fromARGB(255, 51, 51, 51),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await signIn();
                        }
                      },
                      child: Text('Нэвтрэх'),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
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
                  color: const Color.fromARGB(255, 51, 51, 51),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
