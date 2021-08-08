import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mh_care/Controller/SharedPreferencesGetXController.dart';

import 'package:mh_care/Model/Services/Size_helper.dart';
import 'package:mh_care/Model/Services/auth_Services.dart';
import 'package:mh_care/Model/UserData/UserData.dart';
import 'package:mh_care/Pages/AddBookPage.dart';
import 'package:mh_care/Pages/BooksCategoryPage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height = displayHeight(context) -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Admin Console'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Get.theme.primaryColor,
      ),
      body:
      Column(
        children: [
          Container(
            height: _height * 0.33,
            // color: Colors.lightBlueAccent,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                colors: [
                  Get.theme.primaryColor,
                  Get.theme.accentColor
                ]
              )
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.white),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/oldImages/admin.png'))),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: _height * .01),
                    child: Text(
                      //TODO: display the user name
                      "admin",
                      style:
                      TextStyle(color: Colors.white, fontSize: _height * .03),
                    ),
                  ),
                  Text(
                    //TODO: display the user email
                    "email",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                tileColor: Colors.transparent,
                title: Text(
                  'Display Category',
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
                  //   MaterialPageRoute(builder: (context) => GetBooksCategory()),
                  // );
                },
              ),
              Divider(
                height: 4,
              ),
            ],
          ),
          Column(
            children: [
              ListTile(
                tileColor: Colors.transparent,
                title: Text(
                  'Add new Book',
                  style: TextStyle(fontSize: _height * 0.023),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onTap: () {
                  // TODO: get user uid from pref
                  SharedPreferencesGetXController prefController = Get.find();
                  SharedPreferences pref =prefController.pref;
                  Get.to(()=>AddBookPage());
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => AddBook(widget.currentUserId)),
                  // );
                },
              ),
              Divider(
                height: 4,
              ),
            ],
          ),
          Column(
            children: [
              ListTile(
                  tileColor: Colors.transparent,
                  title: Text(
                    'Logout ',
                    style:
                    TextStyle(fontSize: _height * 0.023, color: Colors.red),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.red,
                  ),
                  onTap: () {
                    AuthServices.logout();
                    Get.to(()=>BooksCategoryPage());

                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => MyApp()));
                  }),
              Divider(
                height: 4,
              ),
            ],
          ),
        ],
      )
      // StreamBuilder<DocumentSnapshot>(
      //   stream: provideDocumentFieldStream(),
      //   builder:
      //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      //     if (!snapshot.hasData) {
      //       return CircularProgressIndicator();
      //     }
      //     if (snapshot.hasData) {
      //       Map<String, dynamic> documentFields = snapshot.data.data();
      //
      //       return getData(documentFields, _height);
      //     }
      //   },
      // ),
    );
  }
}
//
// class AdminHome extends StatefulWidget {
//   final String currentUserId;
//
//   AdminHome(this.currentUserId);
//
//   @override
//   _AdminHomeState createState() => _AdminHomeState();
// }
//
// class _AdminHomeState extends State<AdminHome> {
//   Stream<DocumentSnapshot> provideDocumentFieldStream() {
//     return FirebaseFirestore.instance
//         .collection('admin')
//         .doc(widget.currentUserId)
//         .snapshots();
//   }
//
//   Column getData(Map<String, dynamic> documentFields, _height) {
//     return Column(
//       children: [
//         Container(
//           height: _height * 0.33,
//           color: Colors.lightBlueAccent,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 80,
//                   width: 80,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(width: 2, color: Colors.white),
//                       image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: AssetImage('assets/admin.png'))),
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
//                 )
//               ],
//             ),
//           ),
//         ),
//         Column(
//           children: [
//             ListTile(
//               tileColor: Colors.transparent,
//               title: Text(
//                 'See All Books',
//                 style: TextStyle(fontSize: _height * 0.023),
//               ),
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 color: Colors.black,
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => GetBooksCategory()),
//                 );
//               },
//             ),
//             Divider(
//               height: 5,
//             ),
//           ],
//         ),
//         Column(
//           children: [
//             ListTile(
//               tileColor: Colors.transparent,
//               title: Text(
//                 'Add new Book',
//                 style: TextStyle(fontSize: _height * 0.023),
//               ),
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 color: Colors.black,
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => AddBook(widget.currentUserId)),
//                 );
//               },
//             ),
//             Divider(
//               height: 5,
//             ),
//           ],
//         ),
//         Column(
//           children: [
//             ListTile(
//                 tileColor: Colors.transparent,
//                 title: Text(
//                   'Logout ',
//                   style:
//                       TextStyle(fontSize: _height * 0.023, color: Colors.red),
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   color: Colors.red,
//                 ),
//                 onTap: () {
//                   AuthServices.logout();
//
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (BuildContext context) => MyApp()));
//                 }),
//             Divider(
//               height: 5,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final _height = displayHeight(context) -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text('Admin Console'),
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: Colors.lightBlueAccent,
//         ),
//         body: StreamBuilder<DocumentSnapshot>(
//             stream: provideDocumentFieldStream(),
//             builder: (BuildContext context,
//                 AsyncSnapshot<DocumentSnapshot> snapshot) {
//               if (!snapshot.hasData) {
//                 return CircularProgressIndicator();
//               }
//               if (snapshot.hasData) {
//                 Map<String, dynamic> documentFields = snapshot.data.data();
//
//                 return getData(documentFields, _height);
//               }
//             }));
//   }
// }
