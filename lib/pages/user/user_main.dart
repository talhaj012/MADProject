import 'package:authentication/pages/user/categories.dart';
import 'package:authentication/pages/user/sideBar.dart';
import 'package:authentication/pages/user/task/Task_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authentication/pages/login.dart';
import 'package:authentication/pages/user/change_password.dart';
import 'package:authentication/pages/user/dashboard.dart';
import 'package:authentication/pages/user/profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserMain extends StatefulWidget {
  UserMain({Key? key}) : super(key: key);

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Profile(),
    // TaskApp(),
    // Categories(),
    ChangePassword(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Welcome, Talha!!"),
            // ElevatedButton(
            //   onPressed: () async => {
            //     await FirebaseAuth.instance.signOut(),
            //     // deleting the key after logging out the user..
            //     await storage.delete(key: 'uid'),
            //
            //     Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => Login(),
            //         ),
            //         (route) => false)
            //   },
            //   child: Text('Logout'),
            //   style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
            // )
            Text('Logout',
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 20
              ),)
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () async => {
                await FirebaseAuth.instance.signOut(),
                // deleting the key after logging out the user..
                await storage.delete(key: 'uid'),

                Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                builder: (context) => Login(),
                ),
                (route) => false)
                },
              child: Icon(Icons.logout),),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'User Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Change Password',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}
