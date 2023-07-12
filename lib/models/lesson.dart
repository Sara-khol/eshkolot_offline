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
  final questionnaire = IsarLink<Quiz>();
  bool isCompleted=false;

  @Name('vimoe')
  String? vimeo='';

  Lesson({
    this.name='',
    this.id=0,
    this.vimeo='',
    this.questionnaireIds=const []
  });

  factory Lesson.fromJson(Map<String, dynamic> parsedJson,int lessonId) {
    return Lesson(
      name: parsedJson['name'],
      questionnaireIds: parsedJson['questionnaire'],
      id:lessonId ,
      vimeo:parsedJson['vimoe'],
    );
  }

}

