import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:mh_care/Model/Services/auth_Services.dart';

class LoginGetXController extends GetxController {
  // final _obj = ''.obs;
  // set obj(value) => _obj.value = value;
  // get obj => _obj.value;
  bool _isLoading = false;
  String _email;
  String _password;
  bool _isObscureText = true;
  var _isEmailError = false;
  var _isPasswordError = false;

  logIn() async {
    // FocusScope.of(context).unfocus();

    // if (_formKey.currentState.validate()) {

    _isLoading = true;
    // _formKey.currentState.save();
    //Logging the user
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      //TODO: save user data in the device like shared pref
      _isLoading = false;
    } on PlatformException catch (e) {
      Get.snackbar("Error Logging in", e.message);
      // setState(() {
      _isLoading = false;
      // });
      throw (e);
    }
    // }
  }

  bool validator() {
    return _isEmailError || _isPasswordError;
  }

  bool get isObscureText => _isObscureText;

  set isObscureText(bool value) {
    _isObscureText = value;
    update();
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
}
