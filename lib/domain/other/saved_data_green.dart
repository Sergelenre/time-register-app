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
  }
}
