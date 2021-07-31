import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class IntroGetXController extends GetxController{
  int _swiperIndex = 0;
  SwiperController _swiperController = SwiperController();

  get swiperIndex => _swiperIndex;

  set swiperIndex(value) {
    _swiperIndex = value;
    update();
  }

  SwiperController get swiperController => _swiperController;
}