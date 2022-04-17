// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'MnueList.dart';
import 'header.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                color: Colors.white,
                child: "Profile".text.bold.size(25).makeCentered().py(10),),
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
                 MenuList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
