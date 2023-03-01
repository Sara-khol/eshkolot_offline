import 'package:eshkolot_offline/models/course.dart';
import 'package:isar/isar.dart';

part 'knowledge.g.dart';

@Collection()
class Knowledge {
  // Id id = Isar.autoIncrement;
 late Id id ;
  late String title;
  late String iconPath;
  late int color;
  @Ignore()
  late bool isOpen=false;

  // @Index(unique: true,replace: true,name:'serverId' )
  // late int serverId;

  final courses = IsarLinks<Course>();

}