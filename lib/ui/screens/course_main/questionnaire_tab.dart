import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';
import '../../../models/questionnaire.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/fill_in_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/free_choice_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/open_question_widget.dart';
import '../question-widgets/radio_check_widget.dart';

class QuestionnaireTab extends StatefulWidget {

  const QuestionnaireTab({super.key, required this.questionnaire});

  final IsarLinks<Questionnaire> questionnaire;

  @override
  State<QuestionnaireTab> createState() => _QuestionnaireTabState();
}

class _QuestionnaireTabState extends State<QuestionnaireTab> {

  CarouselController buttonCarouselController = CarouselController();
  int selected = 1;
  int index=0;
  final int _currentIndex = 0;
  late Widget displayWidget;

  @override
  void initState(){
    displayWidget=getQuestionnaireByType(widget.questionnaire.elementAt(0));
    print(widget.questionnaire.elementAt(0).question);
  }

  getQuestionnaireByType(Questionnaire item) {
    print(item.type);
    switch (item.type) {
      case QType.checkbox:
        return RadioCheck(item);
      case QType.radio:
        return
          RadioCheck(item);
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
    return Column(
      children: <Widget>[
        SizedBox(
          height: 45,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 200, 201, 206))
            ),
            child: Row(
              children: [
                for(int i = 1; i <= widget.questionnaire.length + 1; i++)...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: ClipRRect(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: i == selected ? const Color.fromARGB(
                                  255, 45, 40, 40) : Colors.transparent,
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                alignment: Alignment.center,
                                foregroundColor: i == selected
                                    ? Colors.white
                                    : const Color.fromARGB(255, 45, 40, 40),
                                textStyle: TextStyle(fontSize: 18.w,
                                    fontWeight: FontWeight.w400),
                              ),

                              onPressed: () {
                                print('selected question:  $i');
                                print('current question: $selected');
                                setState(() {
                                  //displayWidget=questionnaire();
                                  selected = i;
                                  index=i-1;
                                  displayWidget=getQuestionnaireByType(widget.questionnaire.elementAt(0));
                                });
                                print('question $selected selected');
                              },
                              child: Text(
                                  '$i', style: TextStyle(fontSize: 18.w)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 15.h,bottom: 30.h),
          child: Row(
            children: [
              Icon(Icons.square, color: Color.fromARGB(255, 45, 40, 40),
                size: 12.w,),
              Text('הנוכחי', style: TextStyle(fontSize: 16.w)),
              Padding(padding: EdgeInsets.only(left: 11.w)),
              Icon(Icons.square, color: Color.fromARGB(255, 110, 112, 114),
                  size: 12.w),
              Text('ביקורת', style: TextStyle(fontSize: 16.w)),
              Padding(padding: EdgeInsets.only(left: 11.w)),
              Icon(Icons.square, color: Color.fromARGB(255, 172, 174, 175),
                  size: 12.w),
              Text('נענו', style: TextStyle(fontSize: 16.w)),
              Padding(padding: EdgeInsets.only(left: 11.w)),
              Icon(Icons.square, color: Color.fromARGB(255, 200, 201, 206),
                  size: 12.w),
              Text('לא נכון', style: TextStyle(fontSize: 16.w)),

              const Spacer(),

              Row(
                children: [
                  SizedBox(
                    height: 23.h,
                    width: 91.w,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: ClipRRect(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: const Color.fromARGB(
                                    255, 200, 201, 206))),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                alignment: Alignment.center,
                                foregroundColor: const Color.fromARGB(
                                    255, 172, 174, 175),
                                textStyle: TextStyle(
                                    fontSize: 12.w,
                                    fontWeight: FontWeight.w400),
                              ),
                              onPressed: () {},
                              child: Text('סקור שאלה',
                                  style: TextStyle(fontSize: 12.w)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        const Divider(color: Color.fromARGB(255, 228, 230, 233)),

        Align(
          alignment: Alignment.centerRight,
          child: Text('Question 1 of ${widget.questionnaire.length}',
            style: const TextStyle(color: Color.fromARGB(255,110, 112, 114)),
          )
        ),

        Column(
          children: [
            getQuestionnaireByType(widget.questionnaire.elementAt(index)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible: _currentIndex!=0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                    child: const Text(
                      "חזרה",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => onBackClick(),
                  ),
                ),
                Visibility(
                  visible: _currentIndex != widget.questionnaire.length - 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                    child: const Text(
                      "הבא",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => onNextClick(),
                  ),
                ),
              ],
            )

          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Visibility(
              visible:_currentIndex!=0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                child: const Text(
                  "חזרה",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => onBackClick(),
              ),
            ),
            Visibility(
              visible: _currentIndex != widget.questionnaire.length - 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                child: const Text(
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
    print('next click');
    buttonCarouselController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  onBackClick() {
    buttonCarouselController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}
