import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mh_care/Controller/SharedPreferencesGetXController.dart';
// import 'package:mh_care/Model/Services/Size_helper.dart';
// import 'package:mh_care/Model/Services/auth_Services.dart';
import 'package:mh_care/Model/Services/Size_helper.dart';
import 'package:mh_care/Model/Services/auth_Services.dart';
import 'package:mh_care/Model/UserData/UserData.dart';
import 'package:mh_care/Pages/About_US.dart';
import 'package:mh_care/Pages/log_in.dart';
import 'package:mh_care/main.dart';


import 'Contact_Us.dart';
import 'BooksCategoryPage.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height = displayHeight(context) -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    SharedPreferencesGetXController prefController = Get.find();
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: _height * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.darken),
                    image: AssetImage('assets/oldImages/thom.jpg'))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.white),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/oldImages/user.png'))),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: _height * .01),
                    child: Text(
                      prefController.pref.getString(UserData.USER_NAME),
                      style:
                      TextStyle(color: Colors.white, fontSize: _height * .03),
                    ),
                  ),
                  Text(
                    prefController.pref.getString(UserData.USER_EMAIL),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            tileColor: Colors.transparent,
            title: Text(
              'All Categories',
              style: TextStyle(fontSize: _height * 0.023),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
            onTap: () {
              Get.to(()=>BooksCategoryPage());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ),
              // );
            },
          ),
          Divider(
            height: 5,
          ),
          ListTile(
            tileColor: Colors.transparent,
            title: Text(
              'About Us',
              style: TextStyle(fontSize: _height * 0.023),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
            onTap: () {
              Get.to(()=>AboutUs());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AboutUs()),
              // );
            },
          ),
          Divider(
            height: 5,
          ),
          ListTile(
            tileColor: Colors.transparent,
            title: Text(
              'Contact Us',
              style: TextStyle(fontSize: _height * 0.023),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
            onTap: () {
              Get.to(()=>ContactUs());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ContactUs()),
              // );
            },
          ),
          Divider(
            height: 5,
          ),
          ListTile(
            tileColor: Colors.transparent,
            title: Text(
              'Logout ',
              style: TextStyle(fontSize: _height * 0.023, color: Colors.red),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.red,
            ),
            onTap: () {
              AuthServices.logout();
              Get.off(()=>LoginPage());
              // Navigator.pop(context);
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (BuildContext context) => MyApp()));
            },
          ),
          Divider(
            height: 5,
          ),
        ],
      ),
    );
  }
}

// class UserHomePage extends StatefulWidget {
//   final String currentUserId;
//   UserHomePage(this.currentUserId);
//   @override
//   _UserHomePageState createState() => _UserHomePageState();
// }

// class _UserHomePageState extends State<UserHomePage> {
//   final replyController = TextEditingController();
//   final trackingController = TextEditingController();
//
//   Column getData(double _height, Map<String, dynamic> documentFields) {
//     return Column(
//       children: [
//         Container(
//           height: _height * 0.4,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   fit: BoxFit.cover,
//                   colorFilter: new ColorFilter.mode(
//                       Colors.black.withOpacity(0.4), BlendMode.darken),
//                   image: AssetImage('assets/thom.jpg'))),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 80,
//                   width: 80,
//                   decoration: BoxDecoration(
//                       color: Colors.white60,
//                       shape: BoxShape.circle,
//                       border: Border.all(width: 2, color: Colors.white),
//                       image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: AssetImage('assets/user.png'))),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: _height * .01),
//                   child: Text(
//                     documentFields['name'],
//                     style:
//                         TextStyle(color: Colors.white, fontSize: _height * .03),
//                   ),
//                 ),
//                 Text(
//                   documentFields['email'],
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         ListTile(
//           tileColor: Colors.transparent,
//           title: Text(
//             'All Categories',
//             style: TextStyle(fontSize: _height * 0.023),
//           ),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             color: Colors.black,
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => BooksCategoryPage()),
//             );
//           },
//         ),
//         Divider(
//           height: 5,
//         ),
//         ListTile(
//           tileColor: Colors.transparent,
//           title: Text(
//             'About Us',
//             style: TextStyle(fontSize: _height * 0.023),
//           ),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             color: Colors.black,
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => AboutUs()),
//             );
//           },
//         ),
//         Divider(
//           height: 5,
//         ),
//         ListTile(
//           tileColor: Colors.transparent,
//           title: Text(
//             'Contact Us',
//             style: TextStyle(fontSize: _height * 0.023),
//           ),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             color: Colors.black,
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ContactUs()),
//             );
//           },
//         ),
//         Divider(
//           height: 5,
//         ),
//         ListTile(
//           tileColor: Colors.transparent,
//           title: Text(
//             'Logout ',
//             style: TextStyle(fontSize: _height * 0.023, color: Colors.red),
//           ),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             color: Colors.red,
//           ),
//           onTap: () {
//             AuthServices.logout();
//             // Navigator.pop(context);
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (BuildContext context) => MyApp()));
//           },
//         ),
//         Divider(
//           height: 5,
//         ),
//       ],
//     );
//   }
//
//   Stream<DocumentSnapshot> provideDocumentFieldStream() {
//     return FirebaseFirestore.instance
//         .collection('user')
//         .doc(widget.currentUserId)
//         .snapshots();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final _height = displayHeight(context) -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//           child: StreamBuilder<DocumentSnapshot>(
//               stream: provideDocumentFieldStream(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<DocumentSnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }
//                 if (snapshot.hasData) {
//                   Map<String, dynamic> documentFields = snapshot.data.data();
//
//                   return getData(_height, documentFields);
//                 }
//               })),
//     );
//   }
// }
