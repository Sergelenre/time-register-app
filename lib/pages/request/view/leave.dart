import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  List<String> admin = ["Galaa ah", "Ambo", "Uyanga"];
  List<String> itemsPmLeader = ["Batsaihan"];
  String dropdownValueAdmin = 'Galaa ah';
  String dropdownValuePmLeader = 'Batsaihan';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Чөлөө',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen()));
          },
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _selectStartDate(context);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Text(
                    '${_startDate.year}-${_startDate.month}-${_startDate.day} ${_startDate.hour}:${_startDate.minute}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(width: 30),
              Icon(Icons.arrow_forward_outlined, color: Colors.grey),
              SizedBox(width: 30),
              InkWell(
                onTap: () {
                  _selectEndDate(context);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Text(
                    '${_endDate.year}-${_endDate.month}-${_endDate.day} ${_endDate.hour}:${_endDate.minute}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: TextField(
            minLines: 5,
            controller: _textController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: 'Шалтгаан',
              border: OutlineInputBorder(),
            ),
            style: TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Эхний зөвшөөрөл"),
                  SizedBox(width: 20),
                  Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black)),
                    child: DropdownButton<String>(
                      value: dropdownValuePmLeader,
                      items: itemsPmLeader
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValuePmLeader = newValue ?? '';
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Дараагийн зөвшөөрөл"),
                  SizedBox(width: 20),
                  Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black)),
                    child: DropdownButton<String>(
                      value: dropdownValueAdmin,
                      items:
                          admin.map<DropdownMenuItem<String>>((String value) {
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
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            final FirebaseFirestore firestore = FirebaseFirestore.instance;
            final Map<String, dynamic> data = {
              // 'name': _nameController.text,
              'startDate': _startDate,
              'endDate': _endDate,
              'reason': _textController.text,
              'leader&PMApproval': dropdownValuePmLeader,
              'adminApproval': dropdownValueAdmin,
            };
            firestore.collection('leave').add(data).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("SUCCESS")),
              );
            }).catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("UNSUCCESS")),
              );
            });
          },
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding:
                EdgeInsets.only(right: 140, left: 140, top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Color.fromARGB(255, 36, 36, 36),
            ),
            child: Text(
              'Илгээх',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
