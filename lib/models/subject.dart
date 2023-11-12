import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:html/parser.dart';
import 'package:isar/isar.dart';

part 'subject.g.dart';

@Collection()
class Subject {
  // late Id id;
  Id id = Isar.autoIncrement;

  @Index(unique: true,replace: true)
  late int subjectId;

  late String name;
  late String time;

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
    final String parsedString = parse(parsedJson['name']).documentElement!.text;
    return Subject(
      // name: parsedJson['name'],
      name: parsedString,
      time:parsedJson['time'],
      lessonsIds: parsedJson['lessons'],
      questionnaireIds: parsedJson['questionnaire'],
      subjectId:subjectId ,
    );
  }


  Subject({
    this.name='',
    this.time='',
    this.lessonsIds=const [ ],
    this.questionnaireIds=const [],
    this.subjectId=0,
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