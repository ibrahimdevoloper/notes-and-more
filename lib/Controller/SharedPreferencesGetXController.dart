import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalDataGetXController extends GetxController{
  SharedPreferences pref;
  PendingDynamicLinkData pendingDynamicLinkData;

  GlobalDataGetXController(this.pref,this.pendingDynamicLinkData);
}