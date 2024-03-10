import 'dart:async';

import 'package:eshkolot_offline/ui/custom_widgets/html_data_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_end_dialog.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/installationDataHelper.dart';

class QuestionnaireWidget extends StatefulWidget {
  // final List<Question> questionnaires;
  final Quiz quiz;
  final VoidCallback? onNext;

  const QuestionnaireWidget({super.key, required this.quiz, this.onNext});

  @override
  State<QuestionnaireWidget> createState() => _QuestionnaireWidgetState();

  static _QuestionnaireWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<_QuestionnaireWidgetState>();
}

class _QuestionnaireWidgetState extends State<QuestionnaireWidget>
    with TickerProviderStateMixin {
  late Widget displayWidget;
  late List<Question> questionnaires;
  late TabController _tabController;
  late StreamSubscription stream;

  @override
  void initState() {
    questionnaires = widget.quiz.questionList;
    displayWidget = initialDisplay();
    _tabController = TabController(length: 2, vsync: this);
    stream = InstallationDataHelper().eventBusQuizPage.on().listen((event) {
      widget.quiz.isCompletedCurrentUser = event as bool;
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant QuestionnaireWidget oldWidget) {
    questionnaires = widget.quiz.questionList;
    _tabController.animateTo(0);
    displayWidget = initialDisplay();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _tabController.dispose();
    stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 950.w,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: const Color(0xFFE4E6E9))),
      child: Padding(
        padding:
            EdgeInsets.only(right: 19.w, left: 19.w, top: 32.h, bottom: 20.h),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.create, size: 30.w),
                SizedBox(width: 23.w),
                Expanded(
                    child: Text(widget.quiz.title,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 36.sp))),
                SizedBox(width: 30.w),
                Icon(Icons.access_time_outlined, size: 15.sp),
                SizedBox(width: (7.5).w),
                Text(widget.quiz.time, style: TextStyle(fontSize: 16.sp)),
                //  Spacer(),
                SizedBox(width: 10.w),
                Container(
                    height: 20.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        color: widget.quiz.isCompletedCurrentUser
                            ? colors.lightGreen2ColorApp
                            : colors.lightBlueColorApp,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        widget.quiz.isCompletedCurrentUser ? 'הושלם' : 'בלמידה',
                        //  textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: colors.blackColorApp,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 17.h,
            ),
            if (questionnaires.isNotEmpty && widget.quiz.quizMaterials != '')
              Row(
                children: [
                  Image.asset('assets/images/hand.jpg'),
                  Text("  בשאלון זה מומלץ להעזר בלשונית 'חומרי למידה'",
                      style: TextStyle(fontSize: 18.sp))
                ],
              ),
            if (questionnaires.isNotEmpty && widget.quiz.quizMaterials != '')
              TabBar(
                labelColor: const Color.fromARGB(255, 45, 40, 40),
                unselectedLabelColor: const Color.fromARGB(255, 172, 174, 175),
                indicatorColor: const Color.fromARGB(255, 45, 40, 40),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                indicatorPadding: EdgeInsets.only(bottom: 2.h),
                labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Row(
                      children: [
                        Icon(
                          Icons.create_outlined,
                          size: 22.sp,
                        ),
                        Text('  שאלון ', style: TextStyle(fontSize: 22.sp))
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(
                          Icons.folder_outlined,
                          size: 22.sp,
                        ),
                        Text('  חומרי למידה', style: TextStyle(fontSize: 22.sp))
                      ],
                    ),
                  )
                ],
              ),
            Expanded(
              // height: MediaQuery.of(context).size.height+10000.h,
              child: ClipRect(
                child: questionnaires.isNotEmpty &&
                        widget.quiz.quizMaterials != ''
                    ? TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: <Widget>[displayWidget, quizMaterialWidget()],
                      )
                    : displayWidget,
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }

  initialDisplay() {
    return Column(children: [
      SizedBox(height: 43.h),
      questionnaires.isNotEmpty
          ? Align(
              alignment: Alignment.centerRight,
              child: /*Container(
                height: 40.h,
                width: 171.w,
                decoration: BoxDecoration(
                    color: Color(0xFFF4F4F3),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child:*/
                  Container(
                width: 171.w,
                height: 40.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFF2D2828),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(

                    alignment: Alignment.center,
                    //padding: EdgeInsets.only(left: 45.w,right: 45.w,top: 20.h,bottom: 22.h),
                    textStyle: TextStyle(fontSize: 20.sp, fontFamily: 'RAG-Sans'),
                  ),
                  onPressed: () {
                    setState(() {
                      for (Question question in widget.quiz.questionList) {
                        question.isFilled = false;

                        question.setAllAnswersToFalse();
                      }
                      displayWidget = QuestionnaireTab(quiz: widget.quiz);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(' התחל שאלון ',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white, /* fontFamily: 'RAG-Sans'*/
                          )),
                      Icon(
                        Icons.arrow_forward,
                        size: 15.sp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            )
          : Text('לא נמצאו שאלונים', style: TextStyle(fontSize: 22.h)),
    ]);
  }

  setInitialDisplay() {
    setState(() {
      displayWidget = initialDisplay();
    });
  }

  setEndQuestionnaire(
      {required List<bool> statusAnswers,
      required grade1,
      required grade2,
      required qID,
      required displayAnswersWidget}) {
    setState(() {
      displayWidget = QuestionnaireEndDialog(
        statusAnswers: statusAnswers /*,correctQNum: correctQNum, qNum: qNum*/,
        grade1: grade1,
        grade2: grade2,
        qID: qID,
        displayAnswersWidget: displayAnswersWidget,
        onNext: widget.onNext,
      );
    });
  }

  quizMaterialWidget() {
    return SingleChildScrollView(
        child: Column(
      children: [
        // AudioWidget(path: ''),
        HtmlDataWidget(widget.quiz.quizMaterials, quizId: widget.quiz.id),
      ],
    ));
  }
}
