import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                'Contact Us',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: height * 0.07),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                'Developed By: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'SeaSolSolution',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: height * 0.03, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                'Email: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 4),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width / 2,
               // color: Colors.green,
                child: Center(
                  child: Text(
                    'Manage By: \nbilalferoze99@gmail.com'
                    '\n\nDeveloped By: \nsmamahsn@gmail.com'
                    '\n\nDesigned By: \nusamahasan@gmail.com',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.2,
              ),
              Image.asset(
                'assets/bookmark.png',
                height: height * 0.1,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text('Public EBook Library, Islamabad',
                  style: TextStyle(
                      fontSize: height * 0.02, fontWeight: FontWeight.bold)),
              Text('@Copyrights All Rights Reserved, 2021',
                  style: TextStyle(fontSize: height * 0.02)),
            ],
          ),
        ),
      ),
    );
  }
}
