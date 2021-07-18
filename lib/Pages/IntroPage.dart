import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          new Swiper(
            itemBuilder: (BuildContext context,int index){
              return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
            },
            itemCount: 3,
            pagination: new SwiperPagination(),
            control: new SwiperControl(),
          ),
          TextButton(onPressed: (){}, child: Text("hello world"),),
        ],
      ),
    );
}}
