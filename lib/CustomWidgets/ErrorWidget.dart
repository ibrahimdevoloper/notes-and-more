import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    Key key,
    @required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/error.png"),
          SizedBox(
            height: 16,
          ),
          Text(
            errorMessage,
            style: Get.textTheme.headline5,
          ),
        ],
      ),
    );
  }
}