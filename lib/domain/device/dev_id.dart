import 'package:timo/server/server.dart';

Future<String?> getDeviceId() async {
  Map<String, String> allValues = await storage.readAll();
  return allValues["deviceId"];
}

Future<String?> setDeviceId(String id) async {
  print("aaaaaaaaaaaaaaaaaaaaa $id");
  await storage.write(key: "deviceId", value: id);
  return null;
}
