import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:mh_care/Controller/BooksCategoryGetXController.dart';
import 'package:mh_care/Model/Book/Book.dart';
import 'package:mh_care/Model/Category/Category.dart';

class AddBooksGetXController extends GetxController {
  bool _isLoading = false;
  bool _isCategoryLoading = false;

  String _name;
  Category _category;
  String _selectedCategoryId;
  String _pdfUrl;
  String _coverImageUrl;
  String _coverImagePath;

  List<Category> _categories;

  bool _isNameError = false;
  bool _isPdfUrlError = false;
  bool _isCoverImagePath = false;

  AddBooksGetXController(Category category) {
    this._category = category;
    getCategories();
    if (this._category != null) this._selectedCategoryId = this._category.id;
  }

  void getCategories() async {
    isCategoryLoading = true;
    update();
    // BooksCategoryGetXController categoryController = Get.find();
    // if(categoryController.categories!=null) {
    //   print ("AddBooksGetXController:${categoryController.categories}");
    //   _categories = categoryController.categories;
    //   isCategoryLoading = false;
    // } else {
    _categories = [];
    var categoriesMap =
        await FirebaseFirestore.instance.collection("categories").get();
    // print(categoriesMap.docs[0][].toString());
    categoriesMap.docs.forEach((e) {
      var category = Category.fromJson(e.data());
      category.id = e.id;
      _categories.add(category);
    });

    print(categories);
    isCategoryLoading = false;
    update();
  }

  addBook() async {
    try {
      _isLoading = true;
      update();
      var storageRef =
          FirebaseStorage.instance.ref().child("newBooks").child(name);
      File recordFile = File(_coverImagePath);
      var recordRef =
          await storageRef.child("${name} Cover").putFile(recordFile);
      _coverImageUrl = await recordRef.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('newBooks').doc().set(Book(
            createdAt: Timestamp.now().toDate(),
            numberOfShares: 0,
            numberOfLikes: 0,
            imageUrl: _coverImageUrl,
            details: "",
            pdfUrl: _pdfUrl,
            category: _category.name,
            categoryId: _category.id,
            bookName: _name,
          ).toJson());
      _isLoading = false;
      update();
      Get.back();
      // Provider.of<UserData>(context, listen: false).uid =
      //     signedInUser.uid;

      // Navigator.pop(context);

    }
    // on FirebaseAuthException catch (e) {
    //   // throw (err);
    //   printError(info: e.message);
    //   Get.snackbar("Error", e.message);
    //   _isLoading = false;
    //   update();
    // }
    on Exception catch (e) {
      printError(info: e.toString());
      Get.snackbar("Error", "Something Went Wrong while Uploading Book");
      _isLoading = false;
      update();
    }
  }

  // bool validatePassword(){
  //   if (_password!=null &&_confirmPassword!=null)
  //   return _password.compareTo(_confirmPassword)==0;
  //   else {
  //     _isPasswordError = true;
  //     _isConfirmPasswordError = true;
  //     update();
  //     return false;
  //   }
  // }
  //return true if there are any errors in pdf url
  bool pdfUrlValidator() {
    if (_pdfUrl == null)
      return true;
    else if (!RegExp(
            r"https://www.dropbox.com/\S+?(?=pdf|PDF)(PDF|pdf)\S+?(?=dl=)dl=1")
        .hasMatch(_pdfUrl))
      return true;
    else
      return false;
  }

  //return true if there are any errors
  bool validator() {
    isNameError = _name == null;
    isPdfUrlError = pdfUrlValidator();
    isCoverImagePath = _coverImagePath == null;
    return _name == null ||
        _coverImagePath == null ||
        pdfUrlValidator() ||
        _selectedCategoryId == null;
  }

  bool get isPdfUrlError => _isPdfUrlError;

  set isPdfUrlError(bool value) {
    _isPdfUrlError = value;
    update();
  }

  bool get isNameError => _isNameError;

  set isNameError(bool value) {
    _isNameError = value;
    update();
  }

  String get imageUrl => _coverImageUrl;

  set imageUrl(String value) {
    _coverImageUrl = value;
  }

  String get pdfUrl => _pdfUrl;

  set pdfUrl(String value) {
    _pdfUrl = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  bool get isCoverImagePath => _isCoverImagePath;

  set isCoverImagePath(bool value) {
    _isCoverImagePath = value;
    update();
  }

  String get coverImageUrl => _coverImageUrl;

  set coverImageUrl(String value) {
    _coverImageUrl = value;
  }

  bool get isCategoryLoading => _isCategoryLoading;

  set isCategoryLoading(bool value) {
    _isCategoryLoading = value;
    update();
  }

  List<Category> get categories => _categories;

  set categories(List<Category> value) {
    _categories = value;
  }

  String get coverImagePath => _coverImagePath;

  set coverImagePath(String value) {
    _coverImagePath = value;
  }

  Category get category => _category;

  set category(Category value) {
    _category = value;
  }

  String get selectedCategoryId => _selectedCategoryId;

  set selectedCategoryId(String value) {
    _selectedCategoryId = value;
    update();
  }
}
