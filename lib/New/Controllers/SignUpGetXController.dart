import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:mh_care/new/Models/UserData/UserData.dart';

class SignUpGetXController extends GetxController {
  String _email;
  String _password;
  String _confirmPassword;

  bool _isEmailError = false;
  bool _isPasswordError = false;
  bool _isConfirmPasswordError = false;

  bool _isLoading = false;

  bool isPasswordMatch(){
    bool _isConfirmPasswordError = _password.compareTo(_confirmPassword)==0;
    update();
    return _password.compareTo(_confirmPassword)==0;
  }

  bool validator(){
    //TODO: validator
  }

  // signUp() async {
  //   //TODO: signUp via firebase
  //   try {
  //     // Codec<String, String> stringToBase64 = utf8.fuse(base64);
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: _email, password: _password);
  //     User user = FirebaseAuth.instance.currentUser;
  //     UserData userData=
  //     UserData(
  //       uid: user.uid,
  //       email: _email,
  //       role: UserData.USER_ROLE_CUSTOMER,
  //       createdAt: DateTime.now(),
  //       numberOfFavoriteBooks: 0,
  //       numberOfLikes: 0,
  //       numberOfShares: 0,
  //     );
  //     await FirebaseFirestore.instance.collection("users").doc(user.uid).set(userData.toJson());
  //     // pref.setString(UserData.ROLE, userData.role);
  //     // pref.setString(UserData.UID, userData.uid);
  //     // pref.setString(UserData.FULL_NAME, userData.fullName);
  //     emit(SignUpSignedIn());
  //   } on FirebaseAuthException catch (e) {
  //     // print(e.toString().contains("There is no user record corresponding to this identifier"));
  //     //Password should be at least 6 characters
  //     //The email address is already in use by another account.
  //     //We have blocked all requests from this device due to unusual activity. Try again later.
  //     // print(e);
  //     firebaseCrashLog(e, e.stackTrace,
  //         tag: "SignUpCubit.SignUp", message: e.toString());
  //     if (e.toString().contains(
  //         "There is no user record corresponding to this identifier")) {
  //       emit(SignUpError("Account isn't Available", "الحساب غير موجود"));
  //     } else if (e
  //         .toString()
  //         .contains("Password should be at least 6 characters")) {
  //       emit(SignUpError("Password should be at least 6 characters.",
  //           "تتكون كلمة السر من ستة أحرف على الأقل"));
  //     }else if (e
  //         .toString()
  //         .contains("The email address is already in use by another account.")) {
  //       emit(SignUpError("The email address is already EXISTS.",
  //           "هذا الإيميل مستخدم سابقاً"));
  //     }else if (e
  //         .toString()
  //         .contains("We have blocked all requests from this device due to unusual activity. Try again later.")) {
  //       emit(SignUpError("Try Again Later",
  //           "جرب التسجيل لاحقاً"));
  //     } else
  //       emit(SignUpError('error', 'خطأ'));
  //   }
  // }
}
