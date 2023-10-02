import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timo/pages/navigator/slide_tab_bar.dart';

import '../../navigator/navigtor.dart';

class LeaveFormScreen extends StatefulWidget {
  const LeaveFormScreen({super.key});

  @override
  State<LeaveFormScreen> createState() => _LeaveFormScreenState();
}

class _LeaveFormScreenState extends State<LeaveFormScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  List<String> admin = [" "];
  List<String> itemsPmLeader = [" "];
  String dropdownValueAdmin = ' ';
  String dropdownValuePmLeader = ' ';

  Future<void> fetchData() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('workers').get();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        snapshot.docs;
    documents.forEach((doc) {
      final String name = doc.get('name');
      final String role = doc.get('role');
      if (role == 'Team Leader' || role == 'PM') {
        setState(() {
          itemsPmLeader.add(name);
          dropdownValuePmLeader = name;
        });
      } else if (role == 'Admin') {
        setState(() {
          admin.add(name);
          dropdownValueAdmin = name;
        });
      }
      print("itemspm");
      print(itemsPmLeader);
    });
  }

  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );

    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startDate),
    );

    if (pickedTime != null) {
      setState(() {
        _startDate = DateTime(_startDate.year, _startDate.month, _startDate.day,
            pickedTime.hour, pickedTime.minute);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_endDate),
    );

    if (pickedTime != null) {
      setState(() {
        _endDate = DateTime(_endDate.year, _endDate.month, _endDate.day,
            pickedTime.hour, pickedTime.minute);
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Ionicons.chevron_back_outline, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen()));
          },
        ),
        title: Text(
          'Чөлөөний хүсэлт',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      endDrawer: Drawer(
        backgroundColor: Color(0xFFE7E0EC),
        width: 200,
        child: SideTabBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _selectStartDate(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 12, top: 15, bottom: 15, right: 12),
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
                      child: Text(
                        '${_startDate.year}-${_startDate.month.toString().padLeft(2, '0')}-${_startDate.day.toString().padLeft(2, '0')} ${_startDate.hour.toString().padLeft(2, '0')}:${_startDate.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  Text("to"),
                  InkWell(
                    onTap: () {
                      _selectEndDate(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 12, top: 15, bottom: 15, right: 12),
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
                      child: Text(
                        '${_endDate.year}-${_endDate.month.toString().padLeft(2, '0')}-${_endDate.day.toString().padLeft(2, '0')} ${_endDate.hour.toString().padLeft(2, '0')}:${_endDate.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Шалтгаан аа бичнэ үү';
                    }
                    return null;
                  },
                  minLines: 5,
                  controller: _textController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 233, 233, 233)),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF7F2FA))),
                    filled: true,
                    fillColor: Color.fromARGB(255, 233, 233, 233),
                    hintText: 'Шалтгаан',
                    hintStyle: TextStyle(
                      color: Color(0xFF79747E),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Эхний :"),
                    SizedBox(width: 20),
                    Container(
                      width: 190.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 235, 235, 235)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButton<String>(
                          icon: Visibility(
                              visible: false,
                              child: Icon(Icons.arrow_downward)),
                          value: dropdownValuePmLeader,
                          items: itemsPmLeader
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValuePmLeader = newValue ?? '';
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Дараагийн :"),
                    SizedBox(width: 20),
                    Container(
                      width: 190.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 235, 235, 235)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButton<String>(
                          icon: Visibility(
                              visible: false,
                              child: Icon(Icons.arrow_downward)),
                          underline: Container(),
                          value: dropdownValueAdmin,
                          items: admin
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValueAdmin = newValue ?? '';
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 80),
            InkWell(
              onTap: () async {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  final FirebaseFirestore firestore =
                      FirebaseFirestore.instance;
                  final prefs = await SharedPreferences.getInstance();
                  final name = prefs.getString('name');
                  final Map<String, dynamic> data = {
                    'name': name,
                    'startDate': _startDate,
                    'endDate': _endDate,
                    'reason': _textController.text,
                    'Approver': [
                      {
                        "name": dropdownValuePmLeader,
                        "status": "Хүлээгдэж байна....",
                        "date": "Хүлээгдэж байна...",
                      },
                      {
                        "name": dropdownValueAdmin,
                        "status": "Хүлээгдэж байна...",
                        "date": "Хүлээгдэж байна...",
                      },
                    ],
                    'Approvers': [dropdownValuePmLeader, dropdownValueAdmin],
                  };
                  firestore.collection('leave').add(data).then((value) {
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
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationScreen()),
                    );
                  }).catchError((error) {
                    Fluttertoast.showToast(
                      msg: "Амжилтгүй",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color.fromARGB(255, 253, 96, 65),
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  });
                }
              },
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(255, 43, 43, 43),
                ),
                child: Center(
                  child: Text(
                    'Илгээх',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
