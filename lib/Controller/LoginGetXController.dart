import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mh_care/Controller/SharedPreferencesGetXController.dart';
import 'package:mh_care/Model/UserData/UserData.dart';
import 'package:mh_care/Pages/Admin_Home.dart';
import 'package:mh_care/Pages/UserHomePage.dart';
import 'package:mh_care/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    update();
    // _formKey.currentState.save();
    //Logging the user
    try {
      var userInfo = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      //save user data in the device like shared pref
      SharedPreferencesGetXController prefController = Get.find();
      SharedPreferences pref = prefController.pref;
      var userDataMap = await FirebaseFirestore.instance
          .collection("users")
          .doc(userInfo.user.uid)
          .get();
      UserData userData = UserData.fromJson(userDataMap.data());
      pref.setString(UserData.USER_ROLE, userData.role);
      pref.setString(UserData.USER_DETAILS, userData.details);
      pref.setString(UserData.USER_EMAIL, userData.email);
      pref.setString(UserData.USER_IMAGE_URL, userData.imageUrl);
      pref.setString(UserData.USER_NAME, userData.name);
      pref.setInt(UserData.USER_NUMBER_OF_FAVORITE_BOOKS,
          userData.numberOfFavoriteBooks);
      pref.setInt(UserData.USER_NUMBER_OF_LIKES, userData.numberOfLikes);
      pref.setInt(UserData.USER_NUMBER_OF_SHARES, userData.numberOfShares);
      pref.setString(UserData.USER_UID, userInfo.user.uid);
      _isLoading = false;
      update();
      if (userData.role.compareTo(UserData.USER_ROLE_ADMIN)==0)
        Get.off(()=>AdminHome());
      else Get.off(()=>UserHomePage());
      // Get.off(()=>MyApp());
    } on FirebaseAuthException catch (e) {
      // throw (err);
      printError(info: e.message);
      if (e.message.contains("403")) {
        Get.snackbar("Error", "Check Your Connection");
      } else {
        Get.snackbar("Error", e.message);
      }
      _isLoading = false;
      update();
    } on Exception catch (e) {
      printError(info: e.toString());
      Get.snackbar("Error", "Something Went Wrong while Logging in");
      _isLoading = false;
      update();
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
