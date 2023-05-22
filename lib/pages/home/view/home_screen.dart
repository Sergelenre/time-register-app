import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:timo/pages/auth/sign_up.dart';
import 'package:timo/server/user.dart';

import '../../auth/sign_in.dart';
import '../../history/view/history_screen.dart';
import '../../navigator/slide_tab_bar.dart';
import '../../../domain/device/dev_id.dart';
import '../../../domain/other/saved_data_green.dart';
import '../../../domain/other/get_name.dart';
import '../../../domain/other/saved_data_blue.dart';
import '../widgets/end_button.dart';
import '../widgets/start_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameFIELD = TextEditingController();
  late SharedPreferences sharedPreferences;
  var myInstance = GetName();
  var saveddataB = SavedDataBlue();
  String identifier = "";
  // late User user;
  String ipv4 = "";
  String Ip = "";
  bool _isButtonDisabled = false;
  @override
  void initState() {
    super.initState();
    checkIp();
    _getDeviceDetails();
    saveData();
    _checkButtonDisabledStatus();
    savedRole();
  }

  var name = "";
  var email = "";
  void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')!;
    email = prefs.getString('email')!;
    print(email);
  }

  int _currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const HistoryScreen(),
  ];
  void checkIp() async {
    String ipv4 = await Ipify.ipv4();
    if (mounted) {
      setState(() {
        Ip = ipv4;
      });
    }
    print(Ip);

    var connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        if (mounted) {
          setState(() {
            Ip = ipv4;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            Ip = '';
          });
        }
      }
    });
  }

  Future<void> _getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        if (mounted) {
          setState(() {
            identifier = build.id;
          });
          setDeviceId(build.id);
        }
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        if (mounted) {
          setState(() {
            identifier = data.identifierForVendor!;
          });
          setDeviceId(data.identifierForVendor!);
        }
      }
    } on PlatformException {
      print("aldaa");
    }
  }

  Future<void> _checkButtonDisabledStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? buttonDisabled = prefs.getBool('button_disabled');
    if (buttonDisabled != null) {
      setState(() {
        _isButtonDisabled = buttonDisabled;
      });
    }
  }

  var role;
  void savedRole() async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
    print("role");
    print(role);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.logout_sharp, color: Colors.black),
          onPressed: () async {
            await clearPrefs();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
        ),
        title: Text(
          'Нүүр',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      endDrawer: Drawer(
        backgroundColor: Color(0xFFE7E0EC),
        width: 200,
        child: SideTabBar(),
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 250, child: Image.asset('assets/imgs/logo.jpg')),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Цаг бүртгэл',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Сайн байнa уу ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String? lastClickedDate =
                            prefs.getString('lastClickedDate');
                        String currentDate =
                            DateTime.now().toString().substring(0, 10);

                        if (lastClickedDate != null &&
                            lastClickedDate == currentDate) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                            margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 170,
                              right: 20,
                              left: 20,
                            ),
                            content: Text(
                              'Аль хэдийн дарагдсан байна',
                              style: TextStyle(color: Colors.white),
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ));
                          return;
                        }

                        prefs.setString('lastClickedDate', currentDate);

                        SavedDataGreen().initalGetSavedData(context);
                        myInstance.getName(1, identifier);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Color(0xFF6750A4),
                          duration: Duration(seconds: 1),
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height - 170,
                            right: 20,
                            left: 20,
                          ),
                          content: Text(
                            'Амжилттай',
                            style: TextStyle(color: Colors.white),
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ));
                      },
                      child: const StartButton(),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        saveddataB.initalGetSavedDataBlue(context);
                        myInstance.getName(0, identifier);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Color(0xFF6750A4),
                          duration: Duration(seconds: 1),
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 170,
                              right: 20,
                              left: 20),
                          content: Text(
                            'Амжилттай',
                            style: TextStyle(color: Colors.white),
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ));
                      },
                      child: const EndButton(),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
