import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mh_care/Controller/SharedPreferencesGetXController.dart';
import 'package:mh_care/Model/Book/Book.dart';
import 'package:mh_care/Model/Category/Category.dart';
import 'package:mh_care/Pages/PDFViewer.dart';

class UserHomeGetXController extends GetxController {
  bool _isLoading=false;
  GlobalDataGetXController globalController;


  UserHomeGetXController();


  @override
  void onInit() {
    globalController = Get.find();
  }

  void redirectToBook() async{
    var pendingData = globalController.pendingDynamicLinkData;
    if (pendingData != null)
      {
        isLoading = true;
        var stringList = pendingData.link.path.split("/");
        var bookid =stringList[stringList.length-1];
        var bookMap =await FirebaseFirestore.instance.collection("newBooks").doc(bookid).get();
        var book =Book.fromJson(bookMap.data());
        book.id=bookMap.id;
        isLoading = false;
        Get.to(() => PDFViewerCachedFromUrl(
          url: book.pdfUrl,
          name:book.bookName,
        ));
        // print(stringList[stringList.length-1]);
        // print(pendingData.link.path);




      }
  }


  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }
}
