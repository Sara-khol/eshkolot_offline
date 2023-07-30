import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_end_dialog.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/order_selection_matrix_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/order_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/quiz.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/fill_in_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/free_choice_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/open_question_widget.dart';
import '../../../utils/common_funcs.dart';
import '../question-widgets/radio_check_widget.dart';
import 'main_page_child.dart';

class QuestionnaireTab extends StatefulWidget {
  const QuestionnaireTab({super.key, required this.questionnaire, required this.questionnaireId});

  final List<Question> questionnaire;
  final int questionnaireId;

  @override
  State<QuestionnaireTab> createState() => _QuestionnaireTabState();
}

class _QuestionnaireTabState extends State<QuestionnaireTab> {
  int selected = 1;
  int index = 0;
  late  QuestionController myQController = QuestionController();
  int correctQNum=0;
  int qNum=0;


  @override
  void initState() {
    //displayWidget=getQuestionnaireByType(widget.questionnaire.elementAt(0));
    // debugPrint(widget.questionnaire.elementAt(0).question);
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
                for (int i = 1; i <= widget.questionnaire.length; i++) ...[
                    Container(
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: i == selected
                            ? const Color((0xFF5956DA))
                            : Colors.transparent,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          alignment: Alignment.center,
                          foregroundColor:
                              i == selected ? Colors.white : const Color((0xFF2D2828)),
                          textStyle: TextStyle(fontSize: 18.w),
                        ),
                        onPressed: () {
                          setState(() {
                            selected = i;
                            index = i - 1;
                          });
                        },
                        child: Text('$i', style: TextStyle(fontSize: 18.w)),
                      ),
                    ),
                  //),
                ]
              ],
            ),
        //  ),
          Padding(
            padding: EdgeInsets.only(top: 15.h, bottom: 30.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.square,
                  color: const Color(0xFF5956DA),
                  size: 15.sp,
                ),
                Text(' הנוכחי', style: TextStyle(fontSize: 16.w)),
                SizedBox(
                  width: 11.w,
                ),
                Icon(Icons.square, color: const Color(0xFFACAEAF), size: 15.sp),
                Text(' ביקורת', style: TextStyle(fontSize: 16.w)),
                SizedBox(
                  width: 11.w,
                ),
                Icon(Icons.square, color: const Color(0xFF62FFB8), size: 15.sp),
                Text(' נענו', style: TextStyle(fontSize: 16.w)),
                SizedBox(
                  width: 11.w,
                ),
                Icon(Icons.square, color: const Color(0xFFF97575), size: 15.sp),
                Text(' לא נכון', style: TextStyle(fontSize: 16.w)),
                const Spacer(),
                Container(
                  height: 20.h,
                  width: 100.w,
                  decoration: const BoxDecoration(
                      color: Color(0xFFF4F4F3),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      alignment: Alignment.center,
                      foregroundColor: const Color(0xFF2D2828),
                      textStyle:
                          TextStyle(fontSize: 12.w, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text('סקור שאלה', style: TextStyle(fontSize: 12.w)),
                        Icon(
                          Icons.arrow_forward,
                          size: 10.sp,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(color: Color.fromARGB(255, 228, 230, 233)),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                'שאלה $selected מתוך ${widget.questionnaire.length}',
                style: TextStyle(color: const Color(0xFF6E7072), fontSize: 18.sp),
              )),
          Column(
            children: [
               // getQuestionnaireByType(widget.questionnaire.elementAt(index)),
               getQuestionnaireByType(widget.questionnaire.elementAt(selected-1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    visible: selected != 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan),
                      child: const Text(
                        "חזרה",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => onBackClick(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan),
                    child: Text(
                      selected == widget.questionnaire.length
                          ? "סיום שאלון"
                          : "הבא",
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () => selected == widget.questionnaire.length
                        ? onFinishClick()
                        : onNextClick(),
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
    myQController=QuestionController();
    switch (item.type) {
      case QType.checkbox:
        return RadioCheck(item,questionController:myQController);
      case QType.radio:
        return RadioCheck(item,questionController:myQController);
      case QType.freeChoice:
        return FreeChoice(item,questionController:myQController);
      case QType.fillIn:
        return FillIn(item,questionController:myQController);
      case QType.openQ:
        return OpenQuestion(item,questionController:myQController);
      case QType.sort:
      return OrderSelectionWidget(item, questionController: myQController);
        // return Container();
      case QType.sortMatrix:
        return OrderSelectionMatrixWidget(item, questionController: myQController);
    }
  }

  bool onNextClick({bool isLast=false}) {
    if(myQController.isFilled!=null && myQController.isFilled!()) {
      widget.questionnaire
          .elementAt(selected - 1)
          .isFilled = true;

      if (myQController.isCorrect != null) {
        widget.questionnaire
            .elementAt(selected - 1)
            .isCorrect = myQController.isCorrect!();
        debugPrint('iscorrect ${widget.questionnaire
            .elementAt(selected - 1)
            .isCorrect}');
      }
      if (!isLast) {
        setState(() {
          index++;
          selected++;
        });
      }
    }
    else{
      if(myQController.isFilled!=null) {
        CommonFuncs().showMyToast(
          'הינך חייב לענות על השאלה');
        return false;
      }
      // not supposed to get to here for meanwhile
      else {
        //todo change , not allow to go next
        // CommonFuncs().showMyToast(
        //     'בעיה');
        if(!isLast) {
          setState(() {
            index++;
            selected++;
          });
        }
      }
      }
    return true;
  }

  onFinishClick() {
    if (onNextClick(isLast: true)) {
      if (checkAnswers()) {
        QuestionnaireWidget.of(context)?.setInitialDisplay();
        MainPageChild.of(context)?.updateCompleteQuiz(widget.questionnaireId);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return QuestionnaireEndDialog(
                qNum: qNum, correctQNum: correctQNum,);
            });
      }
    }
  }

 bool checkAnswers()
  {
    for(Question q in widget.questionnaire)
    {
      if(q.isCorrect)
      {
        correctQNum++;
      }
      else if(!q.isFilled)
      {
        CommonFuncs().showMyToast(
            'ישנם שאלות שלא מולאו');
        return false;
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
  didChangeDependencies()
  {
    debugPrint('qu didChangeDependencies');
    super.didChangeDependencies();
  }
}

class QuestionController {
   bool Function()? isFilled;
   bool Function()? isCorrect;
}
