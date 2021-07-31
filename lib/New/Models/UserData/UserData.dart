import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../TimestampConverter.dart';
part 'UserData.g.dart';

@JsonSerializable()
class UserData {
  UserData({this.uid,this.email,this.role,this.numberOfFavoriteBooks,this.numberOfLikes,this.numberOfShares,
    this.createdAt
  });

  String uid;//user Id in firebase
  String email;
  @JsonKey(defaultValue: USER_ROLE_CUSTOMER)
  String role;
  @JsonKey(defaultValue: 0)
  int numberOfFavoriteBooks;
  @JsonKey(defaultValue: 0)
  int numberOfLikes;
  @JsonKey(defaultValue: 0)
  int numberOfShares;
  @TimestampConverter()
  DateTime  createdAt;

  static const USER_ROLE_CUSTOMER="customer";
  static const USER_ROLE_ADMIN="admin";

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}