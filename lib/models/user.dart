import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:isar/isar.dart';

import 'course.dart';

part 'user.g.dart';

@Collection()
class User {
  late Id id /*= Isar.autoIncrement*/;
  late String name;
  @Index(unique: true, replace: true, name: 'tz')
  late String tz;
  late String userType;

  List<int> knowledgeIds = [];


  @Ignore()
  late Map<Knowledge, List<Course>> knowledgeCoursesMap =
  {};





  List<int> pathIds = [];

  @Ignore()
  List<LearnPath> pathList = [];

  // final learnPathList = IsarLinks<LearnPath>();
  @Name('UserCourse')
  List<UserCourse> courses = [];

  List<int> subjectCompleted = [];
  List<int> questionCompleted = [];
  List<int> lessonCompleted = [];
  List<UserGrade> percentages = [];


// final courses= IsarLinks<Course>();
}

@Embedded()
class UserCourse {
  late int courseId = 0;
  @enumerated
  late Status status;

  @ignore
  @Name('status')
  late String statusJson = 'הושלם';

  @Name('progress_percent')
  late int progressPercent;

  @Name('is_single_course')
  late bool isSingleCourse;

  late int lessonStopId = 0;
  late int subjectStopId = 0;
  late int questionnaireStopId = 0;
  bool isQuestionnaire = false;
  late String diplomaPath = '';
  @ignore
  late int subjectIndex = -1;
  @ignore
  late int lessonIndex = -1;
  @ignore
  late int questionIndex = -1;





  UserCourse(
      {this.courseId=0,  this.status=Status.start,
        this.isSingleCourse=false,
        this.statusJson='',
         this.progressPercent=0,  this.diplomaPath=''});

  factory UserCourse.fromJson(Map<String, dynamic> json) {

    final status = stringToStatusType(json['status'] as String, json['diplomaPath'] as String);

    return UserCourse(
        courseId: json['courseId'] as int,
        diplomaPath: json['diplomaPath'] as String,
        statusJson: json['status'] as String,
        progressPercent: json['progress_percent'] as int,
        isSingleCourse: json['is_single_course']==null?false:json['is_single_course'] as bool,
        status: status);
  }


Map<String, dynamic> toJson() {
  return {
    'courseId': courseId,
    'diplomaPath': diplomaPath,
    'status': status.index,
    'progress_percent': progressPercent,
    'lessonStopId': 0,
    'subjectStopId': 0,
    'questionnaireStopId': 0,
    'isQuestionnaire': false,
    'is_single_course': isSingleCourse
  };
}


 Status stringToStatusType1(String value) {
  late Status status;
  switch (value) {
    case 'לא התחיל':
      status = Status.start;
      break;
    case 'הושלם' :
      status = Status.finish;
      break;
    case 'בתהליך':
      status = Status.middle;
      break;
    default:
      throw Exception('Invalid Status type: $value');
  }
  if (status == Status.finish && diplomaPath.isNotEmpty) {
    status = Status.synchronized;
  }
  return status;
}


 static Status stringToStatusType(String value, String diplomaPath) {
    late Status status;
    switch (value) {
      case 'לא התחיל':
        status = Status.start;
        break;
      case 'הושלם':
        status = Status.finish;
        break;
      case 'בתהליך':
        status = Status.middle;
        break;
      default:
        throw Exception('Invalid Status type: $value');
    }
    if (status == Status.finish && diplomaPath.isNotEmpty) {
      status = Status.synchronized;
    }
    return status;
  }

}

@Embedded()
class UserGrade {
  late int quizId = 0;
  late int percentage = 0;
  late int score = 0;




  UserGrade(
      {this.quizId=0,  this.percentage=0,this.score=0});


  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'percentage': percentage,
      'score': score,

    };
  }


}

enum Status { start, middle, finish, synchronized }


