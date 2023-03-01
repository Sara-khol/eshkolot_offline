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
}

enum QType {
  radio,
  checkbox,
  fillIn,
  freeChoice,
  openQ
}
