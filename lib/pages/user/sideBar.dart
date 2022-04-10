import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).primaryColor,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('images/myimg.jpg'),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text('Muhammad Talha Jaan',
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text('iamtalha012@gmail.com',
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              leading: Icon(
                Icons.people,
                color: Colors.white70,
              ),
              title: Text(
                'People',
                style: TextStyle(color: Colors.white),
              ),
              hoverColor: Colors.white10,
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.white70,
              ),
              title: Text(
                'Phone',
                style: TextStyle(color: Colors.white),
              ),
              hoverColor: Colors.white10,
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.white70,
              ),
              title: Text(
                'Email',
                style: TextStyle(color: Colors.white),
              ),
              hoverColor: Colors.white10,
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.photo,
                color: Colors.white70,
              ),
              title: Text(
                'Photo',
                style: TextStyle(color: Colors.white),
              ),
              hoverColor: Colors.white10,
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.update,
                color: Colors.white70,
              ),
              title: Text(
                'Update Profile',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              hoverColor: Colors.white10,
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.password,
                color: Colors.white70,
              ),
              title: Text(
                'Change Password',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              hoverColor: Colors.white10,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}