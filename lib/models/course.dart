import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/models/user.dart';
import 'package:isar/isar.dart';
// import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@Collection()
// @JsonSerializable()
class Course {
  Id id = Isar.autoIncrement;

   String title;

  @Index(unique: true, replace: true)
  late int serverId = 0;

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

  // @Backlink(to: "courses")
  // final knowledge = IsarLink<Knowledge>();

  final questionnaire = IsarLinks<Questionnaire>();


  @Ignore()
  bool isSelected = false;
  @Ignore()
  late bool isFullyDisplayed = true;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subjects': subjectIds,
      'knowledge': knowledgeId,
      'questionnaire': questionnaireIds,
    };
  }

  Course({
     this.title='',
     this.subjectIds=const [],
     this.knowledgeId=0,
     this.questionnaireIds=const [],
    this.serverId=0
  });

  factory Course.fromJson(Map<String, dynamic> parsedJson,int courseId) {
    return Course(
        title: parsedJson['title'],
        subjectIds: parsedJson['subjects'],
        knowledgeId: parsedJson['knowledge'],
        questionnaireIds: parsedJson['questionnaire'],
        serverId: courseId,
    );
  }
}
