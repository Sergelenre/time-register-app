import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timo/pages/auth/sign_in.dart';
import 'package:timo/pages/auth/sign_up.dart';
import 'package:timo/pages/navigator/navigtor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentIndex = 0;
  bool isLogin = false;

  final screens = [
    const SignInScreen(),
    const SignUpScreen(),
    const BottomNavigationScreen(),
  ];
  Future<void> checkScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    print("NAME: $name");
    if (name != "" && name != null) {
      setState(() {
        _currentIndex = 2;
      });
    } else {
      setState(() {
        _currentIndex = 0;
      });
    }
  }

  @override
  void initState() {
    _navigateToSignIn();
    checkScreen();
  }

  _navigateToSignIn() async {
    await Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => screens[_currentIndex]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(child: Image.asset('assets/imgs/logo.jpg')),
    );
  }
}
