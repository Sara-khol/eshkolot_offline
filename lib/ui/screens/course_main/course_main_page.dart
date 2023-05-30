import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/ui/screens/course_main/lesson_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/subject_main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';
import '../../../models/course.dart';
import '../../../models/questionnaire.dart';
import '../../../models/user.dart';
import '../../../services/isar_service.dart';
import 'main_page_child.dart';

class CourseMainPage extends StatefulWidget {
  final Course course;


  const CourseMainPage({super.key, required this.course, required this.controller});
   final CoursePageController controller;

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  late Future myFuture;
  Lesson? lastLesson;
  late IsarLinks<Questionnaire> lastQuestionnaire;
  Subject? lastSubject;
  UserCourse? data;
  late String lastTextButton;
  late var currentMainChild;

  @override
  initState() {
    super.initState();
    widget.controller.method=getLastPositionInCourse;
    widget.controller.checkIfCreated=checkIfCreated;
    getLastPositionInCourse(refresh: false);

  }

  @override
  void didUpdateWidget(covariant CourseMainPage oldWidget) {
    getLastPositionInCourse(refresh: false);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 624.h,
          width: 950.w,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE4E6E9)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 90.h,
              ),
              Image.asset('assets/images/logo_english.jpg',
                  height: 147.h),
              SizedBox(
                height: 23.h,
              ),
              Text(widget.course.title,
                  style: TextStyle(
                      fontSize: 36.sp, fontWeight: FontWeight.w600)),
              SizedBox(
                height: 15.h,
              ),
              Text("התחל מכאן ללמוד ולתרגל את בסיס השפה האנגלית",
                  style: TextStyle(
                      fontSize: 20.sp, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 30.h,
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
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 15.sp,
                        ),
                        SizedBox(width: 7.w),
                        Text(
                          '21 שעות',
                          style: TextStyle(fontSize: 18.sp),
                        )
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      indent: 11.h,
                      endIndent: 11.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.videocam_outlined,
                          size: 15.sp,
                        ),
                        SizedBox(width: 7.w),

                        Text(
                          '33 שיעורים',
                          style: TextStyle(fontSize: 18.sp),
                        )
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      indent: 11.h,
                      endIndent: 11.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.create,
                          size: 15.sp,
                        ),
                        SizedBox(width: 7.w),

                        Text(
                          '35 שאלונים',
                          style: TextStyle(fontSize: 18.sp),
                        )
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      indent: 11.h,
                      endIndent: 11.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_outline,
                          size: 15.sp,
                        ),
                        SizedBox(width: 7.w),
                        Text(
                          '1 שאלון מסכם',
                          style: TextStyle(fontSize: 18.sp),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 75.h,
              ),
              if (data != null)
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
                              Text(
                                  'המשך מהמקום שעצרת $lastTextButton',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontFamily: 'RAG-Sans')),
                              SizedBox(width: 4.w),
                              Icon(Icons.arrow_forward,color: Colors.white,size:15.sp ,)
                            ],
                          ),
                          onPressed: () {
                            if (!data!.isQuestionnaire) {
                              currentMainChild?.subjectPickedIndex= data!.subjectIndex;
                              currentMainChild?.lessonPickedIndex=data!.lessonIndex;
                              currentMainChild?.bodyWidget =
                                  LessonWidget(
                                      lesson: lastLesson!,
                                      onNext: data!.lessonIndex + 1 < lastSubject!.lessons.length
                                          ? () => currentMainChild
                                          .goToNextLesson(
                                          lastSubject!,
                                          data!.subjectIndex,
                                          lastSubject!.lessons
                                              .elementAt(
                                              data!.lessonIndex + 1),
                                          data!.lessonIndex + 1):null);
                            } else {
                              MainPageChild.of(context)?.bodyWidget =
                                  QuestionnaireWidget(
                                      questionnaires: lastQuestionnaire,
                                      title:
                                      lastTextButton /*lastLesson == null
                                            ? 'תרגיל מסכם - ${lastSubject!.name}'
                                            :
                                        'תרגול - ${lastLesson!.name}'*/
                                  );
                            }
                          },

                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
        SizedBox(
          height: 145.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 242.w),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 40.h,
              width: 175.w,
              decoration: const BoxDecoration(
                color: Color(0xFF32D489),
                borderRadius: BorderRadius.all(Radius.circular(30)),
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
                            onNext:   1 <
                                widget.course.subjects.length
                                ? () => MainPageChild.of(context)?.goToNextSubject(
                                widget.course.subjects.elementAt(1), 1)
                                : null);
                    MainPageChild.of(context)?.subjectPickedIndex = 0;
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
    );
  }

  getLastPositionInCourse({bool refresh=true}) async {
    debugPrint('getLastPositionInCourse');
    data = IsarService().getUserCourseData(widget.course.serverId);

    if (data != null) {

      if (data!.subjectStopId != 0) {
        for (int i = 0; i < widget.course.subjects.length; i++) {
          if (widget.course.subjects.elementAt(i).id == data!.subjectStopId) {
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
        for (int i = 0; i < lastSubject!.lessons.length; i++) {
          if (lastSubject!.lessons.elementAt(i).id == data!.lessonStopId) {
            lastLesson = lastSubject!.lessons.elementAt(i);
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

      if (!data!.isQuestionnaire) {
        lastTextButton = lastLesson!.name;
      } else {
        if (data!.subjectStopId == 0) {
          //questionnaire of course
          lastQuestionnaire = widget.course.questionnaire;
          lastTextButton = 'תרגיל מסכם - ${widget.course.title}';
        } else if (data!.lessonStopId == 0) {
          //questionnaire of subject
          lastQuestionnaire = lastSubject!.questionnaire;
          lastTextButton = 'תרגיל מסכם - ${lastSubject!.name}';
        } else {
          //questionnaire of lesson
          lastQuestionnaire = lastLesson!.questionnaire;
          lastTextButton = 'תרגול - ${lastLesson!.name}';
        }
      }
    if(refresh) {
   if(mounted)   setState(() {});
    }
    }
  }

  @override
  void didChangeDependencies() {
    currentMainChild = MainPageChild.of(context);
    super.didChangeDependencies();
  }

 bool checkIfCreated()
  {
    return(mounted) ;

  }


}
