import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:isar/isar.dart';
part 'user.g.dart';

@Collection()
class User {
  Id id= Isar.autoIncrement;
  late String name;
  @Index(unique: true,replace: true,name:'tz')
  late String tz;

  // //not suppose to be here
  // final knowledgeList = IsarLinks<Knowledge>();

  List<int> knowledgeIds=[];

  @Ignore()
  List<Knowledge> knowledgeList=[];

  List<int> pathIds=[];

  @Ignore()
  List<LearnPath> pathList=[];

  // final learnPathList = IsarLinks<LearnPath>();

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


