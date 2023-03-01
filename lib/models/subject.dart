import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:isar/isar.dart';
import 'course.dart';

part 'subject.g.dart';

@Collection()
class Subject {
  Id id = Isar.autoIncrement;
  late String name;

  @Backlink(to: "subjects")
  final course = IsarLink<Course>();

  final lessons = IsarLinks<Lesson>();
   // List<Questionnaire>? questionnaires;
  final questionnaire = IsarLinks<Questionnaire>();

  @Ignore()
  bool isTapped=false;


}

// @embedded
// class  Lesson {
//   // Id id = Isar.autoIncrement;
//   late String name;
//   // late Questionnaire questionnaire;
// final questionnaire = IsarLink<Questionnaire>();
//
// }