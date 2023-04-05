import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:timo/server/server.dart';
import 'package:timo/server/user.dart';

import '../../auth/sign_in.dart';
import '../../auth/sign_up.dart';
import '../../history/view/history_screen.dart';
import '../widgets/textfield.dart';
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
  late User user;
  String ipv4 = "";
  String Ip = "";

  @override
  void initState() {
    super.initState();
    checkIp();
    _getDeviceDetails();
    saveData();
  }

  var name = "";
  void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')!;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Row(
                  children: [
                    const Text(
                      'Цаг бүртгэлийн\nаппликейшнд тавтай\nморил',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        },
                        child: Icon(Icons.logout_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Text("Сайн байнa уу ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(
                        name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        SavedDataGreen().initalGetSavedData(context);
                        myInstance.getName(1, identifier);
                      },
                      child: const StartButton(),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      child: InkWell(
                        onTap: () {
                          saveddataB.initalGetSavedDataBlue(context);
                          myInstance.getName(0, identifier);
                        },
                        child: const EndButton(),
                      ),
                    )
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
