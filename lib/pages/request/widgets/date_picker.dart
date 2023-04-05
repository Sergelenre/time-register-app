import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

DateTime _startDate = DateTime.now();
DateTime _endDate = DateTime.now();

class _DatePickerState extends State<DatePicker> {
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2024));
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
    print("startDate");
    print(_startDate);
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _endDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2024));
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
    print("endDate");
    print(_endDate);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                '${_startDate.year}-${_startDate.month}-${_startDate.day}',
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
                '${_endDate.year}-${_endDate.month}-${_endDate.day}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
