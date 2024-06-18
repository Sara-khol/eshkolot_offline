import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/ui/screens/course_main/lesson_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/subject_main_page.dart';
import 'package:eshkolot_offline/ui/screens/course_main/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/course.dart';
import '../../../models/quiz.dart';
import '../../../models/user.dart';
import '../../../services/isar_service.dart';
import 'main_page_child.dart';

class CourseMainPage extends StatefulWidget {
  final Course course;

  const CourseMainPage(
      {super.key, required this.course, required this.controller});

  final CoursePageController controller;

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  late Future myFuture;
  Lesson? lastLesson;
  Quiz? lastQuestionnaire;
  Subject? lastSubject;
  UserCourse? data;
  late String lastTextButton = '';
  late var currentMainChild;
  late String imagePath;

  @override
  initState() {
    super.initState();
    widget.controller.method = getLastPositionInCourse;
    widget.controller.checkIfCreated = checkIfCreated;
    getLastPositionInCourse(refresh: false);
    imagePath = setKnowledgeImagePath();
  }

  @override
  void didUpdateWidget(covariant CourseMainPage oldWidget) {
    getLastPositionInCourse(refresh: false);
    imagePath = setKnowledgeImagePath();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 734.h,
          // width: 950.w,
          width: double.infinity,
          margin: EdgeInsets.only(left: 242.w, right: 120.w),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE4E6E9)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 45.h,
              ),
              Image.asset(imagePath, height: 91.h),
              SizedBox(
                height: 15.h,
              ),
              Text(widget.course.title,
                  style:
                      TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w600)),
              SizedBox(
                height: 10.h,
              ),
              Text(widget.course.briefInformation,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 15.h,
              ),
              Container(
                height: 50.h,
                width: 551.w,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF6E7072)),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 15.sp,
                    ),
                    SizedBox(width: 7.w),
                    Text(
                      '${widget.course.countHours ?? 0} שעות',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      indent: 11.h,
                      endIndent: 11.h,
                    ),
                    Icon(
                      Icons.videocam_outlined,
                      size: 15.sp,
                    ),
                    SizedBox(width: 7.w),
                    Text(
                      '${widget.course.countLesson ?? 0} שיעורים',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      indent: 11.h,
                      endIndent: 11.h,
                    ),
                    Icon(
                      Icons.create,
                      size: 15.sp,
                    ),
                    SizedBox(width: 7.w),
                    Text(
                      '${widget.course.countQuiz ?? 0} שאלונים',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      indent: 11.h,
                      endIndent: 11.h,
                    ),
                    Icon(
                      Icons.star_outline,
                      size: 15.sp,
                    ),
                    SizedBox(width: 7.w),
                    Text(
                        '${widget.course.countEndQuiz ?? 0} ${widget.course.countEndQuiz == 1 ? 'שאלון מסכם' : 'שאלונים מסכמים'}',
                        style: TextStyle(fontSize: 18.sp)),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              VideoWidget(
                key: Key(widget.course.courseInformationVideo),
                videoId: widget.course.courseInformationVideo,
                videoNum: widget.course.courseInformationVideo,
                fileId: 0,
                height: 310.h,
                width: 551.w,
              ),
              // SizedBox(
              //   height: 20.h,
              // ),
              // if (data != null)
              if (lastLesson != null ||
                  lastSubject != null ||
                  lastQuestionnaire != null)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 40.h,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    alignment: Alignment.center,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.only(
                                        left: 50.w, right: 50.w),
                                    textStyle: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('המשך מהמקום שעצרת $lastTextButton',
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontFamily: 'RAG-Sans')),
                                      SizedBox(width: 4.w),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 15.sp,
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    if (!data!.isQuestionnaire) {
                                      currentMainChild?.subjectPickedIndex =
                                          data!.subjectIndex;
                                      currentMainChild?.lessonPickedIndex =
                                          data!.lessonIndex;

                                      currentMainChild?.bodyWidget =
                                          LessonWidget(
                                              lesson: lastLesson!,
                                              //todo check if works..
                                              updateComplete: currentMainChild
                                                  .updateCompleteLesson,
                                              onNext: data!.lessonIndex + 1 <
                                                      lastSubject!
                                                          .lessonsList.length
                                                  ? () => currentMainChild
                                                      .goToNextLesson(
                                                          lastSubject!,
                                                          data!.subjectIndex,
                                                          lastSubject!
                                                              .lessonsList
                                                              .elementAt(data!
                                                                      .lessonIndex +
                                                                  1),
                                                          data!.lessonIndex + 1)
                                                  : null);
                                    } else {
                                      currentMainChild?.questionPickedIndex =
                                          data!.questionIndex;
                                      currentMainChild?.subjectPickedIndex =
                                          data!.subjectIndex;
                                      currentMainChild?.lessonPickedIndex =
                                          data!.lessonIndex;
                                      MainPageChild.of(context)?.bodyWidget =
                                          QuestionnaireWidget(
                                        quiz: lastQuestionnaire!,
                                        onNext: data!.lessonIndex + 1 <
                                                lastSubject!.lessonsList.length
                                            ? () => currentMainChild
                                                .goToNextLesson(
                                                    lastSubject!,
                                                    data!.subjectIndex,
                                                    lastSubject!.lessonsList
                                                        .elementAt(
                                                            data!.lessonIndex +
                                                                1),
                                                    data!.lessonIndex + 1)
                                            : null,
                                      );
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
        // SizedBox(
        //   height: 100.h,
        // ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 242.w),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 40.h,
                    width: 175.w,
                    decoration: BoxDecoration(
                      color: Color(
                          MainPageChild.of(context)!.widget.knowledgeColor != -1
                              ? MainPageChild.of(context)!.widget.knowledgeColor
                              : 0xFF32D489),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          alignment: Alignment.center,
                          foregroundColor: Colors.white,
                          //padding: EdgeInsets.only(left: 45.w,right: 45.w,),
                          textStyle: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          MainPageChild.of(context)?.bodyWidget =
                              SubjectMainPage(
                                  subjectIndex: 0,
                                  subject: widget.course.subjects.first,
                                  onNext: 1 < widget.course.subjects.length
                                      ? () {
                                          currentMainChild?.goToNextSubject(
                                              widget.course.subjects
                                                  .elementAt(1),
                                              1);
                                        }
                                      : null);
                          currentMainChild?.subjectPickedIndex = 0;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(' לנושא הראשון',
                                style: TextStyle(
                                    fontSize: 18.sp, fontFamily: 'RAG-Sans')),
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
            ],
          ),
        ),
      ],
    );
  }

  getLastPositionInCourse({bool refresh = true}) async {
    // debugPrint('getLastPositionInCourse');
    data = IsarService().getUserCourseData(widget.course.id);

    if (data != null &&
        (data!.subjectStopId != 0 ||
            data!.lessonStopId != 0 ||
            data!.questionnaireStopId != 0)) {
      if (data!.subjectStopId != 0) {
        for (int i = 0; i < widget.course.subjects.length; i++) {
          if (widget.course.subjects.elementAt(i).subjectId ==
              data!.subjectStopId) {
            lastSubject = widget.course.subjects.elementAt(i);
            data!.subjectIndex = i;
            break;
          }
        }
      } else {
        lastSubject = null;
      }

      // lastSubject =
      // data!.subjectStopId != 0 ? widget.course.subjects.firstWhere((s) =>
      // s.id == data!.subjectStopId) : null;
      if (data!.lessonStopId != 0) {
        for (int i = 0; i < lastSubject!.lessonsList.length; i++) {
          if (lastSubject!.lessonsList.elementAt(i).lessonId ==
              data!.lessonStopId) {
            lastLesson = lastSubject!.lessonsList.elementAt(i);
            data!.lessonIndex = i;
            break;
          }
        }
      } else {
        lastLesson = null;
      }

      // lastLesson = data!.lessonStopId != 0
      //     ? lastSubject!.lessons.firstWhere((l) => l.id == data!.lessonStopId)
      //     : null;
      //check if there is data on last stop
      //  if (lastLesson != null || lastSubject != null) {
      if (!data!.isQuestionnaire) {
        lastTextButton = lastLesson!.name;
      } else {
        if (data!.subjectStopId == 0) {
          //questionnaire of course
          //lastQuestionnaire = widget.course.questionnaires.firstWhere((q) => q.id==data!.questionnaireStopId);

          for (int i = 0; i < widget.course.questionnaires.length; i++) {
            if (widget.course.questionnaires.elementAt(i).id ==
                data!.questionnaireStopId) {
              lastQuestionnaire = widget.course.questionnaires.elementAt(i);
              data!.questionIndex = i;
              break;
            }
          }
        } else if (data!.lessonStopId == 0) {
          //questionnaire of subject
          // lastQuestionnaire = lastSubject!.questionnaire.firstWhere((q) => q.id==data!.questionnaireStopId);

          for (int i = 0; i < lastSubject!.questionnaire.length; i++) {
            if (lastSubject!.questionnaire.elementAt(i).id ==
                data!.questionnaireStopId) {
              lastQuestionnaire = lastSubject!.questionnaire.elementAt(i);
              data!.questionIndex = i;
              break;
            }
          }
        } else {
          //questionnaire of lesson
          // lastQuestionnaire = lastLesson!.questionnaire.firstWhere((q) => q.id==data!.questionnaireStopId);

          for (int i = 0; i < lastLesson!.questionnaire.length; i++) {
            if (lastLesson!.questionnaire.elementAt(i).id ==
                data!.questionnaireStopId) {
              lastQuestionnaire = lastLesson!.questionnaire.elementAt(i);
              data!.questionIndex = i;
              break;
            }
          }
        }
        lastTextButton = lastQuestionnaire!.title;
      }
      if (refresh) {
        if (mounted) setState(() {});
      }
    }
    // }
  }

  String setKnowledgeImagePath() {
    switch (MainPageChild.of(context)!.widget.knowLedgeId) {
      case 61: //Physics
        return 'assets/images/logo_english.png';
      case 63: //english
        return 'assets/images/logo_physics.png';
      case 155: //math
        return 'assets/images/logo_math.png';
      case 215: //אוריינות
        return 'assets/images/logo_literacy.png';
      default:
        return 'assets/images/logo_literacy.png';
    }
  }

  @override
  void didChangeDependencies() {
    currentMainChild = MainPageChild.of(context);
    super.didChangeDependencies();
  }

  bool checkIfCreated() {
    return (mounted);
  }
}
