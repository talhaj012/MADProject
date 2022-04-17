// ignore_for_file: prefer_const_constructors


import 'package:authentication/pages/login.dart';
import 'package:authentication/pages/user/About%20Us/about_us.dart';
import 'package:authentication/pages/user/Profile/address.dart';
import 'package:authentication/pages/user/Profile/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MenuList extends StatelessWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
                child: ListTile(
                  title: "Account".text.bold.size(18).make(),
                  leading: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.black,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
                },
                child: ListTile(
                  title: "About Us".text.bold.size(18).make(),
                  leading: Icon(
                    Icons.info,
                    size: 30,
                    color: Colors.black,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    isDismissible: false,
                    enableDrag: false,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                    ),
                    builder: (BuildContext context) {
                      return AddressGet();
                    },
                  );
                },
                child: ListTile(
                  title: "Address".text.bold.size(18).make(),
                  leading: Icon(
                    Icons.location_on,
                    size: 30,
                    color: Colors.black,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
                },
                child: ListTile(
                  title: "Log Out".text.bold.size(18).make(),
                  leading: Icon(
                    Icons.logout,
                    size: 30,
                    color: Colors.black,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
