import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:mh_care/Model/Services/auth_Services.dart';
import 'package:mh_care/Model/UserData/UserData.dart';

class SignUpGetXController extends GetxController {
  // final _obj = ''.obs;
  // set obj(value) => _obj.value = value;
  // get obj => _obj.value;
  bool _isLoading = false;
  String _email;
  String _password;
  String _name;
  String _confirmPassword;
  bool _isObscureTextPassword = true;
  bool _isObscureTextConfirmPassword = true;

  var _isEmailError = false;
  var _isPasswordError = false;
  var _isConfirmPasswordError = false;

  var selected = false;

  signUpUser() async {
    try {
      var authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      User signedInUser = authResult.user;
      if (signedInUser != null) {
        String token = await FirebaseMessaging.instance.getToken();
        FirebaseFirestore.instance.collection('users').doc(signedInUser.uid).set(
            UserData(
                createdAt: Timestamp.now().toDate(),
                numberOfShares: 0,
                numberOfLikes: 0,
                numberOfFavoriteBooks: 0,
                role: UserData.USER_ROLE_CUSTOMER,
                email: _email,
                uid: signedInUser.uid,
                firebaseMessagingToken: token,
              imageUrl: "",
              details: "",
              name: _name
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
      // Provider.of<UserData>(context, listen: false).uid =
      //     signedInUser.uid;

      // Navigator.pop(context);
      Get.back();
    } on PlatformException catch (e) {
      // throw (err);
      Get.snackbar("Error", e.message);
    }
  }

  bool validatePassword(){
    return _password.compareTo(_confirmPassword)==0;
  }

  bool validator() {
    return _isEmailError || _isPasswordError || !validatePassword();
  }



  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  get isEmailError => _isEmailError;

  set isEmailError(value) {
    _isEmailError = value;
    update();
  }

  get isPasswordError => _isPasswordError;

  set isPasswordError(value) {
    _isPasswordError = value;
    update();
  }

  get isConfirmPasswordError => _isConfirmPasswordError;

  set isConfirmPasswordError(value) {
    _isConfirmPasswordError = value;
  }

  bool get isObscureTextConfirmPassword => _isObscureTextConfirmPassword;

  set isObscureTextConfirmPassword(bool value) {
    _isObscureTextConfirmPassword = value;
    update();
  }

  bool get isObscureTextPassword => _isObscureTextPassword;

  set isObscureTextPassword(bool value) {
    _isObscureTextPassword = value;
    update();
  }

  String get confirmPassword => _confirmPassword;

  set confirmPassword(String value) {
    _confirmPassword = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
