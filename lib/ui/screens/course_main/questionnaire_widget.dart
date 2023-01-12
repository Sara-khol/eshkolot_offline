import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/fill_in_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/free_choice_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/open_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../question-widgets/radio_check_widget.dart';

class QuestionnaireWidget extends StatelessWidget {
  CarouselController buttonCarouselController = CarouselController();
  final IsarLinks<Questionnaire> questionnaires;

  QuestionnaireWidget({super.key, required this.questionnaires});

  getQuestionannireByType(Questionnaire item) {
    switch (item.type) {
      case QType.checkbox:
        return RadioCheck(item, buttonCarouselController);
        break;
      case QType.radio:
        return RadioCheck(item, buttonCarouselController);
        break;
      case QType.freeChoice:
        return FreeChoice(item);
        break;
      case QType.fillIn:
        return FillIn(item);
        break;
      case QType.openQ:
        return OpenQuestion(item);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        CarouselSlider(
          carouselController: buttonCarouselController,
          options: CarouselOptions(
              height: height - 100,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              reverse: false
              // autoPlay: false,
              ),
          items: questionnaires //loadQuestions()
              .map((item) => Center(
                child: getQuestionannireByType(item),
              ))
              .toList(),
        ),
      ],
    );
  }
}
