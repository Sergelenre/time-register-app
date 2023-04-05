import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  @override
  void initState() {
    super.initState();
  }

  List<String> roles = ['PM', 'Team Leader', 'Developer', 'Admin'];
  String roleValue = 'PM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "SIGN UP",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 100, right: 20, left: 20),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailTextController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameTextController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordTextController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneTextController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text("Role:"),
                    SizedBox(width: 20),
                    Container(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black)),
                      child: DropdownButton<String>(
                        value: roleValue,
                        items:
                            roles.map<DropdownMenuItem<String>>((String value) {
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
                signInSignUpButton(context, false, () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailTextController.text,
                          password: passwordTextController.text)
                      .then((value) async {
                    print("CREATED");
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('role', roleValue);
                    prefs.setString('name', nameTextController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationScreen()));
                    final FirebaseFirestore firestore =
                        FirebaseFirestore.instance;
                    final Map<String, dynamic> data = {
                      'name': nameTextController.text,
                      'email': emailTextController.text,
                      'phone': phoneTextController.text,
                      'role': roleValue,
                    };
                    firestore
                        .collection('workers')
                        .add(data)
                        .then((value) async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("SUCCESS")),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("UNSUCCESS")),
                      );
                    });
                  });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
