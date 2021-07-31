import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
// import 'package:mh_care/Model/Models/user_data.dart';
import 'package:mh_care/Model/Models/user_data.dart';
import 'package:mh_care/Model/Models/user_model.dart';
import 'package:mh_care/Model/UserData/UserData.dart';
import 'constant.dart';
import 'package:provider/provider.dart';
// import 'package:mh_care/Model/Models/user_model.dart';
import 'package:mh_care/Model/Services/globals.dart' as global;

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User signedInUser = authResult.user;
      if (signedInUser != null) {
        String token = await _messaging.getToken();
        _firestore.collection('users').doc(signedInUser.uid).set(
            UserData(
                createdAt: Timestamp.now().toDate(),
                numberOfShares: 0,
                numberOfLikes: 0,
                numberOfFavoriteBooks: 0,
                role: UserData.USER_ROLE_CUSTOMER,
                email: email,
                uid: signedInUser.uid,
                firebaseMessagingToken: token
            ).toJson()

        //     {
        //   'name': name,
        //   'email': email,
        //   'ImageUrl': '',
        //   'token': token,
        //   'details': '',
        //   'timeCreated': Timestamp.now(),
        // }
        );
      }
      Provider.of<UserData>(context, listen: false).uid =
          signedInUser.uid;

      Navigator.pop(context);
    } on PlatformException catch (err) {
      throw (err);
    }
  }

  static Future<void> addPatient(
      BuildContext context, String name, String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User signedInUser = authResult.user;
      if (signedInUser != null) {
        String token = await _messaging.getToken();
        _firestore.collection('/patient').doc(signedInUser.uid).set({
          'name': name,
          'email': email,
          'ImageUrl': '',
          'token': token,
          'message': '',
          'reply': '',
          'diagnosis': '',
          'details': '',
          'timeCreated': Timestamp.now(),
        });
      }
      Provider.of<UserData>(context, listen: false).uid =
          signedInUser.uid;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Patient Added"),
        ),
      );
      Navigator.pop(context);
    } on PlatformException catch (err) {
      throw (err);
    }
  }

  static Future<void> signUp(
      BuildContext context, String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User signedInUser = authResult.user;
    } on PlatformException catch (err) {
      throw (err);
    }
  }

  static Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on PlatformException catch (err) {
      throw (err);
    }
  }

  static Future<void> removeToken() async {
    final currentUser = await _auth.currentUser;
    await usersRef.doc(currentUser.uid)
        // .setData({'token': ''}, merge: true);
        .update({'token': ''});
  }

  static Future<void> updateToken() async {
    final currentUser = await _auth.currentUser;
    final token = await _messaging.getToken();
    final userDoc = await usersRef.doc(currentUser.uid).get();
    if (userDoc.exists) {
      UserSrc user = UserSrc.fromDoc(userDoc);
      if (token != user.token) {
        usersRef.doc(currentUser.uid)
            // .setData({'token': ''}, merge: true);
            .update({'token': ''});
      }
    }
  }

  static Future<void> updateTokenWithUser(UserSrc user) async {
    final token = await _messaging.getToken();
    if (token != user.token) {
      await usersRef.doc(user.id).update({'token': token});
    }
  }

  static Future<void> logout() async {
    await removeToken();
    Future.wait([
      _auth.signOut(),
    ]);
  }
}
