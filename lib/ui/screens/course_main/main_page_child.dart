import 'dart:async';

import 'package:eshkolot_offline/models/quiz.dart';
import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/subject_main_page.dart';
import 'package:eshkolot_offline/ui/screens/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../models/course.dart';
import '../../../models/lesson.dart';
import '../../../models/subject.dart';
import '../../../services/installationDataHelper.dart';
import 'lesson_widget.dart';
import 'course_main_page.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;

class MainPageChild extends StatefulWidget {
  const MainPageChild(
      {super.key, required this.course, required this.knowledgeColor, this.isContinue = 0,
        this.lessonPickedIndex = -1, this.questionPickedIndex = -1, this.subjectPickedIndex = -1, required this.knowLedgeId});

  final Course course;
  final int knowledgeColor;
  final int isContinue;
  final int lessonPickedIndex;
  final int questionPickedIndex;
  final int subjectPickedIndex;
  final int knowLedgeId;


  static _MainPageChildState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainPageChildState>();

  @override
  State<MainPageChild> createState() => _MainPageChildState();
}

class _MainPageChildState extends State<MainPageChild> {
  late StreamSubscription stream;
  late ValueNotifier<Widget> _bodyWidget;
  Widget? _lastBodyWidget;

  int lessonPickedIndex = -1;
  int subjectPickedIndex = -1;
  int questionPickedIndex = -1;
  int lastSubjectPickedIndex = -1;
  int lastQuestionPickedIndex = -1;
  Course? lastCourse;

  late int totalSteps;
  late int currentStep;
  late int progressPercent;
  late bool doShowNext = false;
  late String nextButtonText = '';
  final CoursePageController myController = CoursePageController();
  UserCourse? userCourse;
  late Course _currentCourse; // Variable to hold the current course value

  set bodyWidget(Widget value) => setState(() => _bodyWidget.value = value);

