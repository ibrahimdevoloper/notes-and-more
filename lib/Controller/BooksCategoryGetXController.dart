import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mh_care/Model/Category/Category.dart';

class BooksCategoryGetXController extends GetxController {
  List<Category> categories;
  bool _isLoading=false;

  Stream<List<Category>> getCategoryStream() {
    return FirebaseFirestore.instance
        .collection("categories")
        .snapshots()
        .map((event) {
      printInfo(info: event.toString());
      categories = [];
      event.docs.forEach((element) {
        var category = Category.fromJson(element.data());
        category.id = element.id;
        categories.add(category);
      });
      return categories;
    });
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }
}
