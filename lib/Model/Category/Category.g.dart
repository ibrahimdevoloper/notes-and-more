// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    name: json['name'] as String,
    details: json['details'] as String,
    imageUrl: json['imageUrl'] as String,
    numberOfBooks: json['numberOfBooks'] as int ?? 0,
    numberOfLikes: json['numberOfLikes'] as int ?? 0,
    numberOfShares: json['numberOfShares'] as int ?? 0,
    createdAt:
        const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'name': instance.name,
      'details': instance.details,
      'imageUrl': instance.imageUrl,
      'numberOfBooks': instance.numberOfBooks,
      'numberOfLikes': instance.numberOfLikes,
      'numberOfShares': instance.numberOfShares,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
