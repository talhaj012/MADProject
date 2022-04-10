import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:authentication/pages/user/get_started.dart';
import 'package:authentication/pages/user/user_main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:authentication/pages/login.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';
// import 'readData.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final storage = new FlutterSecureStorage();


  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;

  checkInterent() async{
    hasInternet = await InternetConnectionChecker().hasConnection;
    final text = hasInternet? 'Connected' : 'No Internet';
    final color = hasInternet? Colors.green : Colors.red;

    result = await Connectivity().checkConnectivity();


    if(result == ConnectivityResult.mobile){
      showSimpleNotification(
        Text(
          '$text to Mobile Data',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),

        ),
        background: color,
      );
    }
    else if(result == ConnectivityResult.wifi){
      showSimpleNotification(
        Text(
          '$text to Wifi Network',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),

        ),
        background: color,
      );
    }else{
      showSimpleNotification(
        Text(
          '$text: Kindly Connect to Internet or Data',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),

        ),
        background: color,
      );
    }


  }
  //
  // @override
  // void initState() {
  //   checkInterent();
  //   super.initState();
  // }



  Future<bool> checkingLoginStatus() async{
    checkInterent();
    String? value = await storage.read(key: 'uid');
    if(value == null){
      return false;
    }
    return true;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // checks for errors
          if (snapshot.hasError) {
            print("Somthing went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return OverlaySupport.global(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.purple,
              ),
              // home: UserMain(),
              home: FutureBuilder(
                  future: checkingLoginStatus(),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                      if(snapshot.data == false){
                        return AnimatedSplashScreen(
                            // duration: 10000,
                            backgroundColor: Colors.white,
                            // splashTransition: SplashTransition.slideTransition,
                            splash: Lottie.asset('assets/splash_logo.json'),
                            nextScreen: GetStarted()
                           );
                      }
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Container(
                          color: Colors.white,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return AnimatedSplashScreen(
                          // duration: 10000,
                          backgroundColor: Colors.white,
                          // splashTransition: SplashTransition.slideTransition,
                          splash: Lottie.asset('assets/splash_logo.json'),
                          nextScreen: UserMain());
                  }),
              // home: ReadScreen(),
            ),
          );
        });
  }
}
