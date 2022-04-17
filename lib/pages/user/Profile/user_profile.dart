// ignore_for_file: prefer_const_constructors


import 'package:authentication/pages/user/Profile/profile_mnue.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'header.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                          child: Icon(Icons.arrow_back_ios,size: 25,)),
                          "Account".text.bold.size(25).makeCentered(),
                      "".text.make(),
                    ],
                  ),
                )),
            Expanded(
              child: ListView(
                children: const [
                  SizedBox(
                    height: 60,
                  ),
                  ProfileHeader(),
                  SizedBox(
                    height: 20,
                  ),
                  ProfileMenuList()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
