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

  List<UserCourse> courses=[];


  User();
// final courses= IsarLinks<Course>();
}
@Embedded()
class UserCourse {

  late int courseId=0;
  @enumerated
 Status status=Status.start;
 late int lessonStopId=0;
 late int subjectStopId=0;
 late int questionnaireStopId=0;
 bool isQuestionnaire=false;
 late String diplomaPath='';
 @ignore
  late int subjectIndex;
  @ignore
  late int lessonIndex;
  // late Status status;
}

enum Status { start, middle, finish,synchronized }


