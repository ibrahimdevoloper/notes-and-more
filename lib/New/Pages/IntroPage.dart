import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:mh_care/new/Controllers/IntroGetXController.dart';
import 'package:mh_care/new/Pages/SignUpPage.dart';

import 'HomePage.dart';
import 'SignInPage.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _introController = Get.put(IntroGetXController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          GetBuilder<IntroGetXController>(
            init: _introController,
            builder: (controller) {
              return AnimatedSwitcher(
                transitionBuilder: (child, animation) {
                  var tween =
                      Tween<double>(begin: 0, end: 1).animate(animation);
                  // return SlideTransition(
                  //   position: tween,
                  //   child: child,
                  // );
                  return FadeTransition(
                    opacity: tween,
                    child: child,
                  );
                },
                duration: Duration(milliseconds: 300),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: controller.swiperIndex == 3
                    ? TextButton(
                        onPressed: () {
                          //TODO: go to home directly
                          Get.to(() => HomePage());
                        },
                        child: Text("Skip"),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent),
                      )
                    : Container(
                        width: 0,
                        height: 0,
                      ),
              );
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Center(
              child: Swiper(
                controller: _introController.swiperController,
                loop: false,
                onIndexChanged: (i) {
                  _introController.swiperIndex = i;
                },
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/intro/${index + 1}.png'),
                        Text(
                          "Lorem ipsum dolor sit amet",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididnt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 4,
                pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        color: Theme.of(context).accentColor,
                        activeColor: Theme.of(context).primaryColor,
                        activeSize: 16)),
                // control: new SwiperControl(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GetBuilder<IntroGetXController>(
              init: _introController,
              builder: (controller) {
                return AnimatedSwitcher(
                  transitionBuilder: (child, animation) {
                    var begainOffset = Offset(1.25, 0);
                    var endOffset = Offset.zero;
                    var tween =
                        Tween<Offset>(begin: begainOffset, end: endOffset)
                            .animate(animation);
                    return SlideTransition(
                      position: tween,
                      child: child,
                    );
                    // return FadeTransition(
                    //   opacity: tween,
                    //   child: child,
                    // );
                  },
                  duration: Duration(milliseconds: 600),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: controller.swiperIndex == 3
                      ? Container(
                          key: ValueKey(1),
                          width: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    //TODO: go to sign in
                                    Get.to(() => SignInPage());
                                  },
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  style: Theme.of(context)
                                      .outlinedButtonTheme
                                      .style,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    //TODO: go to sign up
                                    Get.to(() => SignUpPage());
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
                        )
                      : Container(
                          key: ValueKey(2),
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              //TODO: change the swiper index
                              controller.swiperController.next();
                            },
                            child: Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            style: Theme.of(context).textButtonTheme.style,
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
