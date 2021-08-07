import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mh_care/Model/Book/Book.dart';
import 'package:mh_care/Model/Category/Category.dart';

class BooksGetXController extends GetxController {
  String _categoryId="";
  List<Book> books;


  BooksGetXController({String categoryId}):this._categoryId=categoryId;

  Stream<List<Book>> getBookStream() {
    return FirebaseFirestore.instance
        .collection("newBooks")
        .snapshots()
        .map((event) {
      books = [];
      event.docs.forEach((element) {
        print(element..data().toString());

        var book = Book.fromJson(element.data());
        book.id = element.id;
        books.add(book);
      });
      return books;
    });

    //TODO: uncomment after adding category
    // if (_categoryId.isEmpty) {
    //   return FirebaseFirestore.instance
    //       .collection("books")
    //       .snapshots()
    //       .map((event) {
    //     printInfo(info: event.toString());
    //     books = [];
    //     event.docs.forEach((element) {
    //       var book = Book.fromJson(element.data());
    //       book.id = element.id;
    //       books.add(book);
    //     });
    //     return books;
    //   });
    // }else {
    //   return FirebaseFirestore.instance
    //       .collection("books")
    //   .where(Book.)
    //       .snapshots()
    //       .map((event) {
    //     printInfo(info: event.toString());
    //     books = [];
    //     event.docs.forEach((element) {
    //       var book = Book.fromJson(element.data());
    //       book.id = element.id;
    //       books.add(book);
    //     });
    //     return books;
    //   });
    // }
  }
}
