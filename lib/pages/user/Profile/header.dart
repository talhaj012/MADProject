// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  uploadImage(String path) async {
    close = context.showLoading(msg: "Uploading", textColor: Colors.white);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("profileImages/$email");
    UploadTask uploadTask = ref.putFile(File(path));
    await uploadTask.whenComplete(() async {
      String url = await ref.getDownloadURL();
      print(url);
      updateImage(url);
    }).catchError((onError) {
      print(onError);
    });
  }

  updateImage(url) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .update({'imageUrl': url});
    } catch (e) {
      print(e.toString());
    }
    await Future.delayed(1.milliseconds, close);
    setState(() {
      image = url;
    });
  }

  fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    print(user!.uid);

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get()
          .then((ds) {
        email = ds['email'];
        name = ds['name'];
        image = ds['imageUrl'];
      });
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final result = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    final path = result!.path;
    uploadImage(path);
  }

  String? name;
  String? email;
  dynamic close;
  String image = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: Colors.purple[400],
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                )),
          ),
          Positioned(
              left: MediaQuery.of(context).size.width * .50-80,
              right: MediaQuery.of(context).size.width * .50-80,
              top: -50,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage(image.toString()),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(width: 5, color: Colors.white),
                ),
              )),
          Positioned(
            left: MediaQuery.of(context).size.width * .50,
            top: 35,
            child: GestureDetector(
              onTap: () async {
                pickImage();
              },
              child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.purple,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                name.toString().text.white.bold.size(25).make(),
                SizedBox(
                  height: 15,
                ),
                email.toString().text.white.size(20).make(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
