import 'package:authentication/pages/login.dart';
import 'package:authentication/pages/signup.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {

  // bool hasInternet = false;
  // ConnectivityResult result = ConnectivityResult.none;
  //
  // checkInterent() async{
  //   hasInternet = await InternetConnectionChecker().hasConnection;
  //   final text = hasInternet? 'Internet' : 'No Internet';
  //   final color = hasInternet? Colors.green : Colors.red;
  //
  //   result = await Connectivity().checkConnectivity();
  //
  //
  //   if(result == ConnectivityResult.mobile){
  //     showSimpleNotification(
  //       Text(
  //         '$text: Mobile Network',
  //         style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 20
  //         ),
  //
  //       ),
  //       background: color,
  //     );
  //   }
  //   else if(result == ConnectivityResult.wifi){
  //     showSimpleNotification(
  //       Text(
  //         '$text: Wifi Network',
  //         style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 20
  //         ),
  //
  //       ),
  //       background: color,
  //     );
  //   }else{
  //     showSimpleNotification(
  //       Text(
  //         '$text: No Network',
  //         style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 20
  //         ),
  //
  //       ),
  //       background: color,
  //     );
  //   }
  //
  //
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(25),
          child: ListView(
            children: [

              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 130),
                  child: Text('Self Manager \n| Your personal Assistant',
                      style: TextStyle(fontSize: 30.0,
                          color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
              ),
              Container(
                // height: 320,
                child: Stack(
                  children: [

                    Positioned(
                      child: Lottie.asset('assets/welcome.json'),
                      // top: 20,
                      // height: 500,
                    ),
                    Positioned(
                      child: Lottie.asset('assets/get-started-btn.json'),
                      width: 450,
                      height: 540,
                      // bottom: 5,
                    ),
                  ],
                )

              ),
              SizedBox(
                height: 20,
              ),

              Container(

                margin: EdgeInsets.symmetric(vertical: 15),
                // padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: (){

                    // function for internet connectivity..
                    // checkInterent();
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(18),
                    elevation: 10,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),),
                  ),
                  child: Text('Login',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                  onPressed: (){
                    // checkInterent();
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Signup()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(18),
                    elevation: 10,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),),
                  ),
                  child: Text('Signup',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text('version 3.0.5',
                      style: TextStyle(fontSize: 18.0,
                      color: Theme.of(context).primaryColor
                      )
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
