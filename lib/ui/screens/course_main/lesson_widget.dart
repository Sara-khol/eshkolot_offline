import 'package:eshkolot_offline/models/course.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/ui/screens/course_main/main_page_child.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/subject_main_page.dart';
import 'package:eshkolot_offline/ui/screens/course_main/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/lesson.dart';

class LessonWidget extends StatefulWidget {

  final Subject subject;
  final Function() notifyParent;
  final int lessonIndex;

  LessonWidget({super.key, required this.subject,this.lessonIndex=0, required this.notifyParent});

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {

  bool checkedValue = false;

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print('build');
    return bodyWidget();
  }

  Widget bodyWidget(){
    return SizedBox(
      width: 760.w,
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.videocam,size: 28.sp,),
              Padding(
                padding: EdgeInsets.only(right: 11.w,left: 11.w),
                child: Text(widget.subject.lessons.elementAt(widget.lessonIndex).name,style: TextStyle(fontSize: 36.sp,fontWeight: FontWeight.w600),),
              ),
              Icon(Icons.access_time,size: 15.sp,),
              Text(' 10min ',style: TextStyle(fontSize: 16.sp),),
              Spacer(),
              Container(
                height: 20.h,
                width: 70.w,
                decoration: BoxDecoration(
                    color: Color(0xFFF4F4F3),
                    border: Border.all(color: Color(0xFFC8C9CE))
                ),
                child: TextButton(
                  onPressed: () async{
                    if (!widget.subject.lessons.elementAt(widget.lessonIndex).isCompleted) {
                      widget.subject.lessons.elementAt(widget.lessonIndex).isCompleted = true;
                      print('pressed id ${widget.subject.lessons.elementAt(widget.lessonIndex).id}');
                      await IsarService.instance.updateLesson(widget.subject.lessons.elementAt(widget.lessonIndex).id);
                      setState(() {});
                      widget.notifyParent();
                    }
                  },
                  child: Text('  הושלם  ',style: TextStyle(fontSize: 12.sp,color: Color(0xFFACAEAF)),),
                ),
              )
            ],
          ),
          SizedBox(height: 34.h,),
          VideoWidget(),
          SizedBox(height: 32.h,),
          Container(
            color: Color(0xFFF4F4F3),
            height: 100.h,
            child: Padding(
              padding: EdgeInsets.only(top: 22.h,right: 35.w,left: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('תרגול - ${widget.subject.lessons.elementAt(widget.lessonIndex).name}',style: TextStyle(fontSize: 18.sp),),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Icon(Icons.create,size: 20.sp,),
                      SizedBox(width: 18.w,),
                      Icon(Icons.access_time,size: 14.sp,),
                      Text(' 30min ',style: TextStyle(fontSize: 16.sp),),
                      Container(
                        height: 20.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFC8C9CE))
                        ),
                        child: TextButton(
                          child: Text('  לתרגול >  ',style: TextStyle(fontSize: 12.sp,color: Color(0xFFACAEAF)),),
                          onPressed: () {
                            setState(() {
                              MainPageChild.of(context)?.bodyWidget= QuestionnaireWidget(key: UniqueKey(), questionnaires: widget.subject.lessons.elementAt(widget.lessonIndex).questionnaire);
                            });
                            // QuestionnaireWidget(key: UniqueKey(),questionnaires: widget.subject.lessons.elementAt(lessonIndex).questionnaire);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

          ),
          SizedBox(height: 40.h,),
          Row(
            children: [
              Container(
                height: 40.h,
                color: Color(0xFFE4E6E9),
                child: TextButton(
                  child: Text('  חזרה לנושא  ',style: TextStyle(color: Color(0xFF6E7072),fontSize: 20.sp),),
                  onPressed: () {
                    setState(() {
                      // bodyWidget=SubjectMainPage(course: widget.subject.course);
                    });
                    //SubjectMainPage(course:,)
                  },
                ),
              ),
              Spacer(),
              Container(
                height: 40.h,
                color: Color(0xFF6E7072),
                child: TextButton(
                  child: Text('  השיעור הבא >  ',style: TextStyle(color: Color(0xFFFFFFFF),fontSize: 20.sp),),
                  onPressed: () {
                    setState(() {
                      MainPageChild.of(context)?.bodyWidget=LessonWidget(subject: widget.subject, lessonIndex: widget.lessonIndex+1, notifyParent: widget.notifyParent);
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

