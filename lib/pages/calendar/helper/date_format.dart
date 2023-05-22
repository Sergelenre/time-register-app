import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/device/dev_id.dart';

Map<DateTime, List<String>> myMap = {};

List<String> loop = [];
String deviceId = "";
String word = "";
String date = "";
String correctdate = "";
int firstDigit = 0;
int yearint = 0;
int monthint = 0;
int dayint = 0;
int hours = 0;
int minutes = 0;
int endhours = 0;
int endminutes = 0;
int seconds = 0;
var number = 0;
void dates() async {
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('email');
  myMap = {};
  FirebaseFirestore.instance
      .collection("users")
      .where('email', isEqualTo: email)
      .snapshots()
      .listen((querySnapshot) {
    querySnapshot.docs.forEach(
      (doc) {
        String dateString = doc.data()['date'];
        List<String> words = dateString.split("-");
        List<String> reversedWords = words.reversed.toList();
        String reversedString = reversedWords.join(" ");
        List<String> wordss = reversedString.split(" ");
        String lastWord = wordss.last;
        wordss.removeLast();
        String secondLastWord = wordss.last;
        wordss.removeLast();
        wordss.add(lastWord);
        wordss.add(secondLastWord);
        correctdate = wordss.join(" ");
        date = correctdate.replaceAll(" ", "");
        var year = date.substring(0, 4);
        var month = date.substring(4, 6);
        var day = date.substring(6, 8);
        yearint = int.parse(year);
        monthint = int.parse(month);
        dayint = int.parse(day);
        loop = [];

        if (doc.data()['arrival'] != "") {
          String arrival = doc.data()['arrival'];
          List<String> startTime = arrival.split(":");
          hours = int.parse(startTime[0]);
          minutes = int.parse(startTime[1]);
          seconds = int.parse(startTime[2]);
          loop.add(hours.toString() + ":" + minutes.toString());
        }
        if (doc.data()['endDate'] != "") {
          String endDate = doc.data()['endDate'];
          List<String> endTime = endDate.split(":");
          hours = int.parse(endTime[0]);
          minutes = int.parse(endTime[1]);
          seconds = int.parse(endTime[2]);
          loop.add(hours.toString() + ":" + minutes.toString());
        }
        myMap[DateTime.utc(
          yearint,
          monthint,
          dayint,
        )] = loop;
        print("KKKKKKKKKKKKKKKKKKK51515KKKKKKKKKKKK");
      },
    );
  });
}
