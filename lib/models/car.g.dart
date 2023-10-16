// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      id: json['ID'] as int,
      postAuthor: json['post_author'] as String,
      postDate: json['post_date'] as String,
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'ID': instance.id,
      'post_author': instance.postAuthor,
      'post_date': instance.postDate,
    };
