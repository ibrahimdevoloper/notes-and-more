import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mh_care/new/Controllers/SignUpGetXController.dart';
import 'package:mh_care/new/CustomWidgets/MyInputText.dart';

class SignUpPage extends StatelessWidget {
  var _emailTextController= TextEditingController();
  var _passwordTextController= TextEditingController();
  var _confirmPasswordTextController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _controller = Get.put(SignUpGetXController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Sign Up"),
        backgroundColor: Colors.transparent,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Theme.of(context).primaryColor),
        iconTheme: Theme.of(context)
            .iconTheme
            .copyWith(color: Theme.of(context).primaryColor),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:32),
                    child: Wrap(alignment: WrapAlignment.center, children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          color: Colors.white,
                          elevation: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).accentColor,
                                    ])),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                    color: Colors.white,
                                  ),
                                  child: Image.asset('assets/images/appIcon.png')),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,48, 16, 8),
                    child: Text("Email",style: Theme.of(context).textTheme.headline6,),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: MyInputText(
                      controller: _emailTextController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,8, 16, 8),
                    child: Text("Password",style: Theme.of(context).textTheme.headline6,),
                  ),Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: MyInputText(
                      controller: _passwordTextController,
                    ),
                  ), Padding(
                    padding: const EdgeInsets.fromLTRB(16,8, 16, 8),
                    child: Text("Confirm Password",style: Theme.of(context).textTheme.headline6,),
                  ),Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: MyInputText(
                      controller: _confirmPasswordTextController,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: TextButton(
                onPressed: () {
                  //TODO: SignUp
                },
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                style:
                Theme.of(context).textButtonTheme.style,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
