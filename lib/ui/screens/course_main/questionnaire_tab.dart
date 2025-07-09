import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/order_selection_matrix_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/order_selection_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/upgraded_editor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/quiz.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/fill_in_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/free_choice_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/open_question_widget.dart';
import '../../../utils/common_funcs.dart';
import '../question-widgets/radio_check_widget.dart';
import 'main_page_child.dart';

class QuestionnaireTab extends StatefulWidget {
  const QuestionnaireTab({super.key, required this.quiz});

  final Quiz quiz;

  // final int questionnaireId;

  @override
  State<QuestionnaireTab> createState() => _QuestionnaireTabState();
}

class _QuestionnaireTabState extends State<QuestionnaireTab> {
  int selected = 1;
  int index = 0;
  late QuestionController myQController = QuestionController();
  int qNum = 0;
  late List<Widget> displayAllWithAnswers;
  late List<bool> statusAnswers;
  int quizPoints = 0, totalQuizPoints = 0;

  @override
  void initState() {
    //displayWidget=getQuestionnaireByType(widget.questionnaire.elementAt(0));
    // debugPrint(widget.questionnaire.elementAt(0).question);
    displayAllWithAnswers = List.generate(
      widget.quiz.questionList.length,
      (index) => Container(),
    );
    statusAnswers = List.generate(
      widget.quiz.questionList.length,
      (index) => false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        SizedBox(
          height: 60.h,
        ),
        Wrap(
          children: [
            for (int i = 1; i <= widget.quiz.questionList.length; i++) ...[
              GestureDetector(
                child: Container(
                  width: 70.w,
                  padding: EdgeInsets.all(20.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: i == selected
                        ? const Color((0xFF5956DA))
                        : Colors.transparent,
                  ),
                  child: /*TextButton(
                    style: TextButton.styleFrom(
                      alignment: Alignment.center,
                      foregroundColor: i == selected
                          ? Colors.white
                          : const Color((0xFF2D2828)),
                      textStyle: TextStyle(fontSize: 18.w),
                    ),
                    onPressed: ,
                    child:*/
                      Text('$i',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: i == selected
                                  ? Colors.white
                                  : const Color((0xFF2D2828)),
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center),
                  // ),
                ),
                onTap: () {
                  // if (myQController.isFilled != null &&
                  //     myQController.isFilled!()) {
                  //   widget.quiz.questionList.elementAt(selected - 1).isFilled =
                  //       true;
                  //
                  //   if (myQController.isCorrect != null) {
                  //     widget.quiz.questionList
                  //         .elementAt(selected - 1)
                  //         .isCorrect = myQController.isCorrect!();
                  //     debugPrint(
                  //         'iscorrect ${widget.quiz.questionList.elementAt(selected - 1).isCorrect}');
                  //   }
                  //
                  //   displayAllWithAnswers[index] =
                  //       myQController.displayWithAnswers ??
                  //           const Text('problem');
                  // }
                  //
                  //
                  // setState(() {
                  //   selected = i;
                  //   index = i - 1;
                  // });
                },
              ),
              //),
            ]
          ],
        ),
        //  ),
        //todo remove question colors for now
        SizedBox(height: 15.h),
        // Padding(
        //   padding: EdgeInsets.only(top: 15.h, bottom: 30.h),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Icon(
        //         Icons.square,
        //         color: const Color(0xFF5956DA),
        //         size: 15.sp,
        //       ),
        //       Text(' הנוכחי', style: TextStyle(fontSize: 16.w)),
        //       SizedBox(
        //         width: 11.w,
        //       ),
        //       Icon(Icons.square, color: const Color(0xFFACAEAF), size: 15.sp),
        //       Text(' ביקורת', style: TextStyle(fontSize: 16.w)),
        //       SizedBox(
        //         width: 11.w,
        //       ),
        //       Icon(Icons.square, color: const Color(0xFF62FFB8), size: 15.sp),
        //       Text(' נענו', style: TextStyle(fontSize: 16.w)),
        //       SizedBox(
        //         width: 11.w,
        //       ),
        //       Icon(Icons.square, color: const Color(0xFFF97575), size: 15.sp),
        //       Text(' לא נכון', style: TextStyle(fontSize: 16.w)),
        //       const Spacer(),
        //       Container(
        //         height: 20.h,
        //         width: 100.w,
        //         decoration: const BoxDecoration(
        //             color: Color(0xFFF4F4F3),
        //             borderRadius: BorderRadius.all(Radius.circular(10))),
        //         child: TextButton(
        //           style: TextButton.styleFrom(
        //             alignment: Alignment.center,
        //             foregroundColor: const Color(0xFF2D2828),
        //             textStyle:
        //                 TextStyle(fontSize: 12.w, fontWeight: FontWeight.w600),
        //           ),
        //           onPressed: () {},
        //           child: Row(
        //             children: [
        //               Text('סקור שאלה', style: TextStyle(fontSize: 12.w)),
        //               Icon(
        //                 Icons.arrow_forward,
        //                 size: 10.sp,
        //               )
        //             ],
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        const Divider(color: Color.fromARGB(255, 228, 230, 233)),
        Align(
            alignment: Alignment.centerRight,
            child: Text(
              'שאלה $selected מתוך ${widget.quiz.questionList.length}',
              style: TextStyle(color: const Color(0xFF6E7072), fontSize: 18.sp),
            )),
        Column(
          children: [
            // getQuestionnaireByType(widget.questionnaire.elementAt(index)),
            getQuestionnaireByType(
                widget.quiz.questionList.elementAt(selected - 1)),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: selected != 1,
                  child: Container(
                    height: 40.h,
                    //  width: 125.w,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          //     shape: const RoundedRectangleBorder(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(12))),
                          backgroundColor: const Color(0xFF5956DA)),
                      child: Text(
                        "חזרה",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp),
                      ),
                      onPressed: () => onBackClick(),
                    ),
                  ),
                ),
                Container(
                  height: 40.h,
                  // width: 125.w,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        // shape: const RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.all(Radius.circular(30))),
                        backgroundColor: const Color(0xFF5956DA)),
                    child: Text(
                      selected == widget.quiz.questionList.length
                          ? "סיום שאלון"
                          : "הבא",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp),
                    ),
                    onPressed: () => selected == widget.quiz.questionList.length
                        ? onFinishClick()
                        : onNextClick(),
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
      // ),
    );
  }

  getQuestionnaireByType(Question item) {
    debugPrint('type ${item.type}');
    myQController = QuestionController();
    item.quizId = widget.quiz.id;
    switch (item.type) {
      case QType.checkbox:
        return RadioCheck(item, questionController: myQController);
      case QType.radio:
        return RadioCheck(item, questionController: myQController);
      case QType.freeChoice:
        return FreeChoice(item, questionController: myQController);
      case QType.fillIn:
        return FillIn(item, questionController: myQController);
      case QType.openQ:
        return OpenQuestion(item, questionController: myQController);
      case QType.sort:
        return OrderSelectionWidget(item, questionController: myQController);
      // return Container();
      case QType.sortMatrix:
        return OrderSelectionMatrixWidget(item,
            questionController: myQController);
      case QType.customEditor:
        return UpgradedEditorWidget(item, questionController: myQController);
    }
  }

  bool onNextClick({bool isLast = false}) {
    if (myQController.isFilled != null && myQController.isFilled!()) {
      widget.quiz.questionList.elementAt(selected - 1).isFilled = true;

      if (myQController.isCorrect != null) {
        int numPoints = myQController.isCorrect!();
        quizPoints += numPoints;
        totalQuizPoints +=
            widget.quiz.questionList.elementAt(selected - 1).points;
        widget.quiz.questionList.elementAt(selected - 1).isCorrect =
            numPoints ==
                widget.quiz.questionList.elementAt(selected - 1).points;
        debugPrint(
            'numPoints $numPoints totalpoints ${widget.quiz.questionList.elementAt(selected - 1).points} iscorrect ${widget.quiz.questionList.elementAt(selected - 1).isCorrect}');
      }

      displayAllWithAnswers[index] =
          myQController.displayWithAnswers ?? const Text('problem');
      if (!isLast) {
        setState(() {
          index++;
          selected++;
        });
      }
      // else
      //   {
      //     bool isAllFilled = widget.quiz.questionList.every((item) {
      //       // Check if the item is not null and not empty
      //       return item.isFilled;
      //     });
      //     if(isAllFilled)
      //       {
      //         return true;
      //       }
      //     else{
      //       CommonFuncs().showMyToast('נא למלא את כל השאלות');
      //       return false;
      //     }
      //   }
    } else {
      if (myQController.isFilled != null) {
        CommonFuncs().showMyToast('הינך חייב לענות על השאלה');
        return false;
      }
      // not supposed to get to here for meanwhile
      // else {
      //   //todo change , not allow to go next
      //   // CommonFuncs().showMyToast(
      //   //     'בעיה');
      //   if (!isLast) {
      //     setState(() {
      //       index++;
      //       selected++;
      //     });
      //   }
      // }
    }
    return true;
  }

  onFinishClick() {
    if (onNextClick(isLast: true)) {
      if (checkAnswers()) {
        // QuestionnaireWidget.of(context)?.setInitialDisplay();
        if(isGradeOk(quizPoints, totalQuizPoints, widget.quiz.grade1, widget.quiz.grade2)) {
          MainPageChild.of(context)?.updateCompleteQuiz(widget.quiz.id);
        }
        QuestionnaireWidget.of(context)?.setEndQuestionnaire(
            statusAnswers: statusAnswers,
            grade1: widget.quiz.grade1,
            grade2: widget.quiz.grade2,
            qID: widget.quiz.id,
            displayAnswersWidget: displayAllWithAnswers,
            numPoints: quizPoints,
            totalPoints: totalQuizPoints);
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return QuestionnaireEndDialog(
        //           qID: widget.quiz.id,
        //           qNum: qNum,
        //           correctQNum: correctQNum,
        //           grade1: widget.quiz.grade1,
        //           grade2: widget.quiz.grade2);
        //     });
      }
    }
  }

  bool isGradeOk(int numPoints,int totalPoints,int grade1,int grade2){
    debugPrint('isGradeOk numPoints $numPoints grade1 $grade1');
  num  grade =
        ((numPoints / totalPoints) * 100).round();
    debugPrint('isGradeOk grade $grade ${grade1>=grade}');
    return grade1<=grade;
  }

  bool checkAnswers() {
    qNum = 0;
    for (Question q in widget.quiz.questionList) {
      if (!q.isFilled) {
        CommonFuncs().showMyToast('ישנם שאלות שלא מולאו');
        return false;
      } else if (q.isCorrect) {
        statusAnswers[qNum] = true;
      }
      qNum++;
    }
    return true;
  }

  onBackClick() {
    setState(() {
      index--;
      selected--;
    });
  }

  @override
  didChangeDependencies() {
    debugPrint('qu didChangeDependencies');
    super.didChangeDependencies();
  }

// @override
// void dispose() {
//   debugPrint('fff restartQ $restartQ');
//   for (Question question in widget.quiz.questionList) {
//     // for (Answer answer in question.ans!)
//     //   {
//     //     debugPrint('=====');
//     //     debugPrint('${answer.ans} isSelected ${answer.isSelected} isCorrect ${answer.isCorrect}');
//     //   }
//   }
//   if(restartQ) {
//     for (Question question in widget.quiz.questionList) {
//       question.setAllAnswersToFalse();
//     }
//   }
//   super.dispose();
// }
}

class QuestionController {
  bool Function()? isFilled;
  int Function()? isCorrect;
  Widget? displayWithAnswers;
}
