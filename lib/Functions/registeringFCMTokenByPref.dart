import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mh_care/Model/UserData/UserData.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future registeringFCMTokenByPref(SharedPreferences pref) async {
  //TODO: handle Errors
  var fcmToken = await FirebaseMessaging.instance.getToken();
  FirebaseFirestore.instance
      .collection('users')
      .doc(pref.getString(UserData.USER_UID))
      .update({UserData.USER_FIREBASE_TOKEN: fcmToken}).then((value) {
    print('registeringFCMTokenByPref:Fcm token Updated.');
  });
}