import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../TimestampConverter.dart';

part 'Category.g.dart';

@JsonSerializable()
class Category {
  Category({
    this.id,
    this.name,
    this.details,
    this.imageUrl,
    this.numberOfBooks,
    this.numberOfLikes,
    this.numberOfShares,
    this.createdAt,
  });

  @JsonKey(ignore: true)
  String id; //category Id in firebase
  String name;
  String details;
  String imageUrl;

  // @JsonKey(defaultValue: USER_ROLE_CUSTOMER)
  // String role;
  @JsonKey(defaultValue: 0)
  int numberOfBooks;
  @JsonKey(defaultValue: 0)
  int numberOfLikes;
  @JsonKey(defaultValue: 0)
  int numberOfShares;

  // String firebaseMessagingToken;
  @TimestampConverter()
  DateTime createdAt;

  // static const USER_ROLE_CUSTOMER="customer";
  // static const USER_ROLE_ADMIN="admin";

  static const CATEGORY_ID = "id";
  static const CATEGORY_NAME = "name";
  static const CATEGORY_DETAILS = "details";
  static const CATEGORY_IMAGE_URL = "imageUrl";
  static const CATEGORY_NUMBER_OF_BOOKS = "numberOfBooks";
  static const CATEGORY_NUMBER_OF_LIKES = "numberOfLikes";
  static const CATEGORY_NUMBER_OF_SHARES = "numberOfShares";

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
