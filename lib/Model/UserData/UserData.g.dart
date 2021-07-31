// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return UserData(
    uid: json['uid'] as String,
    email: json['email'] as String,
    role: json['role'] as String ?? 'customer',
    numberOfFavoriteBooks: json['numberOfFavoriteBooks'] as int ?? 0,
    numberOfLikes: json['numberOfLikes'] as int ?? 0,
    numberOfShares: json['numberOfShares'] as int ?? 0,
    createdAt:
        const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    firebaseMessagingToken: json['firebaseMessagingToken'] as String,
    name: json['name'] as String,
    details: json['details'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'details': instance.details,
      'imageUrl': instance.imageUrl,
      'role': instance.role,
      'numberOfFavoriteBooks': instance.numberOfFavoriteBooks,
      'numberOfLikes': instance.numberOfLikes,
      'numberOfShares': instance.numberOfShares,
      'firebaseMessagingToken': instance.firebaseMessagingToken,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
