import 'dart:collection';

import 'package:isar/isar.dart';

part 'questionnaire.g.dart';

@collection
class Questionnaire {
  Id id = Isar.autoIncrement;
  late String question;
  late String? optionA='';
  late String? optionB='';
  late String? optionC='';
  late String? optionD='';
  late List<String>? ans=[];
  late String? fillInQuestion='';
  @enumerated
  late QType type;

  // Questionnaire({this.question, this.optionA, this.optionB, this.optionC,
  //   this.optionD, this.ans, this.type});

// Questionnaire(this.question, this.optionA, this.optionB, this.optionC,
//   this.optionD, this.ans, this.type);
}

enum QType {
  radio,
  checkbox,
  fillIn,
  freeChoice,
  openQ
}
