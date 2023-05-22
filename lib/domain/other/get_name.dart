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
    if (value == 1) {
      createStartDate(
        identifier: identifier,
        name: name,
        startDate: 'arrival',
      );
    } else {
      getdocId(name: name, identifier: identifier);
    }
  }
}
