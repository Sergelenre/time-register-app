import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../request/view/leave.dart';
import '../request/view/request_list.dart';
import '../request/view/sent_request.dart';
import '../request/view/vacation.dart';

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
          height: 100,
          child: DrawerHeader(
            child: Text('Хүсэлтүүд',
                style: TextStyle(fontWeight: FontWeight.bold)),
            decoration: BoxDecoration(
              color: Color(0xFFE7E0EC),
            ),
          ),
        ),
        ListTile(
          title: Text('Амралт'),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => VacationScreen()));
          },
        ),
        ListTile(
          title: Text('Чөлөө'),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LeaveFormScreen()));
          },
        ),
        ListTile(
          title: Text('Бусад'),
          onTap: () {
            print('s');
          },
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
            bottom:
                BorderSide(color: Color.fromARGB(255, 219, 219, 219), width: 1),
          )),
          child: ListTile(
            title: Text('Илгээсэн хүсэлтүүд'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SentRequests()));
            },
          ),
        ),
        if (role == 'PM' || role == 'Admin' || role == 'Team Leader')
          ListTile(
            title: Text('Ирсэн хүсэлтүүд'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RequestListScreen()));
            },
          ),
      ],
    );
  }
}
