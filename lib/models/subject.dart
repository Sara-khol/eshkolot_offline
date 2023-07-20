import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:isar/isar.dart';

part 'subject.g.dart';

@Collection()
class Subject {
  late Id id/* = Isar.autoIncrement*/;
  late String name;

  bool isCompletedCurrentUser=false;


  // @Backlink(to: "subjects")
  // final course = IsarLink<Course>();

  @Ignore()
  @Name('lessons')
  late List<dynamic> lessonsIds;

  @Ignore()
  @Name('questionnaire')
  late List<dynamic> questionnaireIds = [];

  final lessons = IsarLinks<Lesson>();
   // List<Questionnaire>? questionnaires;
  final questionnaire = IsarLinks<Quiz>();

  @Ignore()
  bool isTapped=false;

  factory Subject.fromJson(Map<String, dynamic> parsedJson,int subjectId) {
    return Subject(
      name: parsedJson['name'],
      lessonsIds: parsedJson['lessons'],
      questionnaireIds: parsedJson['questionnaire'],
      id:subjectId ,
    );
  }


  Subject({
    this.name='',
    this.lessonsIds=const [ ],
    this.questionnaireIds=const [],
    this.id=0,
  });
}

// @embedded
// class  Lesson {
//   // Id id = Isar.autoIncrement;
//   late String name;
//   // late Questionnaire questionnaire;
// final questionnaire = IsarLink<Questionnaire>();
//
// }