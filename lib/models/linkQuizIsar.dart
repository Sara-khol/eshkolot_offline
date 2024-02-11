import 'package:dio/dio.dart';
import 'package:isar/isar.dart';

part 'linkQuizIsar.g.dart';

@Collection()
class LinkQuizIsar {
   Id id=Isar.autoIncrement;

  late int quizId;
  late int courseId;
  bool isDownload = false;
  late String downloadLink;
  late String name;
  late bool isBlock;
}