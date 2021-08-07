import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mh_care/Model/Book/Book.dart';

class AddBooksGetXController extends GetxController {
  bool _isLoading = false;

  String _name;
  String _category;
  String _categoryId;
  String _pdfUrl;
  String _imageUrl;

  bool _isNameError = false;
  bool _isPdfUrlError = false;

  addBook() async {
    try {
      _isLoading = true;
      update();
      await FirebaseFirestore.instance.collection('books').doc().set(Book(
            createdAt: Timestamp.now().toDate(),
            numberOfShares: 0,
            numberOfLikes: 0,
            imageUrl: _imageUrl,
            details: "",
            pdfUrl: _pdfUrl,
            category: _category,
            categoryId: _categoryId,
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

  //return true if there are any errors
  bool validator() {
    isNameError = _name == null;
    isPdfUrlError = _pdfUrl == null;
    return _name == null || _pdfUrl == null;
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

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  String get pdfUrl => _pdfUrl;

  set pdfUrl(String value) {
    _pdfUrl = value;
  }

  String get categoryId => _categoryId;

  set categoryId(String value) {
    _categoryId = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
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
}
