import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mh_care/Controller/AddBooksCategoryGetXController.dart';
import 'package:mh_care/Controller/SignUpGetXController.dart';
import 'package:mh_care/Model/Services/auth_Services.dart';
import 'package:mh_care/Model/Services/globals.dart' as global;
import 'package:toggle_switch/toggle_switch.dart';

class AddBooksCategoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AddBooksCategoryGetXController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Get.theme.primaryColor,
        title: Text('Add Books Categories'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              // fit: BoxFit.cover,
                repeat: ImageRepeat.repeatY,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstIn),
                alignment: Alignment.bottomCenter,
                image: AssetImage(
                  'assets/oldImages/books.png',
                ))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GetBuilder<AddBooksCategoryGetXController>(
                  init: controller,
                  builder: (controller) {
                    return TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10),
                        hintStyle: TextStyle(color: Color(0xff97AABD)),
                        hintText: "Name",
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
                        errorText: controller.isNameError
                            ? 'Please Enter Name'
                            : null,
                      ),
                      // validator: (input) => input.trim().isEmpty
                      //     ? 'Please enter a valid name'
                      //     : null,
                      // onSaved: (input) => _name = input,
                      onChanged: (value) {
                        controller.name = value;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                GetBuilder<AddBooksCategoryGetXController>(
                  init: controller,
                  builder: (controller) {
                    return TextFormField(
                      minLines: 1,
                      maxLines: 7,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10),
                        hintStyle: TextStyle(color: Color(0xff97AABD)),
                        hintText: "Details",

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
                        errorText: controller.isDetailsError
                            ? 'Please enter Details'
                            : null,
                      ),
                      // validator: (input) => !input.contains('@')
                      //     ? 'Please enter a valid email'
                      //     : null,
                      // onSaved: (input) => _email = input,
                      onChanged: (value) {
                        controller.details = value;

                      },
                    );
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                // GetBuilder<SignUpGetXController>(
                //   init: controller,
                //   builder: (controller) {
                //     return TextFormField(
                //       decoration: InputDecoration(
                //         contentPadding: EdgeInsets.symmetric(
                //             vertical: 15.0, horizontal: 10),
                //         hintStyle: TextStyle(color: Color(0xff97AABD)),
                //         hintText: "Password",
                //         fillColor: Color(0XFFF5F8FA),
                //         filled: true,
                //         enabledBorder: UnderlineInputBorder(
                //           borderSide:
                //           BorderSide(color: Colors.transparent),
                //         ),
                //         focusedBorder: UnderlineInputBorder(
                //           borderSide:
                //           BorderSide(color: Colors.transparent),
                //         ),
                //         border: UnderlineInputBorder(
                //           borderSide:
                //           BorderSide(color: Colors.transparent),
                //         ),
                //         suffixIcon: IconButton(
                //           icon: Icon(
                //             controller.isObscureTextPassword
                //                 ? Icons.visibility_off
                //                 : Icons.visibility,
                //             color: Colors.grey[400],
                //           ),
                //           onPressed: () {
                //             controller.isObscureTextPassword =
                //             !controller.isObscureTextPassword;
                //           },
                //         ),
                //         errorText: controller.isPasswordError
                //             ? 'Password must be at least 6 characters'
                //             : null,
                //       ),
                //       obscureText: controller.isObscureTextPassword,
                //       // validator: (input) {
                //       //   // setState(() {
                //       //   //   _confirmPass = input;
                //       //   // });
                //       //
                //       //
                //       //
                //       //   input.length < 6
                //       //       ?
                //       //       : null;
                //       // },
                //       // onSaved: (input) => _password = input,
                //       onChanged: (value) {
                //         controller.password = value;
                //         controller.isPasswordError = value.length < 6;
                //       },
                //     );
                //   },
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // GetBuilder<SignUpGetXController>(
                //   init: controller,
                //   builder: (controller) {
                //     return TextFormField(
                //       decoration: InputDecoration(
                //         contentPadding: EdgeInsets.symmetric(
                //             vertical: 15.0, horizontal: 10),
                //         hintStyle: TextStyle(color: Color(0xff97AABD)),
                //         hintText: "Confirm Password",
                //         fillColor: Color(0XFFF5F8FA),
                //         filled: true,
                //         enabledBorder: UnderlineInputBorder(
                //           borderSide:
                //           BorderSide(color: Colors.transparent),
                //         ),
                //         focusedBorder: UnderlineInputBorder(
                //           borderSide:
                //           BorderSide(color: Colors.transparent),
                //         ),
                //         border: UnderlineInputBorder(
                //           borderSide:
                //           BorderSide(color: Colors.transparent),
                //         ),
                //         errorText: controller.isConfirmPasswordError
                //             ? 'Password Not Matched'
                //             : null,
                //         suffixIcon: IconButton(
                //           icon: Icon(
                //             controller.isObscureTextPassword
                //                 ? Icons.visibility_off
                //                 : Icons.visibility,
                //             color: Colors.grey[400],
                //           ),
                //           onPressed: () {
                //             controller.isObscureTextConfirmPassword =
                //             !controller
                //                 .isObscureTextConfirmPassword;
                //           },
                //         ),
                //       ),
                //       obscureText:
                //       controller.isObscureTextConfirmPassword,
                //       // validator: (input) => input.length < 6
                //       //     ? 'Password must be at least 6 characters'
                //       //     : input != _confirmPass
                //       //         ? 'Password Not Matched'
                //       //         : null,
                //       // onSaved: (input) => _password = input,
                //       onChanged: (value) {
                //         controller.confirmPassword = value;
                //         controller.isConfirmPasswordError =
                //         !controller.validatePassword();
                //       },
                //     );
                //   },
                // ),
                // SizedBox(height: 15.0),
                //For Choose Your Role (Admin and user Can be signup)
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     "Define Your Role ",
                //     style: TextStyle(color: Color(0XFF666666)),
                //   ),
                // ),
                // SizedBox(height: 5.0),
                // Center(
                //   child: ToggleSwitch(
                //     minWidth:
                //         MediaQuery.of(context).size.width * 0.29,
                //     minHeight: 45,
                //     inactiveBgColor: Colors.grey[50],
                //     activeBgColor: Colors.blue,
                //     initialLabelIndex: global.role,
                //     labels: ['User', 'Admin'],
                //     onToggle: (index) {
                //       print('switched to: $index');
                //       setState(() {
                //         global.role = index;
                //         global.sRole =
                //             global.role == 0 ? 'user' : 'admin';
                //       });
                //     },
                //   ),
                // ),
                SizedBox(
                  height: 50,
                ),
                GetBuilder<AddBooksCategoryGetXController>(
                  init: controller,
                  builder: (controller) {
                    if (controller.isLoading)
                      return CircularProgressIndicator();
                    else
                      return Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: FlatButton(
                          onPressed: () {
                            if (!controller.validator()) {
                              controller.addCategory();
                            } else {

                              Get.snackbar(
                                  "Form Error", "Please Check Your Fields");
                            }
                          },
                          color: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(7.0),
                              side:
                              BorderSide(color: Colors.lightBlue)),
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Add Category',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                  },
                ),
                // if (_isLoading) CircularProgressIndicator(),
                // if (!_isLoading)
                //   Container(
                //     height: 50,
                //     width: MediaQuery.of(context).size.width * 0.80,
                //     child: FlatButton(
                //       onPressed: _submit,
                //       color: Colors.lightBlueAccent,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: new BorderRadius.circular(7.0),
                //           side: BorderSide(color: Colors.lightBlue)),
                //       padding: const EdgeInsets.all(10.0),
                //       child: Text(
                //         'Signup',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   ),
                // SizedBox(height: 20.0),
                // GetBuilder<SignUpGetXController>(
                //   init: controller,
                //   builder: (controller) {
                //     if (controller.isLoading)
                //       return Container(
                //         height: 0,
                //         width: 0,
                //       );
                //     else
                //       return Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             "Already have an account",
                //             style: TextStyle(
                //                 color: Colors.black, fontSize: 16),
                //           ),
                //           SizedBox(
                //             width: 5,
                //           ),
                //           InkWell(
                //             child: Text(
                //               "Login",
                //               style: TextStyle(
                //                   color: Colors.lightBlue,
                //                   fontSize: 16,
                //                   decoration: TextDecoration.underline,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //             onTap: () => Get.back(),
                //           ),
                //         ],
                //       );
                //   },
                // ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}

//
// class Signup extends StatefulWidget {
//
//   @override
//   _SignupState createState() => _SignupState();
// }
//
// class _SignupState extends State<Signup> {
//   // final _formKey = GlobalKey<FormState>();
//   // String _email, _password, _name, _confirmPass;
//   // bool _isLoading = false;
//   // var selected = false;
//   // bool _obscureText1 = true;
//   // bool _obscureText2 = true;
//   // void _toggle1() {
//   //   setState(() {
//   //     _obscureText1 = !_obscureText1;
//   //   });
//   // }
//   //
//   // void _toggle2() {
//   //   setState(() {
//   //     _obscureText2 = !_obscureText2;
//   //   });
//   // }
//   //
//   // _submit() async {
//   //   FocusScope.of(context).unfocus();
//   //
//   //   if (_formKey.currentState.validate()) {
//   //     setState(() {
//   //       _isLoading = true;
//   //     });
//   //     _formKey.currentState.save();
//   //     //Signup user with Firebase
//   //     try {
//   //       await AuthServices.signUpUser(
//   //           context, _name.trim(), _email.trim(), _password.trim());
//   //     } on PlatformException catch (err) {
//   //       _showErrorDialog(err.message);
//   //       setState(() {
//   //         _isLoading = false;
//   //       });
//   //       throw (err);
//   //     }
//   //   }
//   // }
//   //
//   // _showErrorDialog(String errorMessage) {
//   //   showDialog(
//   //       context: context,
//   //       builder: (_) {
//   //         return AlertDialog(
//   //           title: Text('Error'),
//   //           content: Text(errorMessage),
//   //           actions: <Widget>[
//   //             FlatButton(
//   //               child: Text('Ok'),
//   //               onPressed: () => Get.back(),
//   //             )
//   //           ],
//   //         );
//   //       });
//   // }
//
//
// }
