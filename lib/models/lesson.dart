import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:isar/isar.dart';

part 'lesson.g.dart';

@collection
class  Lesson {
  Id id = Isar.autoIncrement;
  late String name;
  // Questionnaire? questionnaire;
  final questionnaire = IsarLink<Questionnaire>();

}

