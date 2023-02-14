import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/models/user.dart';
import 'package:isar/isar.dart';
// import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@Collection()
// @JsonSerializable()
class Course {
  Id id = Isar.autoIncrement;

  late String title;

  @Index(unique: true,replace: true)
  late int serverId;

  bool isDownloaded = false;
  // @Backlink(to: "course")
  final subjects = IsarLinks<Subject>();

  @Backlink(to: "courses")
  final knowledge = IsarLink<Knowledge>();

  //not suppose to be here, for meanwhile
  @enumerated
  Status status=Status.start;
  late int lessonStopId=0;
  late String diplomaPath='';



// final questionnaires = IsarLinks<Questionnaire>();


}


