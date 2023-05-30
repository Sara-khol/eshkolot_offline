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
    //displayWidget=getQuestionnaireByType(widget.questionnaire.elementAt(0));
    debugPrint(widget.questionnaire.elementAt(0).question);
    super.initState();
  }

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
    return Column(
      children: <Widget>[
        SizedBox(height: 60.h,),
        Container(
          height: 45.h,
          //width: 45.w,
          child: Row(
            children: [
              for(int i = 1; i <= widget.questionnaire.length; i++)...[
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: i == selected ? Color((0xFF5956DA)) : Colors.transparent,
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        alignment: Alignment.center,
                        foregroundColor: i == selected
                            ? Colors.white
                            : Color((0xFF2D2828)),
                        textStyle: TextStyle(fontSize: 18.w),
                      ),
                      onPressed: () {
                        debugPrint('selected question:  $i');
                        debugPrint('current question: $selected');
                        setState(() {
                          selected = i;
                          index=i-1;
                        });
                        debugPrint('question $selected selected');
                      },
                      child: Text(
                          '$i', style: TextStyle(fontSize: 18.w)),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 15.h,bottom: 30.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.square, color: Color(0xFF5956DA), size: 15.sp,),
              Text(' הנוכחי', style: TextStyle(fontSize: 16.w)),
              SizedBox(width: 11.w,),
              Icon(Icons.square, color: Color(0xFFACAEAF), size: 15.sp),
              Text(' ביקורת', style: TextStyle(fontSize: 16.w)),
              SizedBox(width: 11.w,),
              Icon(Icons.square, color: Color(0xFF62FFB8), size: 15.sp),
              Text(' נענו', style: TextStyle(fontSize: 16.w)),
              SizedBox(width: 11.w,),
              Icon(Icons.square, color: Color(0xFFF97575), size: 15.sp),
              Text(' לא נכון', style: TextStyle(fontSize: 16.w)),

              const Spacer(),

              Container(
                height: 20.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Color(0xFFF4F4F3),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    alignment: Alignment.center,
                    foregroundColor: Color(0xFF2D2828),
                    textStyle: TextStyle(
                        fontSize: 12.w,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text('סקור שאלה', style: TextStyle(fontSize: 12.w)),
                      Icon(Icons.arrow_forward,size: 10.sp,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

        Divider(color: Color.fromARGB(255, 228, 230, 233)),

        Align(
          alignment: Alignment.centerRight,
          child: Text('שאלה $selected מתוך ${widget.questionnaire.length}',
            style: TextStyle(color: Color(0xFF6E7072),fontSize: 18.sp),
          )
        ),

        Column(
          children: [
            getQuestionnaireByType(widget.questionnaire.elementAt(index)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible:selected!=1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                    child: const Text(
                      "חזרה",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => onBackClick(),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  child: Text(
                    selected == widget.questionnaire.length?
                    "סיום שאלון":
                    "הבא",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => selected == widget.questionnaire.length? onFinishClick() :onNextClick(),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  onNextClick() {
    debugPrint('next click');
    // buttonCarouselController.nextPage(
    //     duration: const Duration(milliseconds: 300), curve: Curves.linear);
    setState(() {
      index++;
      selected++;
    });
  }

  onFinishClick(){
    //TODO:
  }

  onBackClick() {
    // buttonCarouselController.previousPage(
    //     duration: const Duration(milliseconds: 300), curve: Curves.linear);
    setState(() {
      index--;
      selected--;
    });
  }
}
