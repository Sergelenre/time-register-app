import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timo/pages/request/view/leave.dart';
import 'package:timo/pages/request/view/request_list.dart';
import 'package:timo/pages/request/view/sent_request.dart';
import 'package:timo/pages/request/view/vacation.dart';

class SideTabBar extends StatefulWidget {
  const SideTabBar({super.key});

  @override
  State<SideTabBar> createState() => _SideTabBarState();
}

class _SideTabBarState extends State<SideTabBar> {
  @override
  void initState() {
    super.initState();
    savedRole();
  }

  var role;
  void savedRole() async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role');
    });
    print("role");
    print(role);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 110,
          child: DrawerHeader(
            child: Text(
              'Хүсэлтүүд',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 51, 51, 51),
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Амралт',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => VacationScreen()));
          },
        ),
        ListTile(
          title: Text(
            'Чөлөө',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LeaveFormScreen()));
          },
        ),
        ListTile(
          title: const Text(
            'Бусад',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            print('s');
          },
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
            bottom:
                BorderSide(color: Color.fromARGB(255, 41, 41, 41), width: 1),
          )),
          child: ListTile(
            title: Text(
              'Илгээсэн хүсэлтүүд',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SentRequests()));
            },
          ),
        ),
        if (role == 'PM' || role == 'Admin' || role == 'Team Leader')
          ListTile(
            title: Text(
              'Ирсэн хүсэлтүүд',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RequestListScreen()));
            },
          ),
      ],
    );
  }
}
