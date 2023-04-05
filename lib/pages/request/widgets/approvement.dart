import 'package:flutter/material.dart';

class Approve extends StatefulWidget {
  const Approve({Key? key}) : super(key: key);

  @override
  State<Approve> createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  List<String> itemsleader = ['Sukhee', 'Magnai', 'Dambii'];
  List<String> itemspm = ['Batsaihan', 'Uynga', 'Amarjargal'];
  String dropdownValueleader = 'Sukhee';
  String dropdownValuepm = 'Batsaihan';

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  value: dropdownValuepm,
                  items: itemspm.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValuepm = newValue ?? '';
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
                  value: dropdownValueleader,
                  items:
                      itemsleader.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValueleader = newValue ?? '';
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
