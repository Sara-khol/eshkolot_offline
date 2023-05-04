import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/ui/screens/course_main/lesson_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  late int totalSteps = widget.subject.lessons.length + 1;
  int currentStep = 1;
  late var currentMainChild;

  @override
  void initState() {
    super.initState();
    //bodyWidget=mainWidget();
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
              decoration: BoxDecoration(
                color: Color(0xFF32D489),
                borderRadius: BorderRadius.all(Radius.circular(30)),
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
            border: Border.all(color: Color(0xFFE4E6E9)),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    top: 30.h, bottom: 65.h, left: 65.w, right: 25.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.bookOpen, size: 27.sp),
                          Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 8.w),
                              child: Text(
                                widget.subject.name,
                                style: TextStyle(
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.w600),
                              )),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 4),
                                child: Text(
                                  "  4 שעות ו 10 דק' ",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.h, bottom: 40.h, right: 42.w),
                        child: Text(
                          'בנושא זה ${widget.subject.lessons.length} שיעורים, בהצלחה בלמידה!',
                          style: TextStyle(
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
                                  color: Color(0xFFACAEAF)),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              '$currentStep/$totalSteps שלבים',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFACAEAF)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 42.h,
                      ),
                      ListView.builder(
                        itemCount: widget.subject.lessons.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 74.h,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 31.h,
                                    width: 31.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Color(0xFF2D2828), width: 1.w),
                                    ),
                                    child: Center(
                                        child: Text("${index + 1}.",
                                            style: TextStyle(
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
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            progressIcon(index,true),
                                            SizedBox(
                                              width: 35.w,
                                            ),
                                            Icon(
                                              Icons.videocam_outlined,
                                              size: 13.sp,
                                            ),
                                            SizedBox(width: 14.h),
                                            Text(
                                                widget.subject.lessons
                                                    .elementAt(index)
                                                    .name,
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            Spacer(),
                                            Container(
                                              height: 20.h,
                                              decoration: BoxDecoration(
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
                                                          color: Color(
                                                              0xFF2D2828)),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      size: 10.sp,
                                                      color: Color(0xFF2D2828),
                                                    )
                                                  ],
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    print(widget.subject.lessons
                                                        .elementAt(index)
                                                        .name);
                                                    currentMainChild
                                                            ?.lessonPickedIndex =
                                                        index;
                                                    currentMainChild
                                                            ?.lastSubjectPickedIndex =
                                                        widget.subjectIndex;
                                                    currentMainChild?.bodyWidget = LessonWidget(
                                                        lesson: widget
                                                            .subject.lessons
                                                            .elementAt(index),
                                                        onNext: index + 1 <
                                                                widget.subject
                                                                    .lessons.length
                                                            ? () => currentMainChild.goToNextLesson(
                                                                widget.subject,
                                                                widget
                                                                    .subjectIndex,
                                                                widget.subject.lessons
                                                                    .elementAt(
                                                                        index + 1),
                                                                index + 1)
                                                            : null);
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            progressIcon(index,false),
                                            SizedBox(
                                              width: 35.w,
                                            ),
                                            Icon(
                                              Icons.create_outlined,
                                              size: 13.sp,
                                            ),
                                            SizedBox(width: 14.h),
                                            Text(
                                              'תרגול - ${widget.subject.lessons.elementAt(index).name}',
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                            Spacer(),
                                            Container(
                                              height: 20.h,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF4F4F3),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: TextButton(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '  לתרגול ',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color(
                                                              0xFF2D2828)),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      size: 10.sp,
                                                      color: Color(0xFF2D2828),
                                                    )
                                                  ],
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    currentMainChild
                                                            ?.lessonPickedIndex =
                                                        index;
                                                    currentMainChild
                                                            ?.lastSubjectPickedIndex =
                                                        widget.subjectIndex;
                                                    MainPageChild.of(context)
                                                            ?.bodyWidget =
                                                        QuestionnaireWidget(
                                                            title:
                                                                'תרגול - ${widget.subject.lessons.elementAt(index).name}',
                                                            questionnaires: widget
                                                                .subject.lessons
                                                                .elementAt(
                                                                    index)
                                                                .questionnaire);
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if(index== widget.subject.lessons.length-1)
                                        Divider(
                                            indent: 50.w,
                                            height: 0,
                                            color: colors.grey2ColorApp)
                                    ],
                                  )),
                                ]),
                          );
                        },
                      ),
                    ]))));

    //   ],
    // )

    // Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Column(
    //       children: [
    //         SizedBox(height: 42.h,),
    //         for (int i = 0; i < widget.subject.lessons.length; i++) ...[
    //         Container(
    //           height: 31.h,
    //           width: 31.w,
    //           decoration: BoxDecoration(
    //             shape: BoxShape.circle,
    //             border: Border.all(color: Color(0xFF2D2828),width: 1.w),
    //
    //           ),
    //           child: Center(child: Text("${i+1}.",style: TextStyle(fontSize: 16.sp,fontFamily: 'RAG-Sans'))),
    //         ),
    //           SizedBox(height: 51.h,)
    //         ]
    //           ],
    //         ),
    //         SizedBox(width: 30.w),
    //         Expanded(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //             for (int i = 0; i < widget.subject.lessons.length; i++) ...[
    //
    //           SizedBox(width: 24.w,),
    //
    //
    //           // Column(
    //           //   children: [
    //           //
    //           //     SizedBox(height: 18.h,),
    //           //     Stack(
    //           //       alignment: AlignmentDirectional.center,
    //           //       children: [
    //           //         VerticalDivider(color: widget.subject.lessons.elementAt(i).isCompleted?Color(0xFF62FFB8):Color(0xFFE4E6E9),thickness: 3.w,),
    //           //         //currentSubject.lessons.isNotEmpty &&
    //           //         widget.subject.lessons.elementAt(i).isCompleted?
    //           //         Icon(Icons.check_circle,color: Color(0xFF62FFB8),size: 22.sp,):
    //           //         Container(
    //           //           height: 18.h,
    //           //           width: 18.w,
    //           //           decoration: BoxDecoration(
    //           //               shape: BoxShape.circle,
    //           //               border: Border.all(color: Color(0xFFE4E6E9),width: 3.w),
    //           //               color: Color(0xFFFAFAFA)
    //           //           ),
    //           //         )
    //           //       ],
    //           //     ),
    //           //   ],
    //           // ),
    //           Divider(indent: 50.w,height: 0,color: colors.grey2ColorApp),
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(height:10.h),
    //               SizedBox(
    //                 height: 40.h,
    //                 child: Row(
    //                   children: [
    //                     Stack(
    //                       alignment: AlignmentDirectional.center,
    //                       children: [
    //                         VerticalDivider(color: widget.subject.lessons.elementAt(i).isCompleted
    //                             ?Color(0xFF62FFB8)
    //                             :Color(0xFFE4E6E9),
    //                           thickness: 3.w,
    //                           indent: i==0?25.h:null,
    //                           endIndent: i==widget.subject.lessons.length-1?20.h:null,
    //                         ),
    //                         widget.subject.lessons.elementAt(i).isCompleted?
    //                         Icon(Icons.check_circle,color: Color(0xFF62FFB8),size: 20.sp,):
    //                         Container(
    //                           height: 18.h,
    //                           width: 18.w,
    //                           decoration: BoxDecoration(
    //                               shape: BoxShape.circle,
    //                               border: Border.all(color: Color(0xFFE4E6E9),width: 3.w),
    //                               color: Color(0xFFFAFAFA)
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                     SizedBox(width: 35.w,),
    //                     Icon(Icons.videocam_outlined,size: 13.sp,),
    //                     SizedBox(width: 14.h),
    //                     Text(
    //                       widget.subject.lessons.elementAt(i).name,
    //                       style: TextStyle(
    //                           fontSize: 16.sp,
    //                           fontWeight: FontWeight.w600,
    //                       )
    //                     ),
    //                     Spacer(),
    //                     Container(
    //                       height: 20.h,
    //                       decoration: BoxDecoration(
    //                         color: Color(0xFFF4F4F3),
    //                         borderRadius: BorderRadius.all(Radius.circular(10)),
    //                       ),
    //                       child: TextButton(
    //                         child: Row(
    //                           children: [
    //                             Text(
    //                               '  לצפיה בשיעור ',
    //                               style: TextStyle(
    //                                   fontSize: 12.sp,
    //                                   fontWeight: FontWeight.w600,
    //                                   color: Color(0xFF2D2828)),
    //                             ),
    //                             Icon(Icons.arrow_forward,size: 10.sp,color: Color(0xFF2D2828),)
    //                           ],
    //                         ),
    //                         onPressed: () {
    //                           setState(() {
    //                             print(widget.subject.lessons
    //                                 .elementAt(i)
    //                                 .name);
    //                             currentMainChild?.lessonPickedIndex=i;
    //                            currentMainChild?.lastSubjectPickedIndex=widget.subjectIndex;
    //                             currentMainChild?.bodyWidget = LessonWidget(
    //                               lesson: widget.subject.lessons.elementAt(i),
    //                                 onNext:i + 1 < widget.subject.lessons.length
    //                                     ?()=>currentMainChild.goToNextLesson
    //                                   (widget.subject,widget.subjectIndex,widget.subject.lessons.elementAt(i+1),i+1):null
    //                             );
    //                           });
    //                         },
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             //  SizedBox(height: 21.h),
    //               SizedBox(
    //                   height: 40.h,
    //                 child: Row(
    //                   children: [
    //                     Stack(
    //                       alignment: AlignmentDirectional.center,
    //                       children: [
    //                         VerticalDivider(color: widget.subject.lessons.elementAt(i).isCompleted
    //                             ?Color(0xFF62FFB8)
    //                             :Color(0xFFE4E6E9),
    //                           thickness: 3.w,
    //                           indent: i==0?25.h:null,
    //                           endIndent: i==widget.subject.lessons.length-1?20.h:null,
    //                         ),
    //                         //currentSubject.lessons.isNotEmpty &&
    //                         widget.subject.lessons.elementAt(i).isCompleted?
    //                         Icon(Icons.check_circle,color: Color(0xFF62FFB8),size: 20.sp,):
    //                         Container(
    //                           height: 18.h,
    //                           width: 18.w,
    //                           decoration: BoxDecoration(
    //                               shape: BoxShape.circle,
    //                               border: Border.all(color: Color(0xFFE4E6E9),width: 3.w),
    //                               color: Color(0xFFFAFAFA)
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                     SizedBox(width: 35.w,),
    //                     Icon(Icons.create_outlined,size: 13.sp,),
    //                     SizedBox(width: 14.h),
    //                     Text(
    //                       'תרגול - ${widget.subject.lessons.elementAt(i).name}',
    //                       style: TextStyle(fontSize: 16.sp),
    //                     ),
    //                     Spacer(),
    //                     Container(
    //                       height: 20.h,
    //                       decoration: BoxDecoration(
    //                         color: Color(0xFFF4F4F3),
    //                         borderRadius: BorderRadius.all(Radius.circular(10)),
    //                       ),
    //                       child: TextButton(
    //                         child: Row(
    //                           children: [
    //                             Text(
    //                               '  לתרגול ',
    //                               style: TextStyle(
    //                                   fontSize: 12.sp,
    //                                   fontWeight: FontWeight.w600,
    //                                   color: Color(0xFF2D2828)),
    //                             ),
    //                             Icon(Icons.arrow_forward,size: 10.sp,color: Color(0xFF2D2828),)
    //                           ],
    //                         ),
    //                         onPressed: () {
    //                           setState(() {
    //                             currentMainChild?.lessonPickedIndex=i;
    //                             currentMainChild?.lastSubjectPickedIndex=widget.subjectIndex;
    //                             MainPageChild.of(context)
    //                                     ?.bodyWidget =
    //                                 QuestionnaireWidget(
    //                                   title:  'תרגול - ${widget.subject.lessons.elementAt(i).name}' ,
    //                                     questionnaires: widget
    //                                         .subject.lessons
    //                                         .elementAt(i)
    //                                         .questionnaire);
    //                           });
    //                         },
    //                       ),
    //                         ),
    //                       ],
    //                     ),
    //               ),
    //               SizedBox(height:10.h,width: double.infinity,),
    //
    //             ],
    //               )
    //             ],
    //           ]
    //       ),
    //     ),
    //
    //    /* Column(
    //       children: [
    //         for (int i = 0; i < widget.subject.lessons.length; i++) ...[
    //         Divider(),
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 Icon(Icons.videocam_outlined,size: 13.sp,),
    //                 SizedBox(width: 14.h),
    //                 Text(
    //                     widget.subject.lessons.elementAt(i).name,
    //                     style: TextStyle(
    //                       fontSize: 16.sp,
    //                       fontWeight: FontWeight.w600,
    //                     )
    //                 ),
    //                 Spacer(),
    //                 Container(
    //                   height: 20.h,
    //                   decoration: BoxDecoration(
    //                     color: Color(0xFFF4F4F3),
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   child: TextButton(
    //                     child: Row(
    //                       children: [
    //                         Text(
    //                           '  לצפיה בשיעור ',
    //                           style: TextStyle(
    //                               fontSize: 12.sp,
    //                               fontWeight: FontWeight.w600,
    //                               color: Color(0xFF2D2828)),
    //                         ),
    //                         Icon(Icons.arrow_forward,size: 10.sp,color: Color(0xFF2D2828),)
    //                       ],
    //                     ),
    //                     onPressed: () {
    //                       setState(() {
    //                         print(widget.subject.lessons
    //                             .elementAt(i)
    //                             .name);
    //                         MainPageChild.of(context)
    //                             ?.bodyWidget = LessonWidget(
    //                             lessonIndex: i,
    //                             lessons: widget.subject.lessons,
    //                             backToSubject: (BuildContext context) =>
    //                             MainPageChild.of(context)
    //                                 ?.bodyWidget =
    //                                 SubjectMainPage(
    //                                     subject:
    //                                     widget.subject)
    //                           // nextLesson: widget.subject.lessons.length>i+1?setNextLesson(widget.subject.lessons, i+1):null
    //                         );
    //                       });
    //                     },
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             SizedBox(height: 21.h),
    //             Row(
    //               children: [
    //                 Icon(Icons.create_outlined,size: 13.sp,),
    //                 SizedBox(width: 14.h),
    //                 Text(
    //                   'תרגול - ${widget.subject.lessons.elementAt(i).name}',
    //                   style: TextStyle(fontSize: 16.sp),
    //                 ),
    //                 Spacer(),
    //                 Container(
    //                   height: 20.h,
    //                   decoration: BoxDecoration(
    //                     color: Color(0xFFF4F4F3),
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   child: TextButton(
    //                     child: Row(
    //                       children: [
    //                         Text(
    //                           '  לתרגול ',
    //                           style: TextStyle(
    //                               fontSize: 12.sp,
    //                               fontWeight: FontWeight.w600,
    //                               color: Color(0xFF2D2828)),
    //                         ),
    //                         Icon(Icons.arrow_forward,size: 10.sp,color: Color(0xFF2D2828),)
    //                       ],
    //                     ),
    //                     onPressed: () {
    //                       setState(() {
    //                         MainPageChild.of(context)
    //                             ?.bodyWidget =
    //                             QuestionnaireWidget(
    //                                 title:  'תרגול - ${widget.subject.lessons.elementAt(i).name}' ,
    //                                 questionnaires: widget
    //                                     .subject.lessons
    //                                     .elementAt(i)
    //                                     .questionnaire);
    //                       });
    //                     },
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //         ]
    //       ],
    //     )*/
    //   ],
    // )

    //]),
  }

  progressIcon(int index,bool isLesson) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        VerticalDivider(
          color: widget.subject.lessons.elementAt(index).isCompleted
              ? Color(0xFF62FFB8)
              : colors.grey2ColorApp,
          thickness: 3.w,
          indent: index == 0  && isLesson? 25.h : null,
          endIndent: index == widget.subject.lessons.length - 1  && !isLesson? 20.h : null,
        ),
        widget.subject.lessons.elementAt(index).isCompleted
            ? Icon(
                Icons.check_circle,
                color: Color(0xFF62FFB8),
                size: 20.sp,
              )
            : Container(
                height: 18.h,
                width: 18.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.grey2ColorApp, width: 3.w),
                    color: Color(0xFFFAFAFA)),
              )
      ],
    );
  }

  // backToSubject(Subject subject) {
  //   MainPageChild.of(context)?.bodyWidget = SubjectMainPage(subject: subject);
  // }

  @override
  void didChangeDependencies() {
    currentMainChild = MainPageChild.of(context);
    super.didChangeDependencies();
  }
}
