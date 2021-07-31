import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mh_care/Controller/LoginGetXController.dart';

// import 'package:mh_care/Model/Services/auth_Services.dart';
import 'package:mh_care/Model/Services/auth_Services.dart';
import 'package:mh_care/Pages/sign_up.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:mh_care/Model/Services/globals.dart' as global;

class LoginPage extends StatelessWidget {
  static final String id = 'login_screen';

  // final _formKey = GlobalKey<FormState>();
  // String _email, _password;
  // bool _isLoading = false;
  // bool _obscureText = true;
  // void _toggle() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }

  // _showErrorDialog(String errorMessage) {
  //   showDialog(
  //       context: context,
  //       builder: (_) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text(errorMessage),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text('Ok'),
  //               onPressed: () => Navigator.pop(context),
  //             )
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginGetXController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 130),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "From Notes and More",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GetBuilder<LoginGetXController>(
                      init: controller,
                      builder: (controller) {
                        return TextFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10),
                              hintStyle: TextStyle(color: Color(0xff97AABD)),
                              hintText: "Email",
                              fillColor: Color(0XFFF5F8FA),
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              errorText: controller.isEmailError
                                  ? "Please Enter a Correct Email"
                                  : null),
                          onChanged: (value) {
                            controller.email = value;
                            controller.isEmailError =
                                !EmailValidator.validate(value);
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GetBuilder<LoginGetXController>(
                      init: controller,
                      builder: (controller) {
                        return TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10),
                            hintStyle: TextStyle(color: Color(0xff97AABD)),
                            hintText: "Password",
                            fillColor: Color(0XFFF5F8FA),
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent),
                            ),
                            border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent),
                            ),
                            errorText: controller.isPasswordError
                                ? 'Password must be at least 6 characters'
                                : null,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isObscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[400],
                              ),
                              onPressed: () => controller.isObscureText =
                                  !controller.isObscureText,
                            ),
                          ),
                          obscureText: controller.isObscureText,
                          // obscureText: true,

                          onChanged: (value) {
                            controller.password = value;
                            controller.isPasswordError = value.length < 6;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 52.0),
                    GetBuilder<LoginGetXController>(
                      builder: (controller) {
                        if (controller.isLoading)
                          return CircularProgressIndicator();
                        else
                          return Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: FlatButton(
                              onPressed: () {
                                if (controller.validator())
                                  controller.logIn();
                                else Get.snackbar("Error", "Please Enter Correct Info");
                              },
                              color: Colors.lightBlueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(7.0),
                                  side: BorderSide(color: Colors.lightBlue)),
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                      },
                    ),
                    SizedBox(height: 36.0),
                    GetBuilder<LoginGetXController>(
                      builder: (controller) {
                        if (controller.isLoading)
                          return Container(
                            height: 0,
                            width: 0,
                          );
                        else
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () => Get.to(
                                  () => SignUpPage(),
                                ),
                              ),
                            ],
                          );
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//
// }
