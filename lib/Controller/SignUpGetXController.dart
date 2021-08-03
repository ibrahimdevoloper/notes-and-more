import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:mh_care/Controller/SharedPreferencesGetXController.dart';
import 'package:mh_care/Model/Services/auth_Services.dart';
import 'package:mh_care/Model/UserData/UserData.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      _isLoading = true;
      update();
      var authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      User signedInUser = authResult.user;
      if (signedInUser != null) {
        String token = await FirebaseMessaging.instance.getToken();
        await FirebaseFirestore.instance.collection('users').doc(signedInUser.uid).set(
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
        SharedPreferencesGetXController prefController = Get.find();
        SharedPreferences pref =prefController.pref;
        // UserData userData = UserData.fromJson(userDataMap.data());
        pref.setString(UserData.USER_ROLE, UserData.USER_ROLE_CUSTOMER);
        pref.setString(UserData.USER_DETAILS, "");
        pref.setString(UserData.USER_EMAIL, _email);
        pref.setString(UserData.USER_IMAGE_URL, "");
        pref.setString(UserData.USER_NAME, _name);
        pref.setInt(UserData.USER_NUMBER_OF_FAVORITE_BOOKS,0);
        pref.setInt(UserData.USER_NUMBER_OF_LIKES, 0);
        pref.setInt(UserData.USER_NUMBER_OF_SHARES, 0);
        pref.setString(UserData.USER_UID, signedInUser.uid);
        _isLoading = false;
        update();
        Get.back();
      }
      // Provider.of<UserData>(context, listen: false).uid =
      //     signedInUser.uid;

      // Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      // throw (err);
      printError(info:e.message);
      Get.snackbar("Error", e.message);
      _isLoading = false;
      update();
    }on Exception catch (e){
      printError(info:e.toString());
      Get.snackbar("Error", "Something Went Wrong while Signing up");
      _isLoading = false;
      update();
    }
  }

  bool validatePassword(){
    if (_password!=null &&_confirmPassword!=null)
    return _password.compareTo(_confirmPassword)==0;
    else {
      _isPasswordError = true;
      _isConfirmPasswordError = true;
      update();
      return false;
    }
  }

  //return error if there are any errors
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
    update();
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
