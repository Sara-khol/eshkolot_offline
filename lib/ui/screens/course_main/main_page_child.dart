import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/subject_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  late Widget _bodyWidget;
  int lessonPickedIndex = -1;
  int subjectPickedIndex = 0;
  int qIndex = -1;
  int totalSteps = 39;
  late int currentStep;

  set bodyWidget(Widget value) => setState(() => _bodyWidget = value);

  // set subjectPickedIndex(int  value) => setState(() => _bodyWidget = value);

  @override
  void initState() {
    super.initState();
    _bodyWidget = CourseMainPage(course: widget.course);
    currentStep = 1;
  }

  @override
  void didUpdateWidget(covariant MainPageChild oldWidget) {
    _bodyWidget = CourseMainPage(course: widget.course);
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
                  padding: EdgeInsets.only(top: 60.h, right: 165.w),
                  child: _bodyWidget,
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
                              color: Color(0xFF2D2828)),
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
                    progressColor: Color(0xFF2D2828),
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
            child: Visibility(
              visible: widget.course.subjects.length > subjectPickedIndex + 1,
              child: TextButton(
                child: Text(
                  'לנושא הבא > ',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D2828)),
                ),
                onPressed: () {
                  setState(() {
                    subjectPickedIndex++;
                    _bodyWidget = SubjectMainPage(
                        subject: widget.course.subjects
                            .elementAt(subjectPickedIndex));
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget menuWidget() {
    return Container(
      width: 350.w,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 74.h,
            color: Color(0xFF6E7072),
            child: Row(children: [
              Padding(
                padding: EdgeInsets.all(12.w),
                child: FaIcon(
                  FontAwesomeIcons.file,
                  size: 15.w,
                  color: Colors.white,
                ),
              ),
              TextButton(
                  child: Text(
                    widget.course.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    setState(() {
                      _bodyWidget = CourseMainPage(course: widget.course);
                    });
                  }),
            ]),
          ),

          ///כותרת של הקורס
          Expanded(
            child: Row(
              children: [
                Expanded(
                  // color: const Color(0xFFF0F0F0),
                  // width: 350.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Container(
                      //   width: double.infinity,
                      //   height: 74.h,
                      //   color: Color(0xFF6E7072),
                      //   child: Row(children: [
                      //     Padding(
                      //       padding: EdgeInsets.all(12.w),
                      //       child: FaIcon(
                      //         FontAwesomeIcons.file,
                      //         size: 15.w,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     TextButton(
                      //         child: Text(
                      //           widget.course.title,
                      //           style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 18.sp,
                      //               fontWeight: FontWeight.w600),
                      //         ),
                      //         onPressed: () {
                      //           setState(() {
                      //             _bodyWidget = CourseMainPage(
                      //                 course: widget.course);
                      //           });
                      //         }),
                      //   ]),
                      // ),
                      SizedBox(height: 20.h),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.course.subjects.length,
                            itemBuilder: (ctx, sIndex) {
                              Subject currentSubject =
                              widget.course.subjects.elementAt(sIndex);

                              return Column(
                                children: [
                                  ListTile(
                                    title:
                                    // Padding(padding: EdgeInsets.only(top: 25.h),
                                    //   child:
                                    Container(
                                      //height: 96.h,
                                      width: double.infinity,
                                      color: Colors.transparent,
                                      child: Text(
                                        currentSubject.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                    // ),
                                    mouseCursor: SystemMouseCursors.click,
                                    textColor: Color(0xFF6E7072),
                                    leading:
                                    currentSubject.lessons.isNotEmpty &&
                                        currentSubject.lessons.last.isCompleted
                                        ? Icon(Icons.circle_outlined,
                                        color: Color(0xFF6E7072),
                                        size: 22.sp)
                                        : Icon(Icons.circle_outlined,
                                        color: Color(0xFFE4E6E9),
                                        size: 22.sp),
                                    onTap: () {
                                      setState(() {
                                        currentSubject.isTapped =
                                        !currentSubject.isTapped;
                                        subjectPickedIndex = sIndex;
                                        _bodyWidget = SubjectMainPage(
                                            subject: currentSubject);
                                      });
                                    },
                                  ),
                                  Visibility(
                                    visible: currentSubject.isTapped,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 24.w, right: 40.w),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                        currentSubject.lessons.length,
                                        itemBuilder: (ctx, lIndex) {
                                          Lesson currentLesson = currentSubject
                                              .lessons
                                              .elementAt(lIndex);
                                          return Center(
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                      title: Text(
                                                          currentLesson.name,
                                                          style: TextStyle(
                                                              decoration: TextDecoration.underline,
                                                              fontWeight: lessonPickedIndex == lIndex ? FontWeight.w600 : FontWeight.w400,
                                                              fontSize: 16.sp)),
                                                      trailing: currentSubject.lessons.isNotEmpty &&
                                                          currentSubject.lessons.last.isCompleted
                                                          ? Icon(Icons.check_circle, color: Color(0xFF2D2828), size: 22.sp,)
                                                          : Icon(Icons.circle_outlined, color: Color(0xFFE4E6E9), size: 22.sp,),
                                                      onTap: () {
                                                        setState(() {
                                                          lessonPickedIndex = lIndex;
                                                          qIndex--;
                                                          _bodyWidget = LessonWidget(
                                                              lessonIndex: lessonPickedIndex,
                                                              lessons: currentSubject.lessons,
                                                              backToSubject:  (BuildContext context)=> bodyWidget=SubjectMainPage(subject: currentSubject)
                                                          );
                                                          // nextLesson:currentSubject.lessons.length>lessonPickedIndex+1 ?setNextLesson(currentSubject.lessons,lessonPickedIndex+1):null);
                                                        });
                                                        print(lIndex);
                                                      }),
                                                  if (currentLesson.questionnaire.isNotEmpty)
                                                    Container(
                                                      // color:
                                                      //     Color.fromARGB(255, 249, 249, 249),
                                                      child: ListTile(
                                                        title: Text('תרגול - ${currentLesson.name}', style: TextStyle(
                                                            decoration: TextDecoration.underline,
                                                            fontWeight: qIndex == lIndex ? FontWeight.w600 : FontWeight.w400, fontSize: 16.sp)),
                                                        trailing: Icon(
                                                          Icons.create,
                                                          color: currentLesson.questionnaire.last.isComplete
                                                              ? Color.fromARGB(255, 45, 40, 40)
                                                              : Color.fromARGB(255, 228, 230, 233),
                                                          size: 20.sp,
                                                        ),
                                                        onTap: () => setState(() {
                                                          print(currentLesson.questionnaire.length);
                                                          lessonPickedIndex = -1;
                                                          qIndex = lIndex;
                                                          _bodyWidget =
                                                              QuestionnaireWidget(
                                                                  title:'תרגול - ${currentLesson.name}',
                                                                  questionnaires: currentLesson.questionnaire);
                                                        }),
                                                      ),
                                                    ),
                                                ],
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                  if (currentSubject.questionnaire.isNotEmpty)
                                    Visibility(
                                      visible: currentSubject.isTapped,
                                      child: GestureDetector(
                                        onTap: () => setState(() {
                                          print(
                                              'currentSubject.questionnaire ${currentSubject.questionnaire}');
                                          _bodyWidget = QuestionnaireWidget(
                                              title:  'תרגול מסכם - ${currentSubject.name}',
                                              questionnaires:
                                              currentSubject.questionnaire);
                                        }),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(right: 40.h),
                                          height: 50.h,

                                          //color: Color(0xFF6E7072),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.stars_rounded,
                                                  size: 35.sp,
                                                  color: Color(0xFFACAEAF),
                                                ),
                                                Text(
                                                  'תרגול מסכם - ${currentSubject.name}',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Color(0xFF6E7072),
                                                  ),
                                                ),
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
                      )
                    ],
                  ),
                ),
                Container(
                    width: 15.w,
                    height: double.infinity,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(width: 1.h, color: Color(0xff6E7072))))
              ],
            ),
          ),
        ],
      ),
    );
  }

// setNextLesson(IsarLinks<Lesson> lessons, int lessonPickedIndex) {
//   print('lll ${lessons.length}');
//   print('lessonPickedIndex ${lessonPickedIndex}');
//   MainPageChild.of(context)?.bodyWidget = LessonWidget(
//       lessonIndex: lessonPickedIndex,
//       notLastLesson:lessons.length>lessonPickedIndex,
//       lesson:lessons.elementAt(lessonPickedIndex), nextLesson:lessons.length>lessonPickedIndex+1?
//   setNextLesson(lessons, lessonPickedIndex+1):null);
// }
}
