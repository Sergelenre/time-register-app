import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timo/server/server.dart';
import 'package:timo/server/user.dart';

late SharedPreferences sharedPreferences;
late User user;
String name = "";

class GetName {
  void getName(int value, identifier) async {
    final prefs = sharedPreferences = await SharedPreferences.getInstance();
    name = prefs.getString('name')!;
    // Map<String, dynamic> jsondatais =
    //     jsonDecode(sharedPreferences.getString("userdata")!);
    // user = User.fromJson(jsondatais);
    // checkUser(name: user.name, identifier: identifier);
    if (value == 1) {
      createStartDate(
        identifier: identifier,
        name: name,
        startDate: 'arrival',
      );
    } else {
      getdocId(name: "user.name", identifier: identifier);
    }
  }
}
