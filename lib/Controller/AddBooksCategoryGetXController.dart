import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:mh_care/Controller/SharedPreferencesGetXController.dart';
import 'package:mh_care/Model/Category/Category.dart';
import 'package:mh_care/Model/Services/auth_Services.dart';
import 'package:mh_care/Model/UserData/UserData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBooksCategoryGetXController extends GetxController {
  bool _isLoading = false;
  String _details;
  String _name;

  bool _isDetailsError=false;
  bool _isNameError=false;

  addCategory() async {
    try {
      _isLoading = true;
      update();
      await FirebaseFirestore.instance.collection('categories').doc().set(
          Category(
                  createdAt: Timestamp.now().toDate(),
                  numberOfShares: 0,
                  numberOfLikes: 0,
                  imageUrl: "",
                  details: _details,
                  name: _name)
              .toJson());
      _isLoading = false;
      update();
      Get.back();
      // Provider.of<UserData>(context, listen: false).uid =
      //     signedInUser.uid;

      // Navigator.pop(context);

    }
    // on FirebaseAuthException catch (e) {
    //   // throw (err);
    //   printError(info: e.message);
    //   Get.snackbar("Error", e.message);
    //   _isLoading = false;
    //   update();
    // }
    on Exception catch (e) {
      printError(info: e.toString());
      Get.snackbar("Error", "Something Went Wrong while Uploading Category");
      _isLoading = false;
      update();
    }
  }

   // bool validatePassword(){
  //   if (_password!=null &&_confirmPassword!=null)
  //   return _password.compareTo(_confirmPassword)==0;
  //   else {
  //     _isPasswordError = true;
  //     _isConfirmPasswordError = true;
  //     update();
  //     return false;
  //   }
  // }

  //return true if there are any errors
  bool validator() {
    isNameError = _name == null;
    isDetailsError = _details == null;
    return _name == null || _details == null;
  }

  bool get isNameError => _isNameError;

  set isNameError(bool value) {
    _isNameError = value;
    update();
  }
  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get details => _details;

  set details(String value) {
    _details = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }


  bool get isDetailsError => _isDetailsError;

  set isDetailsError(bool value) {
    _isDetailsError = value;
    update();
  }
}
