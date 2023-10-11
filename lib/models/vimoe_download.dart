// import 'package:json_annotation/json_annotation.dart';
//
// part 'vimoe_download.g.dart';
//
//
// @JsonSerializable()
// class VimoeVideo
// {
//   late String link;
//   late String uri;
//   late List<VimoeFile> files;
//
//   VimoeVideo(this.link,this.uri,this.files/*,this.files*/);
//
//   factory VimoeVideo.fromJson(Map<String, dynamic> json) => _$VimoeVideoFromJson(json);
//
//   Map<String, dynamic> toJson() => _$VimoeVideoToJson(this);
// }
//
// @JsonSerializable()
// class VimoeFile
// {
//   late String? quality;
//   late String? rendition;
//   late String? type;
//   late int? width;
//   late int? height;
//   late  String? link;
//   late String? created_time;
//   late int? fps;
//   late int? size;
//   late String? md5;
//   late  String? public_name;
//   late String? size_short;
//
//
//
//   VimoeFile(
//       this.quality,
//       this.rendition,
//       this.type,
//       this.width,
//       this.height,
//       this.link,
//       this.created_time,
//       this.fps,
//       this.size,
//       this.md5,
//       this.public_name,
//       this.size_short);
//
//   factory VimoeFile.fromJson(Map<String, dynamic> json) => _$VimoeFileFromJson(json);
//
//   Map<String, dynamic> toJson() => _$VimoeFileToJson(this);
// }

import 'package:json_annotation/json_annotation.dart';

part 'vimoe_download.g.dart';


@JsonSerializable()
class VimoeVideo
{

  late String link;
  late String uri;
  late int courseId;
  late List<VimoeDownload> download;
  // late List<VimoeDownload> files;

  VimoeVideo(this.link,this.uri,this.download,this.courseId/*,this.files*/);

  factory VimoeVideo.fromJson(Map<String, dynamic> json,int courseId) => _$VimoeVideoFromJson(json,courseId);

  Map<String, dynamic> toJson() => _$VimoeVideoToJson(this);
}

@JsonSerializable()
class VimoeDownload
{
  late String? quality;
  late String? rendition;
  late String? type;
  late int? width;
  late int? height;
  late String? expires;
  late  String? link;
  late String? created_time;
  late int? fps;
  late int? size;
  late String? md5;
  late  String? public_name;
  late String? size_short;


  VimoeDownload(
      this.quality,
      this.rendition,
      this.type,
      this.width,
      this.height,
      this.expires,
      this.link,
      this.created_time,
      this.fps,
      this.size,
      this.md5,
      this.public_name,
      this.size_short);

  factory VimoeDownload.fromJson(Map<String, dynamic> json) => _$VimoeDownloadFromJson(json);

  Map<String, dynamic> toJson() => _$VimoeDownloadToJson(this);
}