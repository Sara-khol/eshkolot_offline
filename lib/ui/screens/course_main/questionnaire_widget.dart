import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';


class QuestionnaireWidget  extends StatelessWidget {

  final IsarLinks<Questionnaire> questionnaires;

  const QuestionnaireWidget({super.key, required this.questionnaires});


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const Text('שאלון'),
        Text(questionnaires.elementAt(0).question??''),
      ]);
  }
}