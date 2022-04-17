// ignore_for_file: prefer_const_constructors


import 'package:authentication/pages/user/Profile/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileMenuList extends StatefulWidget {
  const ProfileMenuList({Key? key}) : super(key: key);

  @override
  State<ProfileMenuList> createState() => _ProfileMenuListState();
}

class _ProfileMenuListState extends State<ProfileMenuList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
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
        name = ds['name'];
        email = ds['email'];
        gender = ds['Gender'];
        phone = ds['Phone'];
      });
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  String? name;
  String? email;
  String? gender;
  String? phone;

  int? _value = 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                      return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                              child: Wrap(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          size: 25,
                                        )),
                                    "Name".text.bold.size(18).make(),
                                    GestureDetector(
                                        onTap: () async {
                                          if (nameController.text.isNotEmpty) {
                                            update(1);
                                          }
                                        },
                                        child: "Done"
                                            .text
                                            .size(18)
                                            .bold
                                            .black
                                            .make()),
                                  ],
                                ),
                              ),
                              " ".text.make().py(5),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: TextFormField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "*required";
                                    }
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      hintText: name,
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2.0),
                                      )),
                                ),
                              ),
                              "  ".text.make().py(15),
                            ],
                          )));
                    },
                  );
                },
                child: ListTile(
                  title: "Name".text.bold.size(18).make(),
                  subtitle: name.toString().text.size(16).make(),
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
                      return ListT();
                    },
                  );
                },
                child: ListTile(
                  title: "Gender".text.bold.size(18).make(),
                  subtitle: gender.toString().text.size(16).make(),
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
                      return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                              child: Wrap(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          size: 25,
                                        )),
                                    "Phone No".text.bold.size(18).make(),
                                    GestureDetector(
                                        onTap: () async {
                                          if (phoneController.text.isNotEmpty) {
                                            update(3);
                                          }
                                        },
                                        child: "Done"
                                            .text
                                            .size(18)
                                            .bold
                                            .black
                                            .make()),
                                  ],
                                ),
                              ),
                              " ".text.make().py(5),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: TextFormField(
                                  controller: phoneController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "*required";
                                    }
                                  },
                                  obscureText: false,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      hintText: phone,

                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2.0),
                                      )),
                                ),
                              ),
                              "  ".text.make().py(15),
                            ],
                          )));
                    },
                  );
                },
                child: ListTile(
                  title: "Phone Number".text.bold.size(18).make(),
                  subtitle: phone.toString().text.size(16).make(),
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
              ListTile(
                title: "Email".text.bold.size(18).make(),
                subtitle: email.toString().text.size(16).make(),
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
                      return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                              child: Wrap(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          size: 25,
                                        )),
                                    "Password".text.bold.size(18).make(),
                                    GestureDetector(
                                        onTap: () async {
                                          if (passwordController
                                                  .text.isNotEmpty &&
                                              passwordController.text.length >
                                                  6) {
                                            update(4);
                                          }
                                        },
                                        child: "Done"
                                            .text
                                            .size(18)
                                            .bold
                                            .black
                                            .make()),
                                  ],
                                ),
                              ),
                              " ".text.make().py(5),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "*required";
                                    }
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "********",
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2.0),
                                      )),
                                ),
                              ),
                              "  ".text.make().py(15),
                            ],
                          )));
                    },
                  );
                },
                child: ListTile(
                  title: "Password".text.bold.size(18).make(),
                  subtitle: "*********".toString().text.size(16).make(),
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

  updateData(int index) async {
    final user = FirebaseAuth.instance.currentUser;
    print(user!.uid);

    if (index == 1) {
      try {
        await FirebaseFirestore.instance
            .collection('Technician')
            .doc(user.uid)
            .update({'name': nameController.text});
      } catch (e) {
        print(e.toString());
      }
    } else if (index == 3) {
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({'Phone': phoneController.text});
      } catch (e) {
        print(e.toString());
      }
    } else {
     try{
       final ref = FirebaseAuth.instance.currentUser;

       await ref!.updatePassword(passwordController.text);

       if(ref == null)
         {

         }
     }
     catch(e){
       String a = e.toString();
       print("Hello $a");
     }
    }
  }

  update(index) async {
    dynamic close =
        context.showLoading(msg: "Loading", textColor: Colors.white);
    await updateData(index);
    await Future.delayed(1.milliseconds, close);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserProfile()));
  }
}

class ListT extends StatefulWidget {
  const ListT({Key? key}) : super(key: key);

  @override
  _ListTState createState() => _ListTState();
}

class _ListTState extends State<ListT> {
  int? _value = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
            child: Wrap(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                      )),
                  "Select Gender".text.bold.size(18).make(),
                  GestureDetector(
                      onTap: () async {
                        if (_value != 0) {
                          dynamic close = context.showLoading(
                              msg: "Loading", textColor: Colors.white);
                          final user = FirebaseAuth.instance.currentUser;
                          try {
                            await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(user!.uid)
                                .update({
                              'Gender': _value == 1
                                  ? "Male"
                                  : _value == 2
                                      ? "Female"
                                      : "Other"
                            });
                          } catch (e) {
                            print(e.toString());
                          }
                          await Future.delayed(1.milliseconds, close);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfile()));
                        }
                      },
                      child: "Done".text.size(18).bold.black.make()),
                ],
              ),
            ),
            " ".text.make().py(5),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  children: [
                    Card(
                      color: Colors.grey[300],
                      child: ListTile(
                        title: "Male".text.size(16).bold.make(),
                        leading: Radio(
                          value: 1,
                          groupValue: _value,
                          activeColor: Color(0xFF6200EE),
                          onChanged: (int? value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.grey[300],
                      child: ListTile(
                        title: "Female".text.size(16).bold.make(),
                        leading: Radio(
                          value: 2,
                          groupValue: _value,
                          activeColor: Color(0xFF6200EE),
                          onChanged: (int? value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.grey[300],
                      child: ListTile(
                        title: "Other".text.size(16).bold.make(),
                        leading: Radio(
                          value: 3,
                          groupValue: _value,
                          activeColor: Color(0xFF6200EE),
                          onChanged: (int? value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                )),
            "  ".text.make().py(15),
          ],
        )));
  }
}
