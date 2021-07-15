import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mh_care/View/Roles/Admin_Screens/Admin_Home.dart';
import 'package:mh_care/View/Roles/User_Screens/User_Home.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';
  final String currentUserId;
  HomeScreen({this.currentUserId});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userRole = '';

  checkUserRole() async {
    final snapShot = await Firestore.instance
        .collection('admin')
        .document(widget.currentUserId)
        .get();

    if (snapShot.exists) {
      setState(() {
        userRole = 'admin';
      });
    }

    final psnapShot = await Firestore.instance
        .collection('user')
        .document(widget.currentUserId)
        .get();
    if (psnapShot.exists) {
      setState(() {
        userRole = 'user';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userRole == 'admin'
          ? AdminHome(widget.currentUserId)
          : userRole == 'user'
              ? UserHome(widget.currentUserId)
              : Center(child: CircularProgressIndicator()),
    );
  }
}
