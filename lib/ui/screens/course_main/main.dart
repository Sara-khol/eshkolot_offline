import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/subject_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
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
  int qIndex=-1;
  int totalSteps=39;
  late int currentStep;

  set bodyWidget(Widget value) => setState(() => _bodyWidget = value);

  @override
  void initState(){
    _bodyWidget= CourseMainPage(key: UniqueKey());
    currentStep=1;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        menuWidget(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar(),
             Expanded(
               child: Padding(
                 padding: EdgeInsets.only(top:60.h,right: 165.w),
                 child: _bodyWidget,
               )),
            ],
          ),
        )
      ],
    );
  }

  Widget progressBar(){
    return Container(
      height: 74.h,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE4E6E9))),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 80.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 6,right: 13.w),
                  child: Row(
                    children: [
                      Text('${(currentStep/totalSteps*100).toInt()}% הושלמו',
                        style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600,color: Color(0xFF2D2828)),),
                      SizedBox(width: 18,),
                      Text('$currentStep/$totalSteps שלבים',
                        style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,color: Color(0xFF6E7072)),)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 86.w),
                  child: LinearPercentIndicator(
                    width: 765.w,
                    backgroundColor: Color(0xFFF4F4F3),
                    progressColor: Color(0xFF2D2828),
                    lineHeight: 5,
                    percent: currentStep/totalSteps,
                    isRTL: true,
                  ),
                ),
              ],
            ),

          ),
          Container(
            width: 395.w,
            height: 74.h,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE4E6E9))
            ),
            child: TextButton(
              child: Text('לנושא הבא > ',  style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,color: Color(0xFF2D2828)),),
              onPressed: () {
                setState(() => _bodyWidget =
                   SubjectMainPage(course: widget.course)
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget menuWidget() {
    return Container(
      color: const Color(0xFFF0F0F0),
      width: 350.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 74.h,
            color: Color(0xFF6E7072),
            child: Row(
                children: [
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
                        _bodyWidget = CourseMainPage(key: UniqueKey());
                      });
                    }
                  ),
                ]
            ),
          ),///כותרת של הקורס
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.course.subjects.length,
                itemBuilder: (ctx, sIndex) {
                  Subject currentSubject = widget.course.subjects.elementAt(sIndex);
                  return Column(
                    children: [
                      ListTile(
                        title: Container(
                          height: 96.h,
                          width: double.infinity,
                          color: Colors.transparent,
                          child:
                            Text(
                               currentSubject.name,
                               style: TextStyle(
                                   fontWeight: FontWeight.w600, fontSize: 16.sp),
                             ),
                        ),
                        mouseCursor: SystemMouseCursors.click,
                        textColor: Color(0xFF6E7072),
                        leading: currentSubject.lessons.isNotEmpty&&currentSubject.lessons.last.isCompleted
                            ? Icon(Icons.circle_outlined, color: Color(0xFF6E7072),size: 22.sp)
                            : Icon(Icons.circle_outlined, color: Color(0xFFE4E6E9),size: 22.sp),

                        onTap: (){
                          setState(() {
                            currentSubject.isTapped=!currentSubject.isTapped;
                            //bodyWidget=SubjectMainPage(key: UniqueKey(),course: widget.course);
                            _bodyWidget=SubjectMainPage(course: widget.course,);
                          });
                          },
                      ),
                      Visibility(
                         visible: currentSubject.isTapped,
                         child: Padding(
                           padding: EdgeInsets.only(left: 55.w),
                           child: ListView.builder(
                             shrinkWrap: true,
                             itemCount: currentSubject.lessons.length,
                             itemBuilder: (ctx, lIndex) {
                               Lesson currentLesson = currentSubject.lessons.elementAt(lIndex);
                               return Center(
                                 child: Column(
                                   children: [
                                     ListTile(
                                       title: Text(currentLesson.name,
                                         style: TextStyle(
                                             decoration: TextDecoration.underline,
                                             fontWeight: lessonPickedIndex == lIndex ? FontWeight.w600 : FontWeight.w400,
                                             fontSize: 16.sp
                                         )
                                       ),
                                       trailing: currentSubject.lessons.isNotEmpty&&currentSubject.lessons.last.isCompleted
                                           ? Icon(Icons.check_circle, color: Color(0xFF2D2828),size: 22.sp,)
                                           : Icon(Icons.circle_outlined, color: Color(0xFFE4E6E9),size: 22.sp,),

                                       onTap: () {
                                         if (lIndex == 0 || currentSubject.lessons.elementAt(lIndex - 1).isCompleted) {
                                           setState(() {
                                             lessonPickedIndex = lIndex;
                                             qIndex--;
                                             _bodyWidget = LessonWidget(subject: currentSubject,lessonIndex: lessonPickedIndex,notifyParent: refresh);
                                           });
                                           print(lIndex);
                                         }
                                         else {
                                           showAlert();
                                         }
                                       }
                                     ),

                                     if (currentLesson.questionnaire.isNotEmpty)
                                       GestureDetector(
                                         onTap: () => setState(() {
                                           print(currentLesson.questionnaire.length);
                                           lessonPickedIndex=-1;
                                           qIndex=lIndex;
                                           _bodyWidget = QuestionnaireWidget(
                                           key:  UniqueKey(),
                                             questionnaires:
                                             currentLesson.questionnaire);
                                         }),
                                         child: Container(
                                           color: Color.fromARGB(255, 249, 249, 249),
                                           child: ListTile(
                                             title: Center(
                                               child: Row(
                                                 children: [
                                                   Text('תרגול - ${currentLesson.name}',
                                                    style: TextStyle(decoration: TextDecoration.underline,
                                                      fontWeight: qIndex == lIndex ? FontWeight.w600 : FontWeight.w400,
                                                      fontSize: 16.sp)),
                                                   Spacer(),
                                                   Icon(
                                                     Icons.create,
                                                     color: currentLesson.questionnaire.last.isComplete ? Color.fromARGB(255, 45, 40, 40) : Color.fromARGB(255, 228, 230, 233),
                                                     size: 20.sp,
                                                   ),
                                               ]),
                                             )
                                           ),
                                         ),
                                       ),
                                   ],
                               ));
                             },
                           ),
                         ),
                      ),//;

                      if (currentSubject.questionnaire.isNotEmpty)
                        GestureDetector(
                          onTap: () => setState(() {
                            print('currentSubject.questionnaire ${currentSubject.questionnaire}');
                            _bodyWidget = QuestionnaireWidget(
                              key: UniqueKey(),
                              questionnaires: currentSubject.questionnaire);
                          }),
                          child: Container(
                            width: double.infinity,
                            height: 50.h,
                            //color: Color(0xFF6E7072),
                            child: Center(
                              child: Row(
                                children: [
                                  Icon(Icons.stars_rounded,size: 35.sp,color: Color(0xFFACAEAF),),
                                  Text('תרגול מסכם - ${widget.course.title}',style: TextStyle(fontSize: 16.sp,color: Color(0xFF6E7072),),),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  );///רשימת נושאים בתוך קורס
                }),
          )
        ],
      ),
    );
  }

  refresh() {
    setState(() {});
  }

  void showAlert() async {
    await FlutterPlatformAlert.showCustomAlert(
      windowTitle: 'לא ניתן לעבור לשיעור הבא כל עוד השיעור הקודם לא הושלם',
      text: '',
      iconStyle: IconStyle.information,
    );
  }
}
