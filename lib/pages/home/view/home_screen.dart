import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:timo/domain/device/dev_id.dart';
import 'package:timo/domain/other/get_name.dart';
import 'package:timo/domain/other/saved_data_blue.dart';
import 'package:timo/domain/other/saved_data_green.dart';
import 'package:timo/pages/auth/sign_in.dart';
import 'package:timo/pages/history/view/history_screen.dart';
import 'package:timo/pages/home/widgets/end_button.dart';
import 'package:timo/pages/home/widgets/start_button.dart';
import 'package:timo/pages/navigator/slide_tab_bar.dart';

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
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Ionicons.log_out_outline, color: Colors.black),
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
            icon: Icon(Ionicons.menu_outline, color: Colors.black),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      endDrawer: Drawer(
        backgroundColor: Color.fromARGB(255, 51, 51, 51),
        width: 200,
        child: SideTabBar(),
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 80, right: 30),
        child: Column(
          children: [
            Container(
              width: 250,
              child: Image.asset(
                'assets/imgs/logo.jpg',
                width: 280,
              ),
            ),
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
                          Fluttertoast.showToast(
                            msg: "Аль хэдийн дарагдсан байна.",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromARGB(255, 253, 96, 65),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        } else {
                          Fluttertoast.showToast(
                            msg: "Амжилттай",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromARGB(255, 50, 138, 91),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }

                        prefs.setString('lastClickedDate', currentDate);

                        SavedDataGreen().initalGetSavedData(context);
                        myInstance.getName(1, identifier);
                      },
                      child: const StartButton(),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        saveddataB.initalGetSavedDataBlue(context);
                        myInstance.getName(0, identifier);

                        Fluttertoast.showToast(
                          msg: "Амжилттай",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromARGB(255, 50, 138, 91),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
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
