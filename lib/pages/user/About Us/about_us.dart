import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'about_us_data.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "About Us".text.bold.make(),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
             "WelCome to Baitk".text.black.size(25).bold.makeCentered(),
              const SizedBox(height: 20,),

              aboutUs.text.size(16).make(),
              SizedBox(height: 20,),
              " Please give your support and love.".text.size(16).make(),
              const SizedBox(height: 20,),
              "Thanks For Visiting".text.bold.size(16).makeCentered(),
              const SizedBox(height: 20,),
              "Have a nice day!".text.bold.size(16).makeCentered()
            ],
          ),
        ),
      ),
    );
  }
}
