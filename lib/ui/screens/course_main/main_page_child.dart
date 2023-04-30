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
import 'lesson_widget.dart';
import 'course_main_page.dart';

class MainPageChild extends StatefulWidget {
  const MainPageChild({super.key, required this.course});

  final Course course;

  static _MainPageChildState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainPageChildState>();

  @override
  State<MainPageChild> createState() => _MainPageChildState();

}

class _MainPageChildState extends State<MainPageChild> {
  late ValueNotifier<Widget> _bodyWidget;
  Widget? _lastBodyWidget;

  int lessonPickedIndex = -1;
  int subjectPickedIndex = -1;
  int lastSubjectPickedIndex = -1;
  Course? lastCourse;

  int totalSteps = 39;
  late int currentStep;
  late bool doShowNext;
  late String nextButtonText;
  final CoursePageController myController = CoursePageController();

  set bodyWidget(Widget value) => setState(() => _bodyWidget.value = value);



  @override
  void initState() {
    super.initState();
    _bodyWidget = ValueNotifier(
        CourseMainPage(course: widget.course, controller: myController));

    currentStep = 1;
    _bodyWidget.addListener(doTaskWhenNotified);
    setNextData();
    MainPage.of(context)?.setUpdate=saveLastUserPosition;
  }

  void doTaskWhenNotified() async {
    await saveLastUserPosition(refresh: true);
    setNextData();
  }

