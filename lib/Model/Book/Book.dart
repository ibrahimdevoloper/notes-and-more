import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../TimestampConverter.dart';

part 'Book.g.dart';

@JsonSerializable()
class Book {
  Book({
    this.id,
    this.bookName,
    this.details,
    this.imageUrl,
    this.pdfUrl,
    this.bookLikesList,
    this.category,
    this.categoryId,
    this.numberOfLikes,
    this.numberOfShares,
    this.createdAt,
  });

  @JsonKey(ignore: true)
  String id; //category Id in firebase
  String bookName;
  String details;
  // @JsonKey(name: "imageurl")
  String imageUrl;
  // @JsonKey(name: "pdfurl")
  String pdfUrl;
  String categoryId;
  String category;

  // @JsonKey(defaultValue: USER_ROLE_CUSTOMER)
  // String role;
  // @JsonKey(defaultValue: 0)
  // int numberOfBooks;
  @JsonKey(defaultValue: 0)
  int numberOfLikes;
  @JsonKey(defaultValue: 0)
  int numberOfShares;

  // String firebaseMessagingToken;
  @JsonKey(defaultValue: [])
  List<String> bookLikesList;
  @TimestampConverter()
  DateTime createdAt;

  // static const USER_ROLE_CUSTOMER="customer";
  // static const USER_ROLE_ADMIN="admin";

  static const BOOK_ID = "id";
  static const BOOK_NAME = "bookName";
  static const BOOK_DETAILS = "details";
  static const BOOK_IMAGE_URL = "imageUrl";
  static const BOOK_PDF_URL = "pdfUrl";
  static const BOOK_CATEGORY_ID = "categoryId";
  static const BOOK_CATEGORY = "category";

  // static const BOOK_NUMBER_OF_BOOKS="numberOfBooks";
  static const BOOK_NUMBER_OF_LIKES = "numberOfLikes";
  static const BOOK_NUMBER_OF_SHARES = "numberOfShares";
  static const BOOK_LIKES_LIST = "numberOfShares";

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
