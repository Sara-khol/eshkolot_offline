import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/fill_in_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/free_choice_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/open_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../question-widgets/radio_check_widget.dart';

class QuestionnaireWidget extends StatefulWidget {
  final IsarLinks<Questionnaire> questionnaires;

  const QuestionnaireWidget({super.key, required this.questionnaires});

  @override
  State<QuestionnaireWidget> createState() => _QuestionnaireWidgetState();
}

class _QuestionnaireWidgetState extends State<QuestionnaireWidget> {
  CarouselController buttonCarouselController = CarouselController();

  int _currentIndex = 0;

  getQuestionnaireByType(Questionnaire item) {
    switch (item.type) {
      case QType.checkbox:
        return RadioCheck(item);
      case QType.radio:
        return RadioCheck(item);
      case QType.freeChoice:
        return FreeChoice(item);
      case QType.fillIn:
        return FillIn(item);
      case QType.openQ:
        return OpenQuestion(item);
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
              reverse: false,
            onPageChanged: (index, reason) {
              _currentIndex = index;
              setState(() {});
            },
              // autoPlay: false,
              ),
          items: widget.questionnaires //loadQuestions()
              .map((item) => Center(
                    child: getQuestionnaireByType(item),
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Visibility(
              visible:_currentIndex!=0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                child: Text(
                  "חזרה",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => onBackClick(),
              ),
            ),
            Visibility(
              visible: _currentIndex!=widget.questionnaires.length-1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                child: Text(
                  "הבא",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => onNextClick(),
              ),
            ),

          ],
        )
      ],
    );
  }

  onNextClick() {
    buttonCarouselController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  onBackClick() {
    buttonCarouselController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}
