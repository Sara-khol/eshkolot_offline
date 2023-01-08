import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:flutter/material.dart';

import '../../../models/lesson.dart';

class QuestionnaireWidget  extends StatelessWidget {

  final Questionnaire questionnaire;

  const QuestionnaireWidget({super.key, required this.questionnaire});


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const Text('שאלון'),
        Text(questionnaire.question??''),
      ],
    ) ;
  }
}