import 'package:eshkolot_offline/models/subject.dart';
import 'package:isar/isar.dart';
// import 'package:json_annotation/json_annotation.dart';


part 'course.g.dart';

@Collection()
// @JsonSerializable()
class Course {
  Id id = Isar.autoIncrement;
  late String title;

  // @Backlink(to: "course")
  final subjects = IsarLinks<Subject>();
  // final questionnaires = IsarLinks<Questionnaire>();



}
