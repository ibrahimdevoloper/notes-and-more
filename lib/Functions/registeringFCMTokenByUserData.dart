import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mh_care/Model/UserData/UserData.dart';

Future<void> registeringFCMTokenByUserData(String userUid) async {
  //TODO: handle Errors
  var fcmToken =await  FirebaseMessaging.instance.getToken();
  FirebaseFirestore.instance
      .collection('FirebaseTokens')
      .doc(userUid)
      .update({UserData.USER_FIREBASE_TOKEN: fcmToken}).then((value) {
    print('registeringFCMTokenByUserData:Fcm token Updated.');
  });
}