import 'package:authentication/pages/user/get_started.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authentication/pages/user/user_main.dart';
import 'package:flutter/material.dart';
import 'package:authentication/pages/signup.dart';
import 'package:authentication/pages/forgot_password.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //to keep user logged in
  final storage = new FlutterSecureStorage();

  userLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // print(userCredential.user?.uid);
      // write into storage to keep the user credentials store
      await storage.write(key: 'uid', value: userCredential.user?.uid);


      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserMain()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Login Successfully",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        leading: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> GetStarted()));
            },
            child: Icon(Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor,
              size: 40,
            )
        ),
        // title: Text(TaskApp.title),
        // centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 80,),
                    Text('Welcome Back!!',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text('Start with Signin',
                        style: TextStyle(
                        color: Colors.grey,
                        // fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
              Container(
                width: 50,
                height: 300,
                child: Lottie.asset('assets/login.json'),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Email: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(30)
                      ),
                    ),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(30)
                      ),
                    ),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;
                          });
                          userLogin();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        elevation: 10,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ),
                        )
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account? "),
                    TextButton(
                      onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, a, b) => Signup(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                            (route) => false)
                      },
                      child: Text('Signup'),
                    ),
                    // TextButton(
                    //   onPressed: () => {
                    //     Navigator.pushAndRemoveUntil(
                    //         context,
                    //         PageRouteBuilder(
                    //           pageBuilder: (context, a, b) => UserMain(),
                    //           transitionDuration: Duration(seconds: 0),
                    //         ),
                    //         (route) => false)
                    //   },
                    //   child: Text('Dashboard'),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
