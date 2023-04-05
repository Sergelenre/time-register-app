import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../server/server.dart';
import 'dev_id.dart';

class GetDevId extends StatefulWidget {
  const GetDevId({Key? key}) : super(key: key);

  @override
  State<GetDevId> createState() => _GetDevIdState();
}

class _GetDevIdState extends State<GetDevId> {
  Future<void> getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        if (mounted) {
          setState(() {
            identifier = build.id;
          });
          setDeviceId(build.id);
        }
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        if (mounted) {
          setState(() {
            identifier = data.identifierForVendor!;
          });
          setDeviceId(data.identifierForVendor!);
        }
      }
    } on PlatformException {
      print("aldaa");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
