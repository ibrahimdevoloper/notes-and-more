import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mh_care/Model/Services/auth_Services.dart';
import 'package:mh_care/Model/Services/globals.dart' as global;
import 'package:toggle_switch/toggle_switch.dart';

class Signup extends StatefulWidget {
  static final String id = 'signup_screen';

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _name, _confirmPass;
  bool _isLoading = false;
  var selected = false;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  _submit() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      //Signup user with Firebase
      try {
        await AuthServices.signUpUser(
            context, _name.trim(), _email.trim(), _password.trim());
      } on PlatformException catch (err) {
        _showErrorDialog(err.message);
        setState(() {
          _isLoading = false;
        });
        throw (err);
      }
    }
  }

  _showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      child: Container(
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Hey User !',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Register your self and enjoy",
                      style: TextStyle(color: Color(0XFF666666)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
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
                            ),
                            validator: (input) => input.trim().isEmpty
                                ? 'Please enter a valid name'
                                : null,
                            onSaved: (input) => _name = input,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
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
                            ),
                            validator: (input) => !input.contains('@')
                                ? 'Please enter a valid email'
                                : null,
                            onSaved: (input) => _email = input,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText1
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey[400],
                                ),
                                onPressed: _toggle1,
                              ),
                            ),
                            obscureText: _obscureText1,
                            validator: (input) {
                              setState(() {
                                _confirmPass = input;
                              });

                              input.length < 6
                                  ? 'Password must be at least 6 characters'
                                  : null;
                            },
                            onSaved: (input) => _password = input,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10),
                              hintStyle: TextStyle(color: Color(0xff97AABD)),
                              hintText: "Confirm Password",
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText2
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey[400],
                                ),
                                onPressed: _toggle2,
                              ),
                            ),
                            obscureText: _obscureText2,
                            validator: (input) => input.length < 6
                                ? 'Password must be at least 6 characters'
                                : input != _confirmPass
                                    ? 'Password Not Matched'
                                    : null,
                            onSaved: (input) => _password = input,
                          ),
                          SizedBox(height: 15.0),
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
                          if (_isLoading) CircularProgressIndicator(),
                          if (!_isLoading)
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: FlatButton(
                                onPressed: _submit,
                                color: Colors.lightBlueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(7.0),
                                    side: BorderSide(color: Colors.lightBlue)),
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Signup',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
