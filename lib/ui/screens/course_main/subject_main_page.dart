import 'dart:async';

import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/ui/screens/course_main/lesson_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../services/installationDataHelper.dart';
import 'main_page_child.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;

class SubjectMainPage extends StatefulWidget {
  const SubjectMainPage(
      {super.key,
      required this.subject,
      required this.subjectIndex,
      required this.onNext});

  final Subject subject;
  final int subjectIndex;
  final VoidCallback? onNext;

  @override
  State<SubjectMainPage> createState() => _SubjectMainPageState();
}

class _SubjectMainPageState extends State<SubjectMainPage> {
//    late int totalSteps=widget.course.subjects.first.lessons.length+1;
  late int totalSteps;
  late int currentStep;
  late Subject currentSubject;

  late var currentMainChild;
  late StreamSubscription stream;


  @override
  void initState() {
    currentSubject=widget.subject;
    setSteps();
   stream= InstallationDataHelper().eventBusSubjectPage.on().listen((event) {
      Subject subject=event as Subject;
       currentSubject=subject;
       if(mounted) {
         setState(() {});
       }
    });
    super.initState();
    //bodyWidget=mainWidget();
  }

  @override
  void didUpdateWidget(covariant SubjectMainPage oldWidget) {
    if (oldWidget.subject != widget.subject) {
      currentSubject=widget.subject;
      setSteps();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Directionality(
        textDirection: TextDirection.rtl,
        child: mainWidget(),
      ),
      SizedBox(height: 14.h),
      Visibility(
        visible: widget.onNext != null,
        child: Padding(
          padding: EdgeInsets.only(left: 242.w),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 40.h,
              width: 175.w,
              decoration:  BoxDecoration(
                color: Color( MainPageChild.of(context)!.widget.knowledgeColor != -1
                    ? MainPageChild.of(context)!.widget.knowledgeColor
                    : 0xFF32D489),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  alignment: Alignment.center,
                  foregroundColor: Colors.white,
                  //padding: EdgeInsets.only(left: 45.w,right: 45.w,),
                  textStyle:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  widget.onNext!();
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '    לנושא הבא ',
                        style:
                            TextStyle(fontSize: 18.sp, fontFamily: 'RAG-Sans'),
                        textAlign: TextAlign.center,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 15.sp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget mainWidget() {
    return Container(
        width: 950.w,
        height: 755.h,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE4E6E9)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    top: 30.h, bottom: 65.h, /*left: 65.w,*/ right: 25.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.bookOpen, size: 27.sp),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 8.w),
                              child: Text(
                                currentSubject.name,
                                style: TextStyle(
                                  color: colors.blackColorApp,
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 15,
                              ),
                              SizedBox(width: (7.5).w),
                              Text(currentSubject.time,
                                  style: TextStyle( color: colors.blackColorApp,fontSize: 16.sp))
                            ],
                          ),
                          SizedBox(width: 10.w),
                          Container(
                              height: 20.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                  color: currentSubject.isCompletedCurrentUser
                                      ? colors.lightGreen2ColorApp
                                      : colors.lightBlueColorApp,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  currentSubject.isCompletedCurrentUser
                                      ? 'הושלם'
                                      : 'בלמידה',
                                  //  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: colors.blackColorApp,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                          SizedBox(
                            width: 18.w,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.h, bottom: 40.h, right: 42.w),
                        child: Text(
                          'בנושא זה ${currentSubject.lessons.length} שיעורים, בהצלחה בלמידה!',
                          style: TextStyle( color: colors.blackColorApp,
                              fontSize: 20.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 6, right: 42.w),
                        child: Row(
                          children: [
                            Text(
                              '${(currentStep / totalSteps * 100).toInt()}% הושלמו',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFACAEAF)),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              '$currentStep/$totalSteps שלבים',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFFACAEAF)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 42.h,
                      ),
                      ListView.builder(
                        padding: EdgeInsets.only(left: 65.w),
                        itemCount: currentSubject.lessons.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Lesson currentLesson =
                              currentSubject.lessons.elementAt(index);
                          return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 31.h,
                                  width: 31.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xFF2D2828), width: 1.w),
                                  ),
                                  child: Center(
                                      child: Text("${index + 1}.",
                                          style: TextStyle(
                                              color: colors.blackColorApp,
                                              fontSize: 16.sp,
                                              fontFamily: 'RAG-Sans'))),
                                ),
                                SizedBox(width: 30.w),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Divider(
                                        indent: 50.w,
                                        height: 0,
                                        color: colors.grey2ColorApp),
                                    SizedBox(
                                      height: 37.h,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          progressIcon(
                                              index,
                                              true,
                                              // widget.subject.lessons
                                              //     .elementAt(index)
                                              //     .isCompletedCurrentUser,
                                              currentLesson
                                                  .isCompletedCurrentUser,
                                              currentLesson
                                                      .questionnaire.isEmpty &&
                                                  currentSubject.questionnaire
                                                      .isEmpty &&
                                                  index ==
                                                      currentSubject.lessons
                                                              .length -
                                                          1),
                                          SizedBox(
                                            width: 35.w,
                                          ),
                                          Icon(
                                            Icons.videocam_outlined,
                                            size: 13.sp,
                                          ),
                                          SizedBox(width: 14.h),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                  style: TextButton.styleFrom(
                                                       padding: EdgeInsets.only(right: 5.w,left: 5.w,top: 5.h,bottom: 5.h),
                                                      minimumSize: Size.zero,
                                                     // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                  ),
                                                  onPressed: () => goToLesson(index),
                                                child:Text( currentSubject.lessons
                                                    .elementAt(index)
                                                    .name,
                                                    style: TextStyle(
                                                      color: colors.blackColorApp,
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w600,
                                                    ))),
                                            ),
                                          ),
                                       //   const Spacer(),
                                          Container(
                                            height: 20.h,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFF4F4F3),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: TextButton(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '  לצפיה בשיעור ',
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: colors.blackColorApp),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    size: 10.sp,
                                                    color:  colors.blackColorApp,
                                                  )
                                                ],
                                              ),
                                        onPressed: () => goToLesson(index),

                                    ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (currentLesson.questionnaire.isNotEmpty)
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: currentLesson
                                              .questionnaire.length,
                                          itemBuilder: (ctx, qIndex) {
                                            return displayQuestion(
                                                subjectIndex: index,
                                                qIndex: qIndex,
                                                isCompleted: currentLesson
                                                    .questionnaire
                                                    .elementAt(qIndex)
                                                    .isCompletedCurrentUser,
                                                name: currentLesson
                                                    .questionnaire
                                                    .elementAt(qIndex)
                                                    .title,
                                                isLast: qIndex ==
                                                        currentLesson
                                                                .questionnaire
                                                                .length -
                                                            1 &&
                                                    index ==
                                                        currentSubject.lessons
                                                                .length -
                                                            1 &&
                                                    currentSubject.questionnaire
                                                        .isEmpty,
                                                onPress: () {
                                                  setState(() {

                                                    currentMainChild
                                                            ?.lessonPickedIndex =
                                                        index;
                                                    currentMainChild
                                                        ?.subjectPickedIndex =
                                                        widget.subjectIndex;
                                                    currentMainChild
                                                            ?.lastSubjectPickedIndex =
                                                        widget.subjectIndex;
                                                    currentMainChild
                                                        ?.questionPickedIndex = qIndex;
                                                    MainPageChild.of(context)
                                                            ?.bodyWidget =
                                                        QuestionnaireWidget(
                                                            quiz: currentLesson
                                                                .questionnaire
                                                                .elementAt(
                                                                    qIndex));
                                                  });
                                                });
                                          }),
                                    if (index ==
                                        currentSubject.lessons.length - 1)
                                      Divider(
                                          indent: 50.w,
                                          height: 0,
                                          color: colors.grey2ColorApp)
                                  ],
                                )),
                              ]);
                        },
                      ),
                      if (currentSubject.questionnaire.isNotEmpty)
                        ListView.builder(
                            padding: EdgeInsets.only(right: 61.w, left: 66.w),
                            itemCount: currentSubject.questionnaire.length,
                            shrinkWrap: true,
                            itemBuilder: (context, qIndex) {
                              return displayQuestion(
                                  subjectIndex: 0,
                                  isCompleted: currentSubject.questionnaire
                                      .elementAt(qIndex)
                                      .isCompletedCurrentUser,
                                  qIndex: qIndex,
                                  name: currentSubject.questionnaire
                                      .elementAt(qIndex)
                                      .title,
                                  isLast: qIndex ==
                                      currentSubject.questionnaire.length - 1,
                                  onPress: () {
                                    setState(() {
                                      currentMainChild?.lessonPickedIndex = -1;
                                      currentMainChild?.lastSubjectPickedIndex =
                                          widget.subjectIndex;
                                      MainPageChild.of(context)?.bodyWidget =
                                          QuestionnaireWidget(
                                              quiz: currentSubject.questionnaire
                                                  .elementAt(qIndex));
                                    });
                                  });
                            })
                    ]))));
  }

  progressIcon(int index, bool isLesson, bool isCompleted, bool isLast) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        VerticalDivider(
            color: isCompleted ? const Color(0xFF62FFB8) : colors.grey2ColorApp,
            thickness: 3.w,
            indent: index == 0 && isLesson ? 25.h : null,
            endIndent: isLast ? 20.h : null),
        isCompleted
            ? Icon(
                Icons.check_circle,
                color: const Color(0xFF62FFB8),
                size: 20.sp,
              )
            : Container(
                height: 18.h,
                width: 18.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.grey2ColorApp, width: 3.w),
                    color: const Color(0xFFFAFAFA)),
              ),

      ],
    );
  }

  displayQuestion(
      {required int subjectIndex,
      required int qIndex,
      required String name,
      required bool isCompleted,
      required bool isLast,
      required VoidCallback onPress}) {
    return SizedBox(
      height: 37.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          progressIcon(subjectIndex, false, isCompleted, isLast),
          SizedBox(
            width: 35.w,
          ),
          Icon(
            Icons.create_outlined,
            size: 13.sp,
          ),
          SizedBox(width: 14.h),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){
                  onPress();
                },
               style: TextButton.styleFrom(
              padding: EdgeInsets.only(right: 5.w,left: 5.w,top: 5.h,bottom: 5.h),
                      minimumSize: Size.zero,
              ),
                child: Text(
                  name,
                  style: TextStyle( color: colors.blackColorApp,fontSize: 16.sp),
                )),
            ),
          ),
         // const Spacer(),
          Container(
            height: 20.h,
            decoration: const BoxDecoration(
              color: Color(0xFFF4F4F3),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextButton(
              child: Row(
                children: [
                  Text(
                    '  לתרגול ',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      color: colors.blackColorApp),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 10.sp,
                      color: colors.blackColorApp
                  )
                ],
              ),
              onPressed: () {
                onPress();
              },
            ),
          ),
        ],
      ),
    );
  }

  // backToSubject(Subject subject) {
  //   MainPageChild.of(context)?.bodyWidget = SubjectMainPage(subject: subject);
  // }

  setSteps() async {
    totalSteps = 0;
    currentStep = 0;
    // totalSteps+=subject.lessons.length;
    for (Lesson lesson in currentSubject.lessons) {
      totalSteps++;
      if (lesson.isCompletedCurrentUser) {
        currentStep++;
      }
      totalSteps += lesson.questionnaire.length;
      currentStep += lesson.questionnaire
          .where((item) => item.isCompletedCurrentUser == true)
          .length;
    }
    totalSteps += currentSubject.questionnaire.length;
    currentStep += currentSubject.questionnaire
        .where((item) => item.isCompletedCurrentUser == true)
        .length;

    //  progressPercent = ((currentStep / totalSteps) * 100).round();
  }

  goToLesson(int index)
  {
    setState(() {
      debugPrint(currentSubject.lessons
          .elementAt(index)
          .name);
      currentMainChild
          ?.lessonPickedIndex =
          index;
      currentMainChild
          ?.lastSubjectPickedIndex =
          widget.subjectIndex;
      currentMainChild?.bodyWidget = LessonWidget(
          updateComplete: currentMainChild
              .updateCompleteLesson,
          lesson: currentSubject.lessons
              .elementAt(index),
          onNext: index + 1 <
              currentSubject
                  .lessons
                  .length
              ? () => currentMainChild.goToNextLesson(
              currentSubject,
              widget
                  .subjectIndex,
              currentSubject
                  .lessons
                  .elementAt(index + 1),
              index + 1)
              : null);
    });
  }

  @override
  void didChangeDependencies() {
    currentMainChild = MainPageChild.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }
}
