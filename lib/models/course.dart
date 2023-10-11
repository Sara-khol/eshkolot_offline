import 'package:eshkolot_offline/models/quiz.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:isar/isar.dart';
// import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@Collection()
// @JsonSerializable()
class Course {
  Id id = Isar.autoIncrement;
  // int vimeoId=10390152/*2567060*/;
   String vimeoId/*2567060*/;
   String title;

  // @Index(unique: true, replace: true)
  // late int serverId = 0;

  // @Backlink(to: "course")
  final subjects = IsarLinks<Subject>();


  @Ignore()
  @Name('subjects')
  late List<dynamic> subjectIds;

  @Ignore()
  @Name('questionnaire')
  late List<dynamic> questionnaireIds = [];


/*  @Name('knowledge')*/
  late int? knowledgeId;

  late String? countHours;
  late String? countLesson;
  late String? countQuiz;
  late String? countEndQuiz;

  // @Name('knowledge_num')
  late String? knowledgeNum;

  // @Backlink(to: "courses")
  // final knowledge = IsarLink<Knowledge>();

  final  questionnaires = IsarLinks<Quiz>();


  @Ignore()
  bool isSelected = false;
  @Ignore()
  late bool isFullyDisplayed = true;

  @Ignore()
  int currentSteps=0;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subjects': subjectIds,
      'knowledge': knowledgeId,
      'questionnaire': questionnaireIds,
      'countHours': countHours,
      'countLesson': countLesson,
      'countQuiz': countQuiz,
      'countEndQuiz': countEndQuiz,
      'knowledgeNum': knowledgeNum,
       'vimeoId': vimeoId,
    };
  }

  Course({
     this.title='',
     this.subjectIds=const [],
     this.knowledgeId=0,
     this.questionnaireIds=const [],
    // this.serverId=0,
    this.id=0,
    this.knowledgeNum,
    this.vimeoId='',
    this.countHours,
    this.countLesson,
    this.countEndQuiz,
    this.countQuiz
  });

  factory Course.fromJson(Map<String, dynamic> parsedJson,int courseId) {
    return Course(
        title: parsedJson['title'],
        subjectIds: parsedJson['subjects'],
        knowledgeId: parsedJson['knowledge'],
        questionnaireIds: parsedJson['questionnaire'],
        countHours: parsedJson['countHours'],
        countLesson: parsedJson['countLesson'],
        countQuiz: parsedJson['countQuiz'],
        countEndQuiz: parsedJson['countEndQuiz'],
        knowledgeNum: parsedJson['knowledge_num'],
        vimeoId: parsedJson['vimeoId'],
        // serverId: courseId,
        id: courseId,
    );
  }
}
