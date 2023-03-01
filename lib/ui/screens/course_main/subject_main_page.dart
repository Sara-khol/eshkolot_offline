import 'package:eshkolot_offline/ui/screens/course_main/lesson_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/course.dart';
import 'main.dart';

class SubjectMainPage extends StatefulWidget {
  const SubjectMainPage({super.key, required this.course});

  final Course course;

  @override
  State<SubjectMainPage> createState() => _SubjectMainPageState();
}

class _SubjectMainPageState extends State<SubjectMainPage> {

   late int totalSteps=widget.course.subjects.first.lessons.length+1;
   int currentStep=1;
   //late Widget bodyWidget;

   @override
  void initState(){
    super.initState();
     //bodyWidget=mainWidget();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
                child: mainWidget(),
        ),
      ]),
    );
  }

  Widget mainWidget() {
    return SizedBox(
      width: 760.w,
      child: Column(
        children: [
          Row(
            children: [
              FaIcon(FontAwesomeIcons.bookOpen,size: 27.sp,),
              Padding(
                padding: EdgeInsets.only(left:10.w,right: 8.w),
                child: Text(widget.course.subjects.elementAt(0).name,style: TextStyle(fontSize: 36.sp,fontWeight: FontWeight.w600),)
                ),
              Row(
                children: [
                  Icon(Icons.access_time,size: 15,),
                  Padding(
                    padding:  EdgeInsets.only(right: 4),
                    child: Text('4hr 10min',style: TextStyle(
                      fontSize: 16.sp
                    ),),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 33.h,bottom: 21.h),
            child: Container(
              height: 70.h,
              color: Color(0xFFF4F4F3),
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 17.w,left: 11.w),
                      child: Icon(Icons.arrow_circle_down_outlined,size: 25.sp,),
                    ),
                    Text('בנושא זה ${widget.course.subjects.elementAt(0).lessons.length} שיעורים, בהצלחה בלמידה!',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600
                    ),)
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE4E6E9))
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 54.h,right: 68.w,left: 68.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 6,right: 13.w),
                      child: Row(
                        children: [
                          Text('${(currentStep/totalSteps*100).toInt()}% הושלמו',
                            style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600,color: Color(0xFFACAEAF)),),
                          SizedBox(width: 12,),
                          Text('$currentStep/$totalSteps שלבים',
                            style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,color: Color(0xFFACAEAF)),)
                        ],
                      ),
                  ),
                  for(int i=0;i<widget.course.subjects.first.lessons.length ;i++)...[
                    Padding(
                      padding: EdgeInsets.only(top: 40.h,bottom: 35.h),
                      child: Divider(),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(widget.course.subjects.first.lessons.elementAt(i).name,style: TextStyle(
                                  fontSize: 20.sp,fontWeight: FontWeight.w600,decoration: TextDecoration.underline
                                ),),
                                SizedBox(height: 18.h),
                                Row(
                                  children: [
                                    Icon(Icons.videocam,size: 18.sp,),
                                    SizedBox(width: 18.w,),
                                    Icon(Icons.access_time,size: 14.sp,),
                                    Text('  10min  ',style: TextStyle(fontSize: 16.sp),),
                                    Container(
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Color(0xFFC8C9CE))
                                      ),
                                      child: TextButton(
                                        child: Text('  לצפיה בשיעור >  ',style: TextStyle(fontSize: 12.sp,color: Color(0xFFACAEAF)),),
                                        onPressed: () {
                                          setState(() {
                                            print(widget.course.subjects.first.lessons.elementAt(i).name);
                                            MainPageChild.of(context)?.bodyWidget=
                                                LessonWidget(subject: widget.course.subjects.elementAt(i),lessonIndex: i, notifyParent: refresh);
                                          });
                                        },
                                      ),
                                    ),
                                  ]
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(widget.course.subjects.elementAt(0).lessons.last.isCompleted ? Icons.check_circle: Icons.circle_outlined ,
                              color: widget.course.subjects.elementAt(0).lessons.last.isCompleted ?
                              Color(0xFF2D2828):Color(0xFFE4E6E9),size:28.sp)
                          ],
                        ),

                        SizedBox(height: 54.h),

                        Row(
                          children: [
                            Column(
                              children: [
                                Text('תרגול - ${widget.course.subjects.first.lessons.elementAt(i).name}',style: TextStyle(fontSize: 20.sp),),
                                SizedBox(height: 18.h),
                                Row(
                                children: [
                                  Icon(Icons.create,size: 18.sp,),
                                  SizedBox(width: 18.w,),
                                  Icon(Icons.access_time,size: 14.sp,),
                                  Text('  30min  ',style: TextStyle(fontSize: 16.sp),),
                                  Container(
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFFC8C9CE))
                                    ),
                                    child: TextButton(
                                      child: Text('  לתרגול >  ',style: TextStyle(fontSize: 12.sp,color: Color(0xFFACAEAF)),),
                                        onPressed: () {
                                          setState(() {
                                            MainPageChild.of(context)?.bodyWidget=
                                           QuestionnaireWidget(key: UniqueKey(),
                                                questionnaires: widget.course.subjects.first.lessons.elementAt(i).questionnaire);
                                          });
                                        },
                                    ),
                                  ),
                                ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.create ,
                                color: widget.course.subjects.elementAt(0).lessons.last.isCompleted ?
                                Color(0xFF2D2828):Color(0xFFE4E6E9),size:24.sp)
                          ],
                        )
                      ],
                    )

                  ]
                ]
              )
            )
          )
        ]
      ),
    );
  }

  refresh() {
     setState(() {});
   }

   foo(){}
}
