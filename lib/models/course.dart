import 'package:eshkolot_offline/models/subject.dart';
import 'package:isar/isar.dart';

part 'course.g.dart';

@Collection()
class Course {
  Id id = Isar.autoIncrement;
  late String title;

  // @Backlink(to: "course")
  final subjects = IsarLinks<Subject>();
  // final questionnaires = IsarLinks<Questionnaire>();

}
