import 'package:dio/dio.dart';
import 'package:flowder/flowder.dart';
import 'package:isar/isar.dart';

part 'videoIsar.g.dart';

@Collection()
class VideoIsar {
  late Id id;
  bool isDownload = false;
  late String downloadLink;
  @Ignore()
 late RequestOptions? requestOptions;
 late String name ;
  @Ignore()
   DownloaderCore? core;

}
