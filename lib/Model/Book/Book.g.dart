// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
    bookName: json['bookName'] as String,
    details: json['details'] as String,
    imageUrl: json['imageUrl'] as String,
    numberOfLikes: json['numberOfLikes'] as int ?? 0,
    numberOfShares: json['numberOfShares'] as int ?? 0,
    bookLikesList:
        (json['bookLikesList'] as List)?.map((e) => e as String)?.toList() ??
            [],
    createdAt:
        const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
  )
    ..pdfUrl = json['pdfUrl'] as String
    ..categoryId = json['categoryId'] as String
    ..category = json['category'] as String;
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'bookName': instance.bookName,
      'details': instance.details,
      'imageUrl': instance.imageUrl,
      'pdfUrl': instance.pdfUrl,
      'categoryId': instance.categoryId,
      'category': instance.category,
      'numberOfLikes': instance.numberOfLikes,
      'numberOfShares': instance.numberOfShares,
      'bookLikesList': instance.bookLikesList,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
