import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mh_care/Model/Models/user_data.dart';
import 'constant.dart';
import 'package:provider/provider.dart';
import 'package:mh_care/Model/Models/user_model.dart';
import 'package:mh_care/Model/Services/globals.dart' as global;

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _firestore = Firestore.instance;
  static final FirebaseMessaging _messaging = FirebaseMessaging();

  static Future<void> signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser signedInUser = authResult.user;
      if (signedInUser != null) {
        String token = await _messaging.getToken();
        _firestore
            .collection('/${global.sRole}')
            .document(signedInUser.uid)
            .setData({
          'name': name,
          'email': email,
          'ImageUrl': '',
          'token': token,
          'details': '',
          'timeCreated': Timestamp.now(),
        });
      }
      Provider.of<GetUserData>(context, listen: false).currentUserId =
          signedInUser.uid;

      Navigator.pop(context);
    } on PlatformException catch (err) {
      throw (err);
    }
  }

  static Future<void> addPatient(
      BuildContext context, String name, String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser signedInUser = authResult.user;
      if (signedInUser != null) {
        String token = await _messaging.getToken();
        _firestore.collection('/patient').document(signedInUser.uid).setData({
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
      Provider.of<GetUserData>(context, listen: false).currentUserId =
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
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser signedInUser = authResult.user;
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
    final currentUser = await _auth.currentUser();
    await usersRef
        .document(currentUser.uid)
        .setData({'token': ''}, merge: true);
  }

  static Future<void> updateToken() async {
    final currentUser = await _auth.currentUser();
    final token = await _messaging.getToken();
    final userDoc = await usersRef.document(currentUser.uid).get();
    if (userDoc.exists) {
      UserSrc user = UserSrc.fromDoc(userDoc);
      if (token != user.token) {
        usersRef
            .document(currentUser.uid)
            .setData({'token': token}, merge: true);
      }
    }
  }

  static Future<void> updateTokenWithUser(UserSrc user) async {
    final token = await _messaging.getToken();
    if (token != user.token) {
      await usersRef.document(user.id).updateData({'token': token});
    }
  }

  static Future<void> logout() async {
    await removeToken();
    Future.wait([
      _auth.signOut(),
    ]);
  }
}
