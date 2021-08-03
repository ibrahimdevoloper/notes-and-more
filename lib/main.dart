// import 'dart:async';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mh_care/Controller/SharedPreferencesGetXController.dart';
import 'package:mh_care/Model/UserData/UserData.dart';
import 'package:mh_care/Pages/Admin_Home.dart';
import 'package:mh_care/Pages/User_Home.dart';
import 'package:mh_care/Pages/splash_Screen.dart';

// import 'package:mh_care/Pages/splash_Screen.dart';
// import 'package:mh_care/Pages/IntroPage.dart';

// import 'package:mh_care/Model/Models/user_data.dart';
// import 'package:mh_care/View/Home%20Screens/homeScreen.dart';
// import 'package:mh_care/View/Initial_Screens/sign_up.dart';
// import 'package:mh_care/View/Initial_Screens/splash_Screen.dart';
import 'package:provider/provider.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mh_care/View/Initial_Screens/log_in.dart';

import 'Model/Models/user_data.dart';
import 'Pages/homeScreen.dart';
import 'Pages/log_in.dart';

void main() {
  runApp(
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<UserData>(create: (context) => UserData()),
    //   ],
    //   child:
    MyApp(),
    // ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool _isTimerDone = false;
  //
  // @override
  // void initState() {
  //   Timer(Duration(seconds: 3), () => setState(() => _isTimerDone = true));
  //   super.initState();
  // }
  //
  // Widget _getScreenId() {
  //   return StreamBuilder<User>(
  //     stream: FirebaseAuth.instance.authStateChanges(),
  //     builder: (BuildContext context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting ||
  //           !_isTimerDone) {
  //         return SplashScreen();
  //       }
  //       if (snapshot.hasData && _isTimerDone) {
  //         // Provider.of<GetUserData>(context, listen: false).currentUserId =
  //         //     snapshot.data.uid;
  //         return HomeScreen(
  //           currentUserId: snapshot.data.uid,
  //         );
  //       } else {
  //         return LoginPage();
  //       }
  //     },
  //   );
  // }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // return SplashScreen(
    //   navigateAfterFuture: Firebase.initializeApp(),
    //   image: Image.asset( 'assets/images/appIcon.png',),
    //   pageRoute: GetPageRoute(
    //     page: ()=>LoginPage()
    //   ),
    // );
    return FutureBuilder(
        future: Future.wait(
          [
            Firebase.initializeApp(),
            SharedPreferences.getInstance(),
            Future.delayed(
              Duration(seconds: 2),
            ),
          ],
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            SharedPreferences pref = snapshot.data[1];
            Get.create(() => SharedPreferencesGetXController(pref));
          }
          return GetMaterialApp(
            title: 'Notes And More',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.cairoTextTheme(
                Theme.of(context).textTheme,
              ),
              primaryColor: Color(0xFF0061FF),
              accentColor: Color(0xFF60EFFF),
              scaffoldBackgroundColor: Colors.white,
              // textButtonTheme: TextButtonThemeData(
              //   style: TextButton.styleFrom(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(32.0),
              //     ),
              //     backgroundColor: Color(0xFF0061FF),
              //     padding: EdgeInsets.all(8),
              //   ),
              // ),
              //
              // outlinedButtonTheme: OutlinedButtonThemeData(
              //   style: OutlinedButton.styleFrom(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(32.0),s
              //     ),
              //     side: BorderSide(
              //       width: 4,
              //       color: Color(0xFF60EFFF),
              //     ),
              //     elevation: 0,
              //     padding: EdgeInsets.all(8),
              //   ),
              // ),
            ),
            home: snapshot.connectionState == ConnectionState.done
                ? StreamBuilder<User>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      SharedPreferencesGetXController prefController =
                          Get.find();
                      SharedPreferences pref = prefController.pref;

                      if (pref.containsKey(UserData.USER_ROLE)) {
                        User user = snapshot.data;
                        //check if the user is null first bc
                        //Shared pref may have a key and value but
                        //the user logged out
                        if (user == null) {
                          return LoginPage();
                        } else {
                          //TODO:Check the role from share pref
                          //if they are admin return admin page
                          //if they are user return user page
                          if (pref.getString(UserData.USER_ROLE).compareTo(UserData.USER_ROLE_ADMIN)==0)
                            return AdminHome();
                          else
                            return UserHome(pref.getString(UserData.USER_UID));
                        }
                      } else {
                        return LoginPage();
                      }
                    },
                  )
                : SplashScreen(),
            // SplashScreen(
            //   navigateAfterFuture: ,
            //   image: Image.asset( 'assets/images/appIcon.png',),
            //   photoSize: 150,
            //   pageRoute: GetPageRoute(
            //       page: ()=>LoginPage()
            //   ),
            // ),
            // _getScreenId(),
          );
        });
  }
}
