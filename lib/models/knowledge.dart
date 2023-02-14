import 'package:eshkolot_offline/models/course.dart';
import 'package:isar/isar.dart';

part 'knowledge.g.dart';

@Collection()
class Knowledge {
  Id id = Isar.autoIncrement;
  late String title;
  late String iconPath;
  late int color;
  final courses = IsarLinks<Course>();

}