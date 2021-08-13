import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mh_care/Model/Book/Book.dart';
import 'package:mh_care/Model/Category/Category.dart';

class BooksGetXController extends GetxController {
  Category _category;
  List<Book> books;
  bool _isLoading=false;


  BooksGetXController({Category category}):this._category=category;

  Future<List<Book>> getBooks() async{
    if (_category == null) {
      var booksMap =
          await FirebaseFirestore.instance.collection("newBooks").get();
      books = [];
      booksMap.docs.forEach((element) {
        print(element..data().toString());

        var book = Book.fromJson(element.data());
        book.id = element.id;
        books.add(book);
      });
      return books;
    } else{
      var booksMap =
      await FirebaseFirestore.instance.collection("newBooks").where(Book.BOOK_CATEGORY_ID,isEqualTo: _category.id).get();
      books = [];
      booksMap.docs.forEach((element) {
        print(element..data().toString());

        var book = Book.fromJson(element.data());
        book.id = element.id;
        books.add(book);
      });
      return books;
    }
      // return FirebaseFirestore.instance
      //     .collection("newBooks")
      // .where(Book.BOOK_CATEGORY_ID,isEqualTo: _category.id)
      //     .snapshots()
      //     .map((event) {
      //   books = [];
      //   event.docs.forEach((element) {
      //     print(element..data().toString());
      //
      //     var book = Book.fromJson(element.data());
      //     book.id = element.id;
      //     books.add(book);
      //   });
      //   return books;
      // });

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

  //like the book
  Future<bool> like(Book book) async {
    book.bookLikesList.add(FirebaseAuth.instance.currentUser.uid);
    await FirebaseFirestore.instance.collection("newBooks").doc(book.id).update({
      Book.BOOK_NUMBER_OF_LIKES:book.bookLikesList.length,
      Book.BOOK_LIKES_LIST:book.bookLikesList
    });
    return true;
  }


  //unlike the book
  Future<bool> dislike(Book book)async{
    book.bookLikesList.remove(FirebaseAuth.instance.currentUser.uid);
    await FirebaseFirestore.instance.collection("newBooks").doc(book.id).update({
      Book.BOOK_NUMBER_OF_LIKES:book.bookLikesList.length,
      Book.BOOK_LIKES_LIST:book.bookLikesList
    });
    return false;
  }
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }
}
