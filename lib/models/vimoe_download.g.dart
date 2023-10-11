// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vimoe_download.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VimoeVideo _$VimoeVideoFromJson(Map<String, dynamic> json,int courseId) => VimoeVideo(
      json['link'] as String,
      json['uri'] as String,
      (json['download'] as List<dynamic>)
          .map((e) => VimoeDownload.fromJson(e as Map<String, dynamic>))
          .toList(),
      courseId,
    );

Map<String, dynamic> _$VimoeVideoToJson(VimoeVideo instance) =>
    <String, dynamic>{
      'link': instance.link,
      'uri': instance.uri,
      'courseId': instance.courseId,
      'download': instance.download,
    };

VimoeDownload _$VimoeDownloadFromJson(Map<String, dynamic> json) =>
    VimoeDownload(
      json['quality'] as String?,
      json['rendition'] as String?,
      json['type'] as String?,
      json['width'] as int?,
      json['height'] as int?,
      json['expires'] as String?,
      json['link'] as String?,
      json['created_time'] as String?,
      json['fps'] as int?,
      json['size'] as int?,
      json['md5'] as String?,
      json['public_name'] as String?,
      json['size_short'] as String?,
    );

Map<String, dynamic> _$VimoeDownloadToJson(VimoeDownload instance) =>
    <String, dynamic>{
      'quality': instance.quality,
      'rendition': instance.rendition,
      'type': instance.type,
      'width': instance.width,
      'height': instance.height,
      'expires': instance.expires,
      'link': instance.link,
      'created_time': instance.created_time,
      'fps': instance.fps,
      'size': instance.size,
      'md5': instance.md5,
      'public_name': instance.public_name,
      'size_short': instance.size_short,
    };