  @override
  void didUpdateWidget(covariant MainPageChild oldWidget) {
    if (oldWidget.course != widget.course) {
      print('lll');
      lastCourse = oldWidget.course;
    }
    _bodyWidget.value =
        CourseMainPage(course: widget.course, controller: myController);
    super.didUpdateWidget(oldWidget);
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
      decoration: BoxDecoration(border: Border.all(color: Color(0xFFE4E6E9))),
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
                          '${(currentStep / totalSteps * 100).toInt()}% הושלמו',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  //todo change get color or from knowledge or from path
                                  Color(widget.course.knowledge.value != null
                                      ? widget.course.knowledge.value!.color
                                      : 0xff32D489)),
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
                              color: Color(0xFF6E7072)),
                        )
                      ],
                    ),
                  ),
                  LinearPercentIndicator(
                    /* width: 765.w,*/
                    backgroundColor: Color(0xFFF4F4F3),
                    progressColor: Color(0xFF62FFB8),
                    lineHeight: 5,
                    percent: currentStep / totalSteps,
                    isRTL: true,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 395.w,
            height: 74.h,
            decoration:
                BoxDecoration(border: Border.all(color: Color(0xFFE4E6E9))),
            child:nextButton()
          )
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
            color: Color(0xFF32D489),
            child: TextButton(
                child: Text(
                  widget.course.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  _bodyWidget.value = CourseMainPage(
                      course: widget.course, controller: myController);

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
                              ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: Color(0xFFE4E6E9),
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount: widget.course.subjects.length,
                                  itemBuilder: (ctx, sIndex) {
                                    Subject currentSubject = widget
                                        .course.subjects
                                        .elementAt(sIndex);
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Container(
                                            width: double.infinity,
                                            color: Colors.transparent,
                                            child: Row(
                                              children: [
                                                currentSubject.lessons
                                                            .isNotEmpty &&
                                                        currentSubject.lessons
                                                            .last.isCompleted
                                                    ? Icon(
                                                        Icons.circle_outlined,
                                                        color:
                                                            Color(0xFF62FFB8),
                                                        size: 20.sp)
                                                    : Icon(
                                                        Icons.circle_outlined,
                                                        color:
                                                            Color(0xFFE4E6E9),
                                                        size: 20.sp),
                                                SizedBox(
                                                  width: 25.w,
                                                ),
                                                Icon(
                                                  Icons.book,
                                                  size: 13.h,
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(currentSubject.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18.sp)),
                                                Spacer(),
                                                Icon(
                                                    Icons.arrow_drop_down_sharp)
                                              ],
                                            ),
                                          ),
                                          mouseCursor: SystemMouseCursors.click,
                                          textColor: Color(0xFF2D2828),
                                          onTap: () {
                                            setState(() {
                                              currentSubject.isTapped =
                                                  !currentSubject.isTapped;
                                              lastSubjectPickedIndex =
                                                  subjectPickedIndex;
                                              subjectPickedIndex = sIndex;
                                              _bodyWidget.value =
                                                  SubjectMainPage(
                                                      subjectIndex:
                                                          subjectPickedIndex,
                                                      subject: currentSubject,
                                                  onNext:  subjectPickedIndex + 1 <
                                                      widget.course.subjects.length
                                                      ? () => goToNextSubject(
                                                      widget.course.subjects.elementAt(
                                                          subjectPickedIndex + 1),
                                                      subjectPickedIndex + 1)
                                                      : null,);
                                            });
                                          },
                                        ),
                                        Visibility(
                                          visible: currentSubject.isTapped,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                currentSubject.lessons.length,
                                            itemBuilder: (ctx, lIndex) {
                                              Lesson currentLesson =
                                                  currentSubject.lessons
                                                      .elementAt(lIndex);
                                              return Center(
                                                  child: Column(
                                                children: [
                                                  ListTile(
                                                      minLeadingWidth: 30.w,
                                                      title: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .videocam_outlined,
                                                            size: 22.sp,
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(width: 14.w),
                                                          Text(
                                                              currentLesson
                                                                  .name,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      16.sp)),
                                                        ],
                                                      ),
                                                      leading: Stack(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .center,
                                                        children: [
                                                          VerticalDivider(
                                                              color: currentLesson
                                                                      .isCompleted
                                                                  ? Color(
                                                                      0xFF62FFB8)
                                                                  : Color(
                                                                      0xFFE4E6E9),
                                                              thickness: 3.w,
                                                              indent:
                                                                  lIndex == 0
                                                                      ? 25.h
                                                                      : null,
                                                              endIndent: lIndex ==
                                                                      currentSubject
                                                                              .lessons
                                                                              .length -
                                                                          1
                                                                  ? 20.h
                                                                  : null),
                                                          //currentSubject.lessons.isNotEmpty &&
                                                          currentLesson
                                                                  .isCompleted
                                                              ? Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Color(
                                                                      0xFF62FFB8),
                                                                  size: 20.sp,
                                                                )
                                                              : Container(
                                                                  height: 18.h,
                                                                  width: 18.w,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border.all(
                                                                          color: Color(
                                                                              0xFFE4E6E9),
                                                                          width: 3
                                                                              .w),
                                                                      color: Color(
                                                                          0xFFFAFAFA)),
                                                                )
                                                        ],
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          lessonPickedIndex =
                                                              lIndex;
                                                          subjectPickedIndex =
                                                              sIndex;
                                                          _bodyWidget.value =
                                                              LessonWidget(
                                                            lesson: currentSubject
                                                                .lessons
                                                                .elementAt(
                                                                    lessonPickedIndex),
                                                            onNext: lessonPickedIndex +
                                                                        1 <
                                                                    currentSubject
                                                                        .lessons
                                                                        .length
                                                                ? () => goToNextLesson(
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
                                                      .questionnaire.isNotEmpty)
                                                    ListTile(
                                                      minLeadingWidth: 30.w,
                                                      title: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .create_outlined,
                                                            color: Colors.black,
                                                            size: 20.sp,
                                                          ),
                                                          SizedBox(
                                                            width: 14.w,
                                                          ),
                                                          Text(
                                                              'תרגול - ${currentLesson.name}',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      16.sp)),
                                                        ],
                                                      ),
                                                      leading: Stack(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .center,
                                                        children: [
                                                          VerticalDivider(
                                                            color: Color(
                                                                0xFFE4E6E9),
                                                            thickness: 3.w,
                                                          ),
                                                          currentSubject.lessons
                                                                      .isNotEmpty &&
                                                                  currentSubject
                                                                      .lessons
                                                                      .last
                                                                      .isCompleted
                                                              ? Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Color(
                                                                      0xFF62FFB8),
                                                                  size: 25.sp,
                                                                )
                                                              : Container(
                                                                  height: 18.h,
                                                                  width: 18.w,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border.all(
                                                                          color: Color(
                                                                              0xFFE4E6E9),
                                                                          width: 3
                                                                              .w),
                                                                      color: Color(
                                                                          0xFFFAFAFA)),
                                                                )
                                                        ],
                                                      ),
                                                      onTap: () => setState(() {
                                                        print(currentLesson
                                                            .questionnaire
                                                            .length);
                                                        lessonPickedIndex =
                                                            lIndex;
                                                        subjectPickedIndex =
                                                            sIndex;

                                                        _bodyWidget.value =
                                                            QuestionnaireWidget(
                                                                title:
                                                                    'תרגול - ${currentLesson.name}',
                                                                questionnaires:
                                                                    currentLesson
                                                                        .questionnaire);
                                                      }),
                                                    ),
                                                ],
                                              ));
                                            },
                                          ),
                                        ),
                                        if (currentSubject
                                            .questionnaire.isNotEmpty)
                                          Visibility(
                                            visible: currentSubject.isTapped,
                                            child: GestureDetector(
                                              onTap: () => setState(() {
                                                print(
                                                    'currentSubject.questionnaire ${currentSubject.questionnaire}');
                                                subjectPickedIndex = sIndex;
                                                lessonPickedIndex = -1;
                                                _bodyWidget.value =
                                                    QuestionnaireWidget(
                                                        title:
                                                            'תרגיל מסכם - ${currentSubject.name}',
                                                        questionnaires:
                                                            currentSubject
                                                                .questionnaire);
                                              }),

                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.only(
                                                    right: 40.h),
                                                height: 50.h,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star_border,
                                                        size: 20.sp,
                                                        color: Colors.black,
                                                      ),
                                                      SizedBox(
                                                        width: 14.w,
                                                      ),
                                                      Text(
                                                          'תרגיל מסכם - ${currentSubject.name}',
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color: Color(
                                                                  0xFF2D2828))),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ),
                                          ),
                                        Visibility(
                                          visible: sIndex ==
                                              widget.course.subjects.length - 1,
                                          child: GestureDetector(
                                            onTap: () => setState(() {
                                              subjectPickedIndex = -1;
                                              lessonPickedIndex = -1;
                                              _bodyWidget.value =
                                                  QuestionnaireWidget(
                                                      title:
                                                          'תרגול מסכם - ${widget.course.title}',
                                                      questionnaires: widget
                                                          .course
                                                          .questionnaire);
                                            }),
                                            child: Container(
                                              width: double.infinity,
                                              padding:
                                                  EdgeInsets.only(right: 10.w),
                                              height: 50.h,
                                              //color: Color(0xFF6E7072),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star_border,
                                                      size: 20.sp,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 14.w,
                                                    ),
                                                    Text(
                                                        'תרגיל מסכם - קורס ${widget.course.title}',
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            color: Color(
                                                                0xFF2D2828))),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );

                                    ///רשימת נושאים בתוך קורס
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: 15.w,
                    height: double.infinity,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(width: 1.h, color: Color(0xFFE4E6E9))))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nextButton()
  {
    return  Visibility(
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
              color: Color(0xFF32D489),
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
                    Subject mySubject = widget.course.subjects
                        .elementAt(subjectPickedIndex);
                    lessonPickedIndex = lessonPickedIndex + 1;

                    _bodyWidget.value = LessonWidget(
                      lesson: mySubject.lessons
                          .elementAt(lessonPickedIndex),
                      onNext: lessonPickedIndex + 1 <
                          mySubject.lessons.length
                          ? () => goToNextLesson(
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
                          subject: widget.course.subjects
                              .elementAt(subjectPickedIndex),
                          onNext: subjectPickedIndex + 1 <
                              widget.course.subjects.length
                              ? () => goToNextSubject(
                              widget.course.subjects.elementAt(
                                  subjectPickedIndex + 1),
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
    if (_lastBodyWidget != null) {

      if ((_bodyWidget.value is! QuestionnaireWidget &&
              _bodyWidget.value is! LessonWidget) ||
          !refresh) {

        if (_lastBodyWidget is QuestionnaireWidget ||
            _lastBodyWidget is LessonWidget) {
          Course course = lastCourse != null ? lastCourse! : widget.course;
          int saveSubjectIndex = lastSubjectPickedIndex != -1
              ? lastSubjectPickedIndex
              : subjectPickedIndex;
          print(
              'subjectPickedIndex: $subjectPickedIndex lessonPickedIndex: $lessonPickedIndex '
              'saveSubjectIndex: $saveSubjectIndex');

          UserCourse userCourse = UserCourse()
            ..subjectStopId = saveSubjectIndex != -1
                ? course.subjects.elementAt(saveSubjectIndex).id
                : 0
            ..lessonStopId = lessonPickedIndex != -1
                ? course.subjects
                    .elementAt(saveSubjectIndex)
                    .lessons
                    .elementAt(lessonPickedIndex)
                    .id
                : 0
            ..isQuestionnaire = _lastBodyWidget is QuestionnaireWidget
            ..courseId = course.serverId;

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
          onNext: nextIndex < currentSubject.lessons.length
              ? () => goToNextLesson(currentSubject, subjectIndex,
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
          onNext: nextIndex < widget.course.subjects.length
              ? () => goToNextSubject(
                  widget.course.subjects.elementAt(nextIndex), nextIndex)
              : null);
    });
  }

  @override
  void dispose() {
    saveLastUserPosition();
    _bodyWidget.dispose();
    super.dispose();
  }

  setNextData() {
    switch (_bodyWidget.value.runtimeType) {
      case CourseMainPage:
        {
          nextButtonText = 'לנושא הראשון';
          doShowNext = widget.course.subjects.isNotEmpty;
        }
        break;

      case SubjectMainPage:
        {
          nextButtonText = 'לנושא הבא';
          doShowNext = widget.course.subjects.length > subjectPickedIndex + 1;
        }
        break;

      case LessonWidget:
        {
          nextButtonText = 'לשיעור הבא';
          doShowNext = lessonPickedIndex + 1 <
              widget.course.subjects
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
  }
}

class CoursePageController {
  late void Function() method;
  late bool Function() checkIfCreated;
}
