import 'package:cloud_firestore/cloud_firestore.dart';
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
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

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
      print('NAME: $name');
      print('Role: $role');
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('role', role);
    prefs.setString('name', name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(height: 40),
            TextFormField(
              controller: emailTextController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: passwordTextController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              child: Text('Sign In'),
              onPressed: () {
                signIn();
                getData();
              },
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text("SIGN UP?"),
            )
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailTextController.text.trim(),
            password: passwordTextController.text.trim())
        .then((value) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigationScreen()));
    });
  }
}
