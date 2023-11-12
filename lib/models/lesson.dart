import 'package:eshkolot_offline/models/quiz.dart';
import 'package:html/parser.dart';
import 'package:isar/isar.dart';

part 'lesson.g.dart';

@collection
class Lesson {
  // late Id id;

  Id id = Isar.autoIncrement;

   @Index(unique: true,replace: true)
  late int lessonId;

  late String name;

  @Ignore()
  @Name('questionnaire')
  late List<dynamic> questionnaireIds = [];

  // Questionnaire? questionnaire;
  final questionnaire = IsarLinks<Quiz>();

  bool isCompletedCurrentUser = false;

  @Name('vimoe')
  String? vimeo = '';

  String time;
  String videoNum;
  @Index()
  late int courseId;


  Lesson(
      {this.name = '',
     // this.id = 0,
      this.vimeo = '',
      this.time = '',
      this.videoNum = '',
        this.lessonId=0,
      this.questionnaireIds = const [],
      this.courseId = 0});

  factory Lesson.fromJson(
      Map<String, dynamic> parsedJson, int lessonId, int courseId) {
    final String parsedString = parse(parsedJson['name']).documentElement!.text;

    return Lesson(
      // name:parsedJson['name'],
      name: parsedString,
      questionnaireIds: parsedJson['questionnaire'],
     // id: lessonId,
      lessonId: lessonId,
      videoNum: '',
      vimeo: parsedJson['vimoe'],
      time: parsedJson['time'] ?? '',
      courseId: courseId
    );
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