  @override
  void initState() {
    super.initState();
    _currentCourse = widget.course;

    userCourse = IsarService().getUserCourseData(_currentCourse.id);

    if (widget.isContinue > 0) {
      switch (widget.isContinue) {
        case 1:
          {
            lessonPickedIndex = widget.lessonPickedIndex;
            subjectPickedIndex = widget.subjectPickedIndex;
            _bodyWidget = ValueNotifier(
                LessonWidget(lesson: widget.course.lastLesson!,
                  onNext: widget.course.userCourse!.lessonIndex + 1 <
                      widget.course.lastSubject!.lessons.length
                      ? () =>
                      goToNextLesson(
                          widget.course.lastSubject!,
                          widget.course.userCourse!.subjectIndex,
                          widget.course.lastSubject!.lessons.elementAt(
                              widget.course.userCourse!.lessonIndex + 1),
                          widget.course.userCourse!.lessonIndex + 1)
                      : null,
                  updateComplete:updateCompleteLesson,));

          }
          break;
        case 2:
          {
          questionPickedIndex = widget.course.userCourse!.questionIndex;
           subjectPickedIndex =
               widget.course.userCourse!.subjectIndex;
          lessonPickedIndex =
              widget.course.userCourse!.lessonIndex;
            _bodyWidget = ValueNotifier( QuestionnaireWidget(
              quiz: widget.course.lastQuestionnaire!));
          }
          break;
      }
    }
    else {
      _bodyWidget = ValueNotifier(
          CourseMainPage(course: _currentCourse, controller: myController));
    }
    setSteps();
    _bodyWidget.addListener(doTaskWhenNotified);
    if (widget.isContinue == 0) {
      setNextData();
    }
    MainPage
        .of(context)
        ?.setUpdate = saveLastUserPosition;

    stream = InstallationDataHelper()
        .eventBusMainPageChild
        .on()
        .listen((event) async {
      debugPrint('eventttt');
      _currentCourse = (await IsarService().getCourseById(_currentCourse.id))!;
      if (_bodyWidget.value is SubjectMainPage) {
        InstallationDataHelper()
            .eventBusSubjectPage
            .fire(_currentCourse.subjects.elementAt(subjectPickedIndex));
      } else if (_bodyWidget.value is LessonWidget) {
        _bodyWidget.value = LessonWidget(
          lesson: _currentCourse.subjects
              .elementAt(subjectPickedIndex)
              .lessons
              .elementAt(lessonPickedIndex),
          updateComplete: updateCompleteLesson,
          onNext: lessonPickedIndex + 1 <
              _currentCourse.subjects
                  .elementAt(subjectPickedIndex)
                  .lessons
                  .length
              ? () =>
              goToNextLesson(
                  _currentCourse.subjects.elementAt(subjectPickedIndex),
                  subjectPickedIndex,
                  _currentCourse.subjects
                      .elementAt(subjectPickedIndex)
                      .lessons
                      .elementAt(lessonPickedIndex + 1),
                  lessonPickedIndex + 1)
              : null,
        );
      } else if (_bodyWidget.value is QuestionnaireWidget) {
        Quiz currentQuiz;
        if (subjectPickedIndex != -1) {
          Subject currentSubject =
          _currentCourse.subjects.elementAt(subjectPickedIndex);
          if (lessonPickedIndex != -1) {
            currentQuiz = currentSubject.lessons
                .elementAt(lessonPickedIndex)
                .questionnaire
                .elementAt(questionPickedIndex);
          } else
            //quiz of subject
              {
            currentQuiz =
                currentSubject.questionnaire.elementAt(questionPickedIndex);
          }
        } else {
          currentQuiz =
              _currentCourse.questionnaires.elementAt(questionPickedIndex);
        }
        InstallationDataHelper()
            .eventBusQuizPage
            .fire(currentQuiz.isCompletedCurrentUser);
        //  _bodyWidget.value=QuestionnaireWidget(quiz: currentQuiz);
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

//  List<String> fileNames = [];

  void doTaskWhenNotified() async {
    await saveLastUserPosition(refresh: true);
    if (widget.isContinue == 0) {
      setNextData(refresh: true);
    }
  }

  @override
  void didUpdateWidget(covariant MainPageChild oldWidget) {
    debugPrint('didUpdateWidget uuu');
    if (oldWidget.course != widget.course) {
      // lastCourse = oldWidget.course;
      lastCourse = _currentCourse;
      _currentCourse = widget.course;
      setSteps();
    }
    _bodyWidget.value =
        CourseMainPage(course: _currentCourse, controller: myController);
    userCourse = IsarService().getUserCourseData(_currentCourse.id);

    super.didUpdateWidget(oldWidget);
  }

  setSteps() async {
    totalSteps = 0;
    currentStep = 0;
    for (Subject subject in _currentCourse.subjects) {
      // totalSteps+=subject.lessons.length;
      for (Lesson lesson in subject.lessons) {
        totalSteps++;
        if (lesson.isCompletedCurrentUser) {
          currentStep++;
        }
        totalSteps += lesson.questionnaire.length;
        currentStep += lesson.questionnaire
            .where((item) => item.isCompletedCurrentUser == true)
            .length;
      }
      totalSteps += subject.questionnaire.length;
      currentStep += subject.questionnaire
          .where((item) => item.isCompletedCurrentUser == true)
          .length;
    }
    totalSteps += _currentCourse.questionnaires.length;
    currentStep += _currentCourse.questionnaires
        .where((item) => item.isCompletedCurrentUser == true)
        .length;
    progressPercent = ((currentStep / totalSteps) * 100).round();
    // progressPercent = userCourse!.progressPercent;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      menuWidget(),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            progressBar(),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 60.h, right: 138.w),
                  child: _bodyWidget.value,
                )),
          ],
        ),
      )
    ]);
  }

  Widget progressBar() {
    return Container(
      height: 74.h,
      decoration:
      BoxDecoration(border: Border.all(color: colors.grey2ColorApp)),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 80.w, left: 86.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.h, right: 13.w),
                    child: Row(
                      children: [
                        Text(
                          '$progressPercent% הושלמו',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF62FFB8)),
                          // Color(widget.course.knowledge.value??widget.course.knowledge.value!.color)),
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        Text(
                          '$currentStep/$totalSteps שלבים',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: colors.grey1ColorApp),
                        )
                      ],
                    ),
                  ),
                  LinearPercentIndicator(
                    /* width: 765.w,*/
                    backgroundColor: const Color(0xFF62FFB8),
                    progressColor: colors.lightGreen1ColorApp,
                    lineHeight: 5,
                    percent: /*userCourse!.progressPercent*/
                    (progressPercent >= 100 ? 100 : progressPercent) / 100,
                    isRTL: true,
                  ),
                ],
              ),
            ),
          ),
          Container(
              width: 395.w,
              height: 74.h,
              decoration: BoxDecoration(
                  border: Border.all(color: colors.grey2ColorApp)),
              child: nextButton())
        ],
      ),
    );
  }

  Widget menuWidget() {
    return SizedBox(
      width: 350.w,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 74.h,
            color: Color(widget.knowledgeColor != -1 ? widget.knowledgeColor:0xFF32D489),
            child: TextButton(
                child: Text(
                  _currentCourse.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  _bodyWidget.value = CourseMainPage(
                      course: _currentCourse, controller: myController);
                }),
          ),

          ///כותרת של הקורס
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _currentCourse.subjects.length,
                                  itemBuilder: (ctx, sIndex) {
                                    Subject currentSubject = _currentCourse
                                        .subjects
                                        .elementAt(sIndex);
                                    return Column(
                                      children: [
                                        subjectTitleDisplay(
                                            currentSubject, sIndex),
                                        Container(
                                            color: colors.lightGrey1ColorApp,
                                            height: 1.h),
                                        Container(
                                            color: colors.lightGrey2ColorApp,
                                            child: Column(children: [
                                              Visibility(
                                                visible:
                                                currentSubject.isTapped,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: currentSubject
                                                      .lessons.length,
                                                  itemBuilder: (ctx, lIndex) {
                                                    Lesson currentLesson =
                                                    currentSubject.lessons
                                                        .elementAt(lIndex);
                                                    return Center(
                                                        child: Column(
                                                          children: [
                                                            lessonOrQuestionnaireItem(
                                                                true,
                                                                currentLesson
                                                                    .isCompletedCurrentUser,
                                                                lIndex == 0,
                                                                currentLesson
                                                                    .questionnaire
                                                                    .isEmpty &&
                                                                    currentSubject
                                                                        .questionnaire
                                                                        .isEmpty &&
                                                                    lIndex ==
                                                                        currentSubject
                                                                            .lessons
                                                                            .length -
                                                                            1,
                                                                lIndex,
                                                                currentLesson
                                                                    .name,
                                                                lessonPickedIndex ==
                                                                    lIndex &&
                                                                    subjectPickedIndex ==
                                                                        sIndex &&
                                                                    _bodyWidget
                                                                        .value
                                                                    is LessonWidget,
                                                                    () {
                                                                  setState(() {
                                                                    lessonPickedIndex =
                                                                        lIndex;
                                                                    subjectPickedIndex =
                                                                        sIndex;
                                                                    questionPickedIndex =
                                                                    -1;
                                                                    _bodyWidget
                                                                        .value =
                                                                        LessonWidget(
                                                                          lesson: currentSubject
                                                                              .lessons
                                                                              .elementAt(
                                                                              lessonPickedIndex),
                                                                          updateComplete:
                                                                          updateCompleteLesson,
                                                                          onNext: lessonPickedIndex +
                                                                              1 <
                                                                              currentSubject
                                                                                  .lessons
                                                                                  .length
                                                                              ? () =>
                                                                              goToNextLesson(
                                                                                  currentSubject,
                                                                                  subjectPickedIndex,
                                                                                  currentSubject
                                                                                      .lessons
                                                                                      .elementAt(
                                                                                      lessonPickedIndex +
                                                                                          1),
                                                                                  lessonPickedIndex +
                                                                                      1)
                                                                              : null,
                                                                        );
                                                                    // nextLesson:currentSubject.lessons.length>lessonPickedIndex+1 ?setNextLesson(currentSubject.lessons,lessonPickedIndex+1):null);
                                                                  });
                                                                }),
                                                            if (currentLesson
                                                                .questionnaire
                                                                .isNotEmpty)
                                                              ListView.builder(
                                                                  shrinkWrap: true,
                                                                  itemCount:
                                                                  currentLesson
                                                                      .questionnaire
                                                                      .length,
                                                                  itemBuilder: (
                                                                      ctx,
                                                                      qIndex) {
                                                                    return lessonOrQuestionnaireItem(
                                                                        false,
                                                                        currentLesson
                                                                            .questionnaire
                                                                            .elementAt(
                                                                            qIndex)
                                                                            .isCompletedCurrentUser,
                                                                        false,
                                                                        // currentLesson.questionnaire.first.questionnaireList.isEmpty &&
                                                                        qIndex ==
                                                                            currentLesson
                                                                                .questionnaire
                                                                                .length -
                                                                                1 &&
                                                                            lIndex ==
                                                                                currentSubject
                                                                                    .lessons
                                                                                    .length -
                                                                                    1 &&
                                                                            currentSubject
                                                                                .questionnaire
                                                                                .isEmpty,
                                                                        lIndex,
                                                                        currentLesson
                                                                            .questionnaire
                                                                            .elementAt(
                                                                            qIndex)
                                                                            .title,
                                                                        lessonPickedIndex ==
                                                                            lIndex &&
                                                                            subjectPickedIndex ==
                                                                                sIndex &&
                                                                            questionPickedIndex ==
                                                                                qIndex &&
                                                                            _bodyWidget
                                                                                .value
                                                                            is QuestionnaireWidget,
                                                                            () =>
                                                                            setState(
                                                                                    () {
                                                                                  lessonPickedIndex =
                                                                                      lIndex;
                                                                                  subjectPickedIndex =
                                                                                      sIndex;
                                                                                  questionPickedIndex =
                                                                                      qIndex;
                                                                                  _bodyWidget
                                                                                      .value =
                                                                                      QuestionnaireWidget(
                                                                                          quiz: currentLesson
                                                                                              .questionnaire
                                                                                              .elementAt(
                                                                                              qIndex));
                                                                                }));
                                                                  })
                                                          ],
                                                        ));
                                                  },
                                                ),
                                              ),
                                              if (currentSubject
                                                  .questionnaire.isNotEmpty)
                                                Visibility(
                                                    visible:
                                                    currentSubject.isTapped,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount:
                                                        currentSubject
                                                            .questionnaire
                                                            .length,
                                                        itemBuilder:
                                                            (ctx, qIndex) {
                                                          return lessonOrQuestionnaireItem(
                                                              false,
                                                              currentSubject
                                                                  .questionnaire
                                                                  .elementAt(
                                                                  qIndex)
                                                                  .isCompletedCurrentUser,
                                                              false,
                                                              qIndex ==
                                                                  currentSubject
                                                                      .questionnaire
                                                                      .length -
                                                                      1,
                                                              -1,
                                                              currentSubject
                                                                  .questionnaire
                                                                  .elementAt(
                                                                  qIndex)
                                                                  .title,
                                                              lessonPickedIndex ==
                                                                  -1 &&
                                                                  subjectPickedIndex ==
                                                                      sIndex &&
                                                                  questionPickedIndex ==
                                                                      qIndex,
                                                                  () =>
                                                                  setState(() {
                                                                    debugPrint(
                                                                        'currentSubject.questionnaire ${currentSubject
                                                                            .questionnaire}');
                                                                    subjectPickedIndex =
                                                                        sIndex;
                                                                    // todo??
                                                                    lastSubjectPickedIndex =
                                                                        sIndex;

                                                                    lessonPickedIndex =
                                                                    -1;
                                                                    questionPickedIndex =
                                                                        qIndex;
                                                                    _bodyWidget
                                                                        .value =
                                                                        QuestionnaireWidget(
                                                                            quiz:
                                                                            currentSubject
                                                                                .questionnaire
                                                                                .elementAt(
                                                                                qIndex));
                                                                  }));
                                                        }))
                                            ])),
                                      ],
                                    );

                                    ///רשימת נושאים בתוך קורס
                                  }),
                              // שאלונים מסכמים של הקורס
                              if (_currentCourse.questionnaires.isNotEmpty)
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                    _currentCourse.questionnaires.length,
                                    itemBuilder: (ctx, qIndex) {
                                      return lessonOrQuestionnaireItem(
                                          false,
                                          _currentCourse.questionnaires
                                              .elementAt(qIndex)
                                              .isCompletedCurrentUser,
                                          qIndex == 0,
                                          qIndex ==
                                              _currentCourse
                                                  .questionnaires.length -
                                                  1,
                                          -1,
                                          _currentCourse.questionnaires
                                              .elementAt(qIndex)
                                              .title,
                                          lessonPickedIndex == -1 &&
                                              subjectPickedIndex == -1 &&
                                              questionPickedIndex == qIndex,
                                              () =>
                                              setState(() {
                                                subjectPickedIndex = -1;
                                                lessonPickedIndex = -1;
                                                questionPickedIndex = qIndex;
                                                _bodyWidget.value =
                                                    QuestionnaireWidget(
                                                        quiz: _currentCourse
                                                            .questionnaires
                                                            .elementAt(qIndex));
                                              })
                                        /* Container(
                                              width: double.infinity,
                                              padding:
                                                  EdgeInsets.only(right: 10.w),
                                              height: 50.h,
                                              child: Center(
                                                  child: Row(children: [
                                                Icon(
                                                  Icons.star_border,
                                                  size: 20.sp,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 14.w,
                                                ),
                                                Text(
                                                    'תרגיל מסכם - קורס ${widget.course.title} ${qIndex + 1}',
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color:
                                                            Color(0xFF2D2828))),
                                              ])))*/
                                      );
                                    })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                dividerSideMenu()
              ],
            ),
          ),
        ],
      ),
    );
  }

  subjectTitleDisplay(Subject currentSubject, int sIndex) {
    return ListTile(
      contentPadding: EdgeInsets.only(right: 20.w),
      title: SizedBox(
        width: double.infinity,
        // color: Colors.transparent,
        child: Row(
          children: [
            statusIconSubjectWidget(currentSubject),
            SizedBox(
              width: 20.w,
            ),
            Image.asset('assets/images/book_icon.png'),
            SizedBox(
              width: 13.w,
            ),
            Expanded(
              child: Text(currentSubject.name,
                  //overflow: TextOverflow.ellipsis,
                  //softWrap: false,
                  style:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp)),
            ),
            // Spacer(),
            const Icon(Icons.arrow_drop_down_sharp)
          ],
        ),
      ),
      mouseCursor: SystemMouseCursors.click,
      textColor: const Color(0xFF2D2828),
      onTap: () {
        setState(() {
          currentSubject.isTapped = !currentSubject.isTapped;
          lastSubjectPickedIndex = subjectPickedIndex;
          subjectPickedIndex = sIndex;

          lastQuestionPickedIndex = questionPickedIndex;
          questionPickedIndex = -1;

          _bodyWidget.value = SubjectMainPage(
            subjectIndex: subjectPickedIndex,
            subject: currentSubject,
            onNext: subjectPickedIndex + 1 < _currentCourse.subjects.length
                ? () =>
                goToNextSubject(
                    _currentCourse.subjects.elementAt(subjectPickedIndex + 1),
                    subjectPickedIndex + 1)
                : null,
          );
        });
      },
    );
  }

  statusIconSubjectWidget(Subject currentSubject) {
    return currentSubject.isCompletedCurrentUser
        ? Icon(Icons.check_circle,
        color: colors.lightGreen1ColorApp, size: 22.sp)
        : currentSubject.lessons
        .any((lesson) => lesson.isCompletedCurrentUser) ||
        currentSubject.lessons.any((lesson) =>
        lesson.isCompletedCurrentUser ||
            lesson.questionnaire
                .any((q) => q.isCompletedCurrentUser)) ||
        currentSubject.questionnaire
            .any((q) => q.isCompletedCurrentUser)
        ? Image.asset('assets/images/procces_circle.png')
        : Icon(Icons.circle_outlined,
        color: colors.grey2ColorApp, size: 22.sp);
  }

  lessonOrQuestionnaireItem(bool isLesson,
      bool isLessonCompleted,
      bool isFirst,
      bool isLastLesson,
      int lIndex,
      String name,
      bool isSelect,
      VoidCallback onPress) {
    //todo remove sizebox because text can be long and there is no space,
    //but when doing that can not see VerticalDivider in stack
    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          SizedBox(width: 25.w),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              VerticalDivider(
                  color: isLessonCompleted
                      ? colors.lightGreen1ColorApp
                      : colors.grey2ColorApp,
                  thickness: 3.w,
                  indent: /*lIndex == 0 && isLesson*/ isFirst ? 25.h : null,
                  endIndent: isLastLesson ? 20.h : null),
              //currentSubject.lessons.isNotEmpty &&
              isLessonCompleted
                  ? Icon(
                Icons.check_circle,
                color: colors.lightGreen1ColorApp,
                size: 20.sp,
              )
                  : circleNotCompletedIcon()
            ],
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: Material(
              child: Container(
                margin: EdgeInsets.only(left: 20.w),
                padding: EdgeInsets.only(right: 20.w,left: 7.w,top:7.h,bottom: 4.h ),
                //  dense: true,
                 // visualDensity: const VisualDensity(vertical: -4),
                  decoration:BoxDecoration(color:
                  isSelect ? colors.grey2ColorApp : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0))  ,

                 // contentPadding:
                  //EdgeInsets.only(right: 20.h, /*bottom: 20.h, */left: 20.h),
                  // hoverColor: colors.grey2ColorApp,
                  child: GestureDetector(
                    onTap: onPress,
                    child: Row(
                      children: [
                        Icon(
                          isLesson
                              ? Icons.videocam_outlined
                              : lIndex == -1
                              ? Icons.star_outline
                              : Icons.create_outlined,
                          size: 22.sp,
                          color: Colors.black,
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Text(name,
                              style: TextStyle(
                                height: 1,
                                  fontWeight: isLesson
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  fontSize: 16.sp)),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  circleNotCompletedIcon() {
    return Container(
      height: 18.h,
      width: 18.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colors.grey2ColorApp, width: 3.w),
          color: const Color(0xFFFAFAFA)),
    );
  }

  dividerSideMenu() {
    return SizedBox(
        width: 15.w,
        height: double.infinity,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Container(width: 1.h, color: colors.grey2ColorApp)));
  }

  Widget nextButton() {
    return Visibility(
      visible: doShowNext,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 175.w,
            margin: EdgeInsets.only(left: 40.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color:  Color(widget.knowledgeColor != -1 ? widget.knowledgeColor:0xFF32D489),
            ),
            child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nextButtonText,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 15.sp,
                    )
                  ],
                ),
                onPressed: () {
                  //  setState(() {
                  //  int nextS=subjectPickedIndex+1;
                  if (_bodyWidget.value is LessonWidget) {
                    Subject mySubject =
                    _currentCourse.subjects.elementAt(subjectPickedIndex);
                    lessonPickedIndex = lessonPickedIndex + 1;
                    _bodyWidget.value = LessonWidget(
                      lesson: mySubject.lessons.elementAt(lessonPickedIndex),
                      updateComplete: updateCompleteLesson,
                      onNext: lessonPickedIndex + 1 < mySubject.lessons.length
                          ? () =>
                          goToNextLesson(
                              mySubject,
                              subjectPickedIndex,
                              mySubject.lessons
                                  .elementAt(lessonPickedIndex + 1),
                              lessonPickedIndex + 1)
                          : null,
                    );
                  } else {
                    {
                      lastSubjectPickedIndex = subjectPickedIndex;
                      if (_bodyWidget.value is SubjectMainPage) {
                        subjectPickedIndex++;
                      } else //courseMainPage - go to first subject
                          {
                        subjectPickedIndex = 0;
                      }
                      _bodyWidget.value = SubjectMainPage(
                          subjectIndex: subjectPickedIndex,
                          subject: _currentCourse.subjects
                              .elementAt(subjectPickedIndex),
                          onNext: subjectPickedIndex + 1 <
                              _currentCourse.subjects.length
                              ? () =>
                              goToNextSubject(
                                  _currentCourse.subjects
                                      .elementAt(subjectPickedIndex + 1),
                                  subjectPickedIndex + 1)
                              : null);
                    }
                  }
                }),
          ),
        ],
      ),
    );
  }

  saveLastUserPosition({bool refresh = false}) async {
    debugPrint('saveLastUserPosition');

    if (_lastBodyWidget != null) {
      if ((_bodyWidget.value is! QuestionnaireWidget &&
          _bodyWidget.value is! LessonWidget) ||
          !refresh) {
        if (_lastBodyWidget is QuestionnaireWidget ||
            _lastBodyWidget is LessonWidget) {
          Course course = lastCourse != null ? lastCourse! : _currentCourse;
          int saveSubjectIndex;
          if (_lastBodyWidget is LessonWidget ||
              _bodyWidget.value is! SubjectMainPage) {
            saveSubjectIndex =
            lastSubjectPickedIndex != -1 /*|| lastQuestionPickedIndex!=-1*/
                ? lastSubjectPickedIndex
                : subjectPickedIndex;

            debugPrint('111 saveSubjectIndex $saveSubjectIndex');
          } else {
            saveSubjectIndex = lastSubjectPickedIndex;
            debugPrint('222 saveSubjectIndex $saveSubjectIndex');
          }

          int saveQIndex = lastQuestionPickedIndex != -1
              ? lastQuestionPickedIndex
              : questionPickedIndex;
          debugPrint(
              'subjectPickedIndex: $subjectPickedIndex lessonPickedIndex: $lessonPickedIndex '
                  'saveSubjectIndex: $saveSubjectIndex');
          int qId = -1;
          if (_lastBodyWidget is QuestionnaireWidget) {
            debugPrint('questionPickedIndex: $questionPickedIndex');
            debugPrint('saveQIndex: $saveQIndex');
            if (saveSubjectIndex == -1 /*|| questionPickedIndex==-1*/) {
              qId = course.questionnaires
                  .elementAt(saveQIndex)
                  .id;
            } else {
              if (lessonPickedIndex == -1) {
                qId = course.subjects
                    .elementAt(saveSubjectIndex)
                    .questionnaire
                    .elementAt(saveQIndex)
                    .id;
              } else {
                qId = course.subjects
                    .elementAt(saveSubjectIndex)
                    .lessons
                    .elementAt(lessonPickedIndex)
                    .questionnaire
                    .elementAt(saveQIndex)
                    .id;
              }
            }
            debugPrint('qId: $qId');
          }

          UserCourse userCourse = UserCourse()
            ..subjectStopId = saveSubjectIndex != -1
                ? course.subjects
                .elementAt(saveSubjectIndex)
                .subjectId
                : 0
            ..lessonStopId = lessonPickedIndex != -1
                ? course.subjects
                .elementAt(saveSubjectIndex)
                .lessons
                .elementAt(lessonPickedIndex)
                .lessonId
                : 0
            ..questionnaireStopId = qId
            ..isQuestionnaire = _lastBodyWidget is QuestionnaireWidget
            ..courseId = course.id;

          await IsarService().addUserCourseStop(userCourse);
          if (_bodyWidget.value is CourseMainPage) {
            if (myController.checkIfCreated()) {
              myController.method();
            }
          }
        }
      }
    }
    lastSubjectPickedIndex = -1;
    lastQuestionPickedIndex = -1;
    _lastBodyWidget = _bodyWidget.value;
    lastCourse = null;
    if (refresh) setState(() {});
  }

  void goToNextLesson(Subject currentSubject, int subjectIndex,
      Lesson currentLesson, currentIndex) {
    // for correct update last place in course
    lessonPickedIndex = currentIndex;
    subjectPickedIndex = subjectIndex;
    int nextIndex = currentIndex + 1;
    setState(() {
      _bodyWidget.value = LessonWidget(
          lesson: currentLesson,
          updateComplete: updateCompleteLesson,
          onNext: nextIndex < currentSubject.lessons.length
              ? () =>
              goToNextLesson(currentSubject, subjectIndex,
                  currentSubject.lessons.elementAt(nextIndex), nextIndex)
              : null);
    });
  }

  void goToNextSubject(Subject currentSubject, int subjectIndex) {
    // for correct update last place in course
    subjectPickedIndex = subjectIndex;
    int nextIndex = subjectIndex + 1;
    setState(() {
      _bodyWidget.value = SubjectMainPage(
          subjectIndex: nextIndex,
          subject: currentSubject,
          onNext: nextIndex < _currentCourse.subjects.length
              ? () =>
              goToNextSubject(
                  _currentCourse.subjects.elementAt(nextIndex), nextIndex)
              : null);
    });
  }

  updateSteps({int numUpdate = 1}) {
    currentStep = currentStep + numUpdate;
    progressPercent = ((currentStep / totalSteps) * 100).round();
  }

  updateCompleteLesson(int lessonId) async {
    Subject currentSubject =
    _currentCourse.subjects.elementAt(subjectPickedIndex);
    if (!currentSubject.lessons
        .elementAt(lessonPickedIndex)
        .isCompletedCurrentUser) {
      currentSubject.lessons
          .elementAt(lessonPickedIndex)
          .isCompletedCurrentUser = true;
      await IsarService().updateLessonCompleted(lessonId, updateUser: true);
      checkSubjectCompleted(currentSubject);
      updateSteps();
      setState(() {});
    }
  }

  checkSubjectCompleted(Subject currentSubject) {
    //if all lessons and quizs in subject are completed set subject as completed
    if (!currentSubject.isCompletedCurrentUser &&
        currentSubject.lessons.every((l) =>
        l.isCompletedCurrentUser &&
            l.questionnaire.every((q) => q.isCompletedCurrentUser)) &&
        currentSubject.questionnaire.every((q) => q.isCompletedCurrentUser)) {
      currentSubject.isCompletedCurrentUser = true;
      IsarService().updateSubjectCompleted(currentSubject.subjectId, true);
      updateCourseStatus(checkCompleted: true, updateMiddle: true);
    } else {
      updateCourseStatus(updateMiddle: true);
    }
  }

  updateCourseStatus(
      {bool checkCompleted = false, bool updateMiddle = false}) async {
    if (checkCompleted) {
      //if all subjects are completed in course set course finish status
      if (userCourse?.status != Status.synchronized &&
          userCourse?.status != Status.finish) {
        if (_currentCourse.subjects.every((s) => s.isCompletedCurrentUser)) {
          await IsarService().updateCourse(_currentCourse.id, true);
        }
      }
    } else if (updateMiddle) {
      if (userCourse?.status == Status.start) {
        await IsarService().updateCourse(_currentCourse.id);
      }
    }
  }

  updateCompleteQuiz(int quizId) async {
    int numUpdate = 0;
    int? lessonId;
    if (subjectPickedIndex != -1) {
      Subject currentSubject =
      _currentCourse.subjects.elementAt(subjectPickedIndex);
      if (lessonPickedIndex != -1) {
        if (!currentSubject.lessons
            .elementAt(lessonPickedIndex)
            .questionnaire
            .elementAt(questionPickedIndex)
            .isCompletedCurrentUser) {
          currentSubject.lessons
              .elementAt(lessonPickedIndex)
              .questionnaire
              .elementAt(questionPickedIndex)
              .isCompletedCurrentUser = true;
          numUpdate++;

          //check if all quizs in lessons are completed
          if (currentSubject.lessons
              .elementAt(lessonPickedIndex)
              .questionnaire
              .every((e) => e.isCompletedCurrentUser)) {
            //quiz of lesson
            if (!currentSubject.lessons
                .elementAt(lessonPickedIndex)
                .isCompletedCurrentUser) {
              currentSubject.lessons
                  .elementAt(lessonPickedIndex)
                  .isCompletedCurrentUser = true;
              numUpdate++;
              lessonId = currentSubject.lessons
                  .elementAt(lessonPickedIndex)
                  .lessonId;
            }
          }
        }
      } else
        //quiz of subject
          {
        if (!currentSubject.questionnaire
            .elementAt(questionPickedIndex)
            .isCompletedCurrentUser) {
          currentSubject.questionnaire
              .elementAt(questionPickedIndex)
              .isCompletedCurrentUser = true;
          numUpdate++;
        }
      }
      if (numUpdate > 0) {
        (checkSubjectCompleted(currentSubject));
      }
    } else {
      if (!_currentCourse.questionnaires
          .elementAt(questionPickedIndex)
          .isCompletedCurrentUser) {
        _currentCourse.questionnaires
            .elementAt(questionPickedIndex)
            .isCompletedCurrentUser = true;
        numUpdate++;
        updateCourseStatus(checkCompleted: true);
      }
    }
    await IsarService().updateQuizCompleted(quizId, true);
    if (lessonId != null) {
      await IsarService().updateLessonCompleted(lessonId, updateUser: true);
    }
    if (numUpdate > 0) {
      updateSteps(numUpdate: numUpdate);
      setState(() {});
    }
  }

  @override
  void dispose() {
    saveLastUserPosition();
    _bodyWidget.dispose();
    stream.cancel();
    super.dispose();
  }

  setNextData({bool refresh = false}) {
    switch (_bodyWidget.value.runtimeType) {
      case CourseMainPage:
        {
          nextButtonText = 'לנושא הראשון';
          doShowNext = _currentCourse.subjects.isNotEmpty;
        }
        break;

      case SubjectMainPage:
        {
          nextButtonText = 'לנושא הבא';
          doShowNext = _currentCourse.subjects.length > subjectPickedIndex + 1;
        }
        break;

      case LessonWidget:
        {
          nextButtonText = 'לשיעור הבא';
          doShowNext = lessonPickedIndex + 1 <
              _currentCourse.subjects
                  .elementAt(subjectPickedIndex)
                  .lessons
                  .length;
        }
        break;

      default:
        {
          doShowNext = false;
          nextButtonText = '';
        }
        break;
    }
    if (refresh) {
      setState(() {});
    }
  }
}

class CoursePageController {
  late void Function() method;
  late bool Function() checkIfCreated;
}
