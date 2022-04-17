import 'package:authentication/pages/user/Profile/profile.dart';
import 'package:authentication/pages/user/categories.dart';
import 'package:authentication/pages/user/sideBar.dart';
import 'package:authentication/pages/user/task/Task_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authentication/pages/login.dart';
import 'package:authentication/pages/user/change_password.dart';
import 'package:authentication/pages/user/dashboard.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  final storage = new FlutterSecureStorage();

  String name = '';
  fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    print(user!.uid);

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get()
          .then((ds) {
        name = ds['name'];

      });
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: SideBar(),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Welcome, $name'),
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
