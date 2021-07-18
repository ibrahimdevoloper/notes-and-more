import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:mh_care/Model/Services/auth_Services.dart';
import 'package:mh_care/Old/Model/Services/auth_Services.dart';
import 'package:mh_care/View/Initial_Screens/sign_up.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:mh_care/Old/Model/Services/globals.dart' as global;

class Login extends StatefulWidget {
  static final String id = 'login_screen';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isLoading = false;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  _submit() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      //Logging the user
      try {
        await AuthServices.loginUser(_email.trim(), _password.trim());
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 130),
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
                    height: 100,
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
                            hintText: "Email",
                            fillColor: Color(0XFFF5F8FA),
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
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
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[400],
                              ),
                              onPressed: _toggle,
                            ),
                          ),
                          obscureText: _obscureText,
                          // obscureText: true,
                          validator: (input) => input.length < 6
                              ? 'Password must be at least 6 characters'
                              : null,
                          onSaved: (input) => _password = input,
                        ),
                        SizedBox(height: 50.0),
                        if (_isLoading) CircularProgressIndicator(),
                        if (!_isLoading)
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: FlatButton(
                              onPressed: _submit,
                              color: Colors.lightBlueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(7.0),
                                  side: BorderSide(color: Colors.lightBlue)),
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        SizedBox(height: 30.0),
                        if (!_isLoading)
                          Row(
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
                                    fontSize: 17,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
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
    );
  }
}
