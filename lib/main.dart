import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:mh_care/Model/Models/user_data.dart';
import 'package:mh_care/View/Home%20Screens/homeScreen.dart';
import 'package:mh_care/View/Initial_Screens/sign_up.dart';
import 'package:mh_care/View/Initial_Screens/splash_Screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mh_care/View/Initial_Screens/log_in.dart';

import 'Old/Model/Models/user_data.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GetUserData>(create: (context) => GetUserData()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isTimerDone = false;

  @override
  void initState() {
    Timer(Duration(seconds: 3), () => setState(() => _isTimerDone = true));
    super.initState();
  }

  Widget _getScreenId() {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !_isTimerDone) {
          return SplashScreen();
        }
        if (snapshot.hasData && _isTimerDone) {
          Provider.of<GetUserData>(context, listen: false).currentUserId =
              snapshot.data.uid;
          return HomeScreen(
            currentUserId: snapshot.data.uid,
          );
        } else {
          return Login();
        }
      },
    );
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      title: 'Notes And More',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //2
          primaryColor: Colors.grey,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Montserrat', //3
          buttonTheme: ButtonThemeData(
            // 4
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            buttonColor: Colors.lightBlueAccent[300],
          )),
      home: _getScreenId(),
      // routes: {
      //   Login.id: (context) => Login(),
      //   Signup.id: (context) => Signup(),
      //   HomeScreen.id: (context) => HomeScreen(),
      // },
    );
  }
}
