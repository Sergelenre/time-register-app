import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timo/server/user.dart';

class TextFieldName extends StatefulWidget {
  const TextFieldName({super.key});

  @override
  State<TextFieldName> createState() => _TextFieldNameState();
}

class _TextFieldNameState extends State<TextFieldName> {
  final _formfield = GlobalKey<FormState>();
  late String _errorMsg;
  final TextEditingController _nameFIELD = TextEditingController();

  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    initalGetSavedData();
  }

  void initalGetSavedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("userdata") != null) {
      Map<String, dynamic> jsondatais =
          jsonDecode(sharedPreferences.getString("userdata")!);
      User user = User.fromJson(jsondatais);
      if (jsondatais.isNotEmpty) {
        _nameFIELD.value = TextEditingValue(text: user.name);
      }
    }
  }

  void storedata() {
    User user = User(_nameFIELD.text);

    String userdata = jsonEncode(user);
    print(userdata);

    sharedPreferences.setString('userdata', userdata);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formfield,
      child: Column(
        children: [
          TextFormField(
            controller: _nameFIELD,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 233, 233, 233),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
              labelText: 'Нэр ээ оруулна уу',
              labelStyle: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 102, 102, 102),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Нэр ээ оруулна уу";
              } else {
                return null;
              }
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 63, 204, 162),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    if (_formfield.currentState!.validate()) {
                      print("success");
                    }
                    storedata();
                    print(_nameFIELD.value);
                  },
                  child: const Text(
                    "Сануулах",
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formfield.currentState!.validate()) {
                      print("success");
                    }
                    sharedPreferences.remove("userdata");
                    _nameFIELD.value = const TextEditingValue(text: "");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 63, 164, 204),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    "Mартах",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
