// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vimoe_download.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VimoeVideo _$VimoeVideoFromJson(Map<String, dynamic> json) => VimoeVideo(
      json['link'] as String,
      json['uri'] as String,
      (json['files'] as List<dynamic>)
          .map((e) => VimoeFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VimoeVideoToJson(VimoeVideo instance) =>
    <String, dynamic>{
      'link': instance.link,
      'uri': instance.uri,
      'files': instance.files,
    };

VimoeFile _$VimoeFileFromJson(Map<String, dynamic> json) => VimoeFile(
      json['quality'] as String?,
      json['rendition'] as String?,
      json['type'] as String?,
      json['width'] as int?,
      json['height'] as int?,
      json['link'] as String?,
      json['created_time'] as String?,
      json['fps'] as int?,
      json['size'] as int?,
      json['md5'] as String?,
      json['public_name'] as String?,
      json['size_short'] as String?,
    );

Map<String, dynamic> _$VimoeFileToJson(VimoeFile instance) => <String, dynamic>{
      'quality': instance.quality,
      'rendition': instance.rendition,
      'type': instance.type,
      'width': instance.width,
      'height': instance.height,
      'link': instance.link,
      'created_time': instance.created_time,
      'fps': instance.fps,
      'size': instance.size,
      'md5': instance.md5,
      'public_name': instance.public_name,
      'size_short': instance.size_short,
    };
