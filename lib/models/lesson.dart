import 'package:eshkolot_offline/models/quiz.dart';
import 'package:html/parser.dart';
import 'package:isar/isar.dart';

part 'lesson.g.dart';

@collection
class  Lesson {
   late Id id ;
  late String name;

   @Ignore()
   @Name('questionnaire')
   late List<dynamic> questionnaireIds = [];

  // Questionnaire? questionnaire;
  final questionnaire = IsarLinks<Quiz>();

   bool isCompletedCurrentUser=false;

  @Name('vimoe')
  String? vimeo='';

   String time;

  Lesson({
    this.name='',
    this.id=0,
    this.vimeo='',
    this.time='',
    this.questionnaireIds=const []
  });

  factory Lesson.fromJson(Map<String, dynamic> parsedJson,int lessonId) {
    final String parsedString = parse(parsedJson['name']).documentElement!.text;

    return Lesson(
      // name:parsedJson['name'],
      name:parsedString,
      questionnaireIds: parsedJson['questionnaire'],
      id:lessonId ,
      vimeo:parsedJson['vimoe'],
      time:parsedJson['time']??''
          '',
    );
  }


   String removeAllHtmlTags(String htmlText) {
     RegExp exp = RegExp(
         r"<[^>]*>",
         multiLine: true,
         caseSensitive: true
     );

     return htmlText.replaceAll(exp, '');
   }
}

