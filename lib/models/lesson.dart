import 'package:eshkolot_offline/models/quiz.dart';
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
    return Lesson(
      name: parsedJson['name'],
      questionnaireIds: parsedJson['questionnaire'],
      id:lessonId ,
      vimeo:parsedJson['vimoe'],
      time:parsedJson['time'],
    );
  }

}

