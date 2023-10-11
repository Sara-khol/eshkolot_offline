import 'package:dio/dio.dart';
import 'package:isar/isar.dart';

part 'videoIsar.g.dart';

@Collection()
class VideoIsar {
  late Id id;
  @Index()
  late int courseId;
  bool isDownload = false;
  late String downloadLink;
  late int expiredDate;
  @Ignore()
 late RequestOptions? requestOptions;
 late String name ;


}
