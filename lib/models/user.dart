import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:isar/isar.dart';



part 'user.g.dart';

@Collection()
class User {
  Id id= Isar.autoIncrement;
  late String name;
  //not suppose to be here
  final knowledgeList = IsarLinks<Knowledge>();

  //List<UserCourse> courses=[];
  // final courses= IsarLinks<Course>();
}
@Embedded()
class UserCourse {
  late int courseId;
  @enumerated
   Status status=Status.start;
 late int lessonStopId;
 late String diplomaPath;
  // late Status status;
}

enum Status { start, middle, finish,synchronized }


