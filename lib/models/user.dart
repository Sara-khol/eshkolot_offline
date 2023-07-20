
import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:isar/isar.dart';

import 'course.dart';
part 'user.g.dart';

@Collection()
class User {
  Id id= Isar.autoIncrement;
  late String name;
  @Index(unique: true,replace: true,name:'tz')
  late String tz;

  List<int> knowledgeIds=[];


  @Ignore()
 late Map<Knowledge,List<Course>> knowledgeCoursesMap=
  {};


  final learnPathList = IsarLinks<LearnPath>();


  List<int> pathIds=[];

  @Ignore()
  List<LearnPath> pathList=[];

  // final learnPathList = IsarLinks<LearnPath>();
  @Name('UserCourse')
  List<UserCourse> courses=[];

  List<int> subjectCompleted=[];
  List<int> questionCompleted=[];
  List<int> lessonCompleted=[];




// final courses= IsarLinks<Course>();
}
@Embedded()
class UserCourse {
  late int courseId=0;
  @enumerated
  late Status status;

  @ignore  @Name('status')
 late String statusJson='הושלם';

  @Name('progress_percent')
  late int progressPercent;

 late int lessonStopId=0;
 late int subjectStopId=0;
 late int questionnaireStopId=0;
 bool isQuestionnaire=false;
 late String diplomaPath='';
 @ignore
  late int subjectIndex;
  @ignore
  late int lessonIndex;


  void setComputedPropertyFromJson(Map<String, dynamic> json) {
    courseId = json['courseId'] as int;
    diplomaPath = json['diplomaPath'] as String;
    statusJson = json['status'] as String;
    progressPercent = json['progress_percent'] as int;
    status = stringToStatusType(statusJson);
  }


  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'diplomaPath': diplomaPath,
     'status':status.index,
     'progress_percent':progressPercent,
   'lessonStopId':0,
   'subjectStopId':0,
   'questionnaireStopId':0,
    'isQuestionnaire':false
    };
  }


  Status stringToStatusType(String value) {
   late Status status;
    switch (value) {
      case 'לא התחיל':
        status= Status.start;
        break;
      case 'הושלם' :
        status= Status.finish;
        break;
      case 'בתהליך':
        status= Status.middle;
        break;
      default:
        throw Exception('Invalid Status type: $value');
    }
    if(status==Status.finish && diplomaPath.isNotEmpty)
      {
        status=Status.synchronized;
      }
    return status;
  }

}

enum Status { start, middle, finish,synchronized }


