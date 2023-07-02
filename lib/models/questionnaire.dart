import 'dart:collection';

import 'package:isar/isar.dart';

part 'questionnaire.g.dart';

@collection
class Questionnaire {
  Id id = Isar.autoIncrement;
  late String question;
  late List<String>? options=[];
  late List<String>? ans=[];
  late String? fillInQuestion='';
  @enumerated
  late QType type;

  bool isComplete=false;


  // factory Questionnaire.fromJson(Map<String, dynamic> parsedJson,int qId) {
  //   return Questionnaire(
  //     question: parsedJson['question'],
  //     lessonsIds: parsedJson['lessons'],
  //     questionnaireIds: parsedJson['questionnaire'],
  //     id:subjectId ,
  //   );
  // }
  //
  // Questionnaire({
  //   this.question='',
  //   this.lessonsIds=const [ ],
  //   this.questionnaireIds=const [],
  //   this.id=0,
  // });
}

@Embedded()

  class Answer
  {
   late String ans;
   @Name('isCurrect')
   late bool isCorrect;
   late int points;
  }


enum QType {
  radio,
  checkbox,
  fillIn,
  freeChoice,
  openQ
}
