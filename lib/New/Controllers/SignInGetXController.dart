import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class SignInGetXController extends GetxController {
  String _email;
  String _password;
  String _confirmPassword;

  bool _isEmailError = false;
  bool _isPasswordError = false;
  bool _isConfirmPasswordError = false;

  bool isPasswordMatch(){
    bool _isConfirmPasswordError = _password.compareTo(_confirmPassword)==0;
    update();
    return _password.compareTo(_confirmPassword)==0;
  }

  bool validator(){
    //TODO: validator
  }

  signUp() {
    //TODO: signUp via firebase
  }
}
