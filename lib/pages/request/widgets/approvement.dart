import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FirstApprover extends StatefulWidget {
  const FirstApprover({super.key});

  @override
  State<FirstApprover> createState() => _FirstApproverState();
}

class _FirstApproverState extends State<FirstApprover> {
  List<String> admin = ["Galaa ah"];
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Дараагийн зөвшөөрөл :"),
        SizedBox(width: 20),
        Container(
          padding: EdgeInsets.only(right: 18, left: 10),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: DropdownButton<String>(
            value: dropdownValueAdmin,
            items: admin.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValueAdmin = newValue ?? '';
              });
            },
          ),
        ),
      ],
    );
  }
}
