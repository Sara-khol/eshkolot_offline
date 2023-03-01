import 'package:eshkolot_offline/models/course.dart';
import 'package:isar/isar.dart';

part 'learn_path.g.dart';

@Collection()
class LearnPath
{
 late Id id;

  // @Index(unique: true,replace: true)
  // late int serverId;

  late String title;
  late int color;
  late String iconPath;
  bool isOpen=false;
  // List<int> coursesId=[];
  final courses = IsarLinks<Course>();

}