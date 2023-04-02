
import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/ui/screens/course_main/course_main_page.dart';
import 'package:eshkolot_offline/ui/screens/course_main/main_page_child.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';

import '../../../models/lesson.dart';

class LessonWidget extends StatefulWidget {
 // final Subject subject;
 // final Lesson lesson;
  // final Lesson? nextLesson;
  late final int lessonIndex;

  Function(BuildContext context) backToSubject;
//  final bool notLastLesson;
  final IsarLinks<Lesson> lessons;

  LessonWidget(
      {super.key,
      //required this.subject,
      this.lessonIndex = 0, required this.lessons, required this.backToSubject,
       });

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  bool checkedValue = false;
late  Lesson lesson;


  @override
  void initState() {
    lesson= widget.lessons.elementAt(widget.lessonIndex);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LessonWidget oldWidget) {
    lesson= widget.lessons.elementAt(widget.lessonIndex);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return bodyWidget();
  }

  Widget bodyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 624.h,
          width: 950.w,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE4E6E9)),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 19.w,),
                  Icon(
                    Icons.videocam,
                    size: 28.sp,
                  ),
                  SizedBox(width: 23.w,),
                  Text(lesson.name, style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 32.w,),
                  Icon(
                    Icons.access_time,
                    size: 15.sp,
                  ),
                  SizedBox(width: 7.w,),
                  Text(
                    "10 דק'",
                    style: TextStyle(fontSize: 16.sp,color: Color(0xFF2D2828)),
                  ),
                  Spacer(),
                  Container(
                    height: 20.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        color: Color(0xFF62FFB8),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                    child: TextButton(
                      onPressed: () async {
                        if (!lesson.isCompleted) {
                          lesson.isCompleted = true;
                          print('pressed id ${lesson.id}');
                          await IsarService.instance.updateLesson(lesson.id);
                          setState(() {

                          });
                        }
                      },
                      child: Text(
                        '  הושלם  ',
                        style: TextStyle(fontSize: 13.sp, color: Colors.white),
                      ),
                    ),

                  ),
                  SizedBox(width: 18.w,),
                ],
              ),
              SizedBox(
                height: 27.h,
              ),
              VideoWidget(vimoeId: lesson.vimoeId),
            ],
          ),
        ),
        SizedBox(height: 17.h,),
        Container(
          width: 950.w,
          height: 66.h,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE4E6E9)),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 18.w,right: 18.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.create,size: 19.sp,),
                  SizedBox(width: 33.w,),
                  Text(
                    'תרגול - ${lesson.name}',
                    style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 65.h),
                  Icon(
                    Icons.access_time,
                    size: 14.sp,
                  ),
                  Text("  30 דק'  " ,style: TextStyle(fontSize: 16.sp),
                  ),
                  Spacer(),
                  Container(
                    height: 20.h,
                    //width: 70.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFF4F4F3)
                    ),
                    child: TextButton(
                      child: Row(
                        children: [
                          Text(
                            '  לתרגול ',
                            style: TextStyle(
                                fontSize: 12.sp,fontWeight: FontWeight.w600, color: Color(0xFF2D2828)),
                          ),
                          Icon(Icons.arrow_forward,size: 10.sp,color: Color(0xFF2D2828),)
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          MainPageChild.of(context)?.bodyWidget =
                              QuestionnaireWidget(
                                title: 'תרגול - ${lesson.name}',
                                  questionnaires:
                                     lesson.questionnaire);
                        });
                        // QuestionnaireWidget(key: UniqueKey(),questionnaires: widget.subject.lessons.elementAt(lessonIndex).questionnaire);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 62.h,
        ),
        Row(
          children: [
            // Container(
            //   height: 40.h,
            //   color: Color(0xFFE4E6E9),
            //   child: TextButton(
            //     child: Text(
            //       '  חזרה לנושא  ',
            //       style: TextStyle(color: Color(0xFF6E7072), fontSize: 20.sp),
            //     ),
            //     onPressed: () {
            //       widget.backToSubject(context);
            //       // setState(() {
            //       //   MainPageChild.of(context)?.bodyWidget =SubjectMainPage(subject: subject);
            //       // });
            //       //SubjectMainPage(course:,)
            //     },
            //   ),
            // ),
            Spacer(),
           Visibility(
             visible: widget.lessonIndex+1<widget.lessons.length,
             child: Container(
                height: 40.h,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(30)),
                   color: Color(0xFF32D489)
               ),
                child: TextButton(
                  child: Row(
                    children: [
                      Text(
                        '  לשיעור הבא ',
                        style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                      Icon(Icons.arrow_forward,size: 16.sp,color: Colors.white,)
                    ],
                  ),
                  onPressed: () {

                      // widget.lessonIndex=widget.lessonIndex+1;
                      // lesson=widget.lessons.elementAt(widget.lessonIndex);
                      MainPageChild.of(context)?.bodyWidget = LessonWidget(
                        lessonIndex: widget.lessonIndex + 1, lessons: widget.lessons,
                        backToSubject: widget.backToSubject,
                      );


                  },
                ),
              ),
           ),
            SizedBox(width: 244.w,),
          ],
        )
      ],
    );
  }
}
