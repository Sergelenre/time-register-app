import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/home/widgets/green_snackbar.dart';
import '../../pages/home/widgets/text_snackbar.dart';
import '../../server/server.dart';
import '../../server/user.dart';
import '../device/dev_id.dart';
import 'get_name.dart';

class SavedDataGreen {
  void initalGetSavedData(BuildContext context) async {
    var myInstance = GetName();
    setDeviceId(identifier);
    // sharedPreferences = await SharedPreferences.getInstance();
    // String? hello = sharedPreferences.getString("userdata");
    // // if (hello != null) {
    //   Map<String, dynamic> jsondatais = jsonDecode(hello);
    //   user = User.fromJson(jsondatais);

    //   if (jsondatais.isNotEmpty) {
    //     setDeviceId(identifier);
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: GreenSnackbar(),
    //         behavior: SnackBarBehavior.floating,
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //       ),
    //     );
    //   }
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: TextSnackbar(),
    //       backgroundColor: Color.fromARGB(255, 56, 56, 56),
    //     ),
    //   );
    // }
  }
}