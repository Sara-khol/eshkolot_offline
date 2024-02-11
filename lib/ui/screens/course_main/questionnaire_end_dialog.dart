import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/my_colors.dart';

class QuestionnaireEndDialog extends StatefulWidget {
  const QuestionnaireEndDialog(
      {super.key,
      required this.statusAnswers,
      required this.grade1,
      required this.grade2,
      required this.qID,
      required this.displayAnswersWidget});

  // final int correctQNum;
  // final int qNum;
  final int grade1;
  final int grade2;
  final int qID;
  final List<Widget> displayAnswersWidget;
  final List<bool> statusAnswers;

  @override
  State<QuestionnaireEndDialog> createState() => _QuestionnaireEndDialogState();
}

class _QuestionnaireEndDialogState extends State<QuestionnaireEndDialog> {
  late num grade;
  late int statusGrade;
  late int numCorrectAnswers;
  late int numQ;

  @override
  void initState() {
    numQ = widget.statusAnswers.length;
    numCorrectAnswers = widget.statusAnswers
        .where((element) => element == true)
        .toList()
        .length;
    grade =
        numCorrectAnswers == 0 ? 0 : ((numCorrectAnswers / numQ) * 100).round();
    statusGrade = grade < widget.grade1
        ? 1
        : grade > widget.grade2
            ? 3
            : 2;
    saveUserGrade(grade);
    super.initState();
  }

  bool showAnswers = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              /*top: 45.h,*/
              right: 70.w,
              left: 70.w),
          child: Column(
            children: [
              Text(
                'תוצאות השאלון',
                style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w600),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 55.h,
              ),
              Text(' הצלחת $numCorrectAnswers מתוך $numQ  שאלות '),
              SizedBox(
                height: 35.h,
              ),
              Text(' הציון שלך הוא %$grade',
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600)),
              SizedBox(
                height: 40.h,
              ),
              Image.asset('assets/images/grade_$statusGrade.png',
                  height: 253.h),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        backgroundColor: blueColorApp,
                      ),
                      onPressed: () {
                        setState(() {
                          showAnswers = true;
                        });
                      },
                      child: Text(
                        'הצג שאלות',
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      )),
                  SizedBox(
                    width: 25.w,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: blueColorApp),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          backgroundColor: Colors.white),
                      onPressed: () {
                        QuestionnaireWidget.of(context)?.setInitialDisplay();
                      },
                      child: Text(
                        'התחל שאלון מחדש',
                        style: TextStyle(color: blueColorApp, fontSize: 20.sp),
                      ))
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Visibility(
                visible: showAnswers,
                child: Wrap(
                  children: [
                    for (int i = 1; i <= numQ; i++) ...[
                      Container(
                        width: 65.w,
                        margin: EdgeInsets.only(left: 10.w),
                        padding: EdgeInsets.all(20.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: widget.statusAnswers[i - 1]
                              ? Colors.greenAccent.withOpacity(0.7)
                              : Colors.redAccent.withOpacity(0.7),
                        ),
                        child: Text('$i',
                            style: TextStyle(
                                fontSize: 22.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center),
                      )
                    ]
                  ],
                ),
              ),
              Visibility(
                  visible: showAnswers,
                  child: Container(
                    margin: EdgeInsets.only(top:20.h),
                    child: Column(
                      children: widget.displayAnswersWidget,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  saveUserGrade(num grade) async {
    UserGrade userGrade =
        UserGrade(quizId: widget.qID, percentage: grade as int);
    await IsarService().updateGrade(userGrade);
  }
}
