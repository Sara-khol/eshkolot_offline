import 'package:eshkolot_offline/utils/my_colors.dart' as colors;
import 'package:eshkolot_offline/ui/screens/course_main/main_page_child.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/video_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/lesson.dart';

class LessonWidget extends StatefulWidget {
  final Lesson lesson;
  final VoidCallback? onNext;
  final Function(int) updateComplete;

  const LessonWidget(
      {super.key,
      required this.lesson,
      required this.onNext,
      required this.updateComplete});

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  bool checkedValue = false;
  late Lesson lesson;

  // Player player = Player(id: 0);

  @override
  void initState() {
    super.initState();
    lesson = widget.lesson;
    // InstallationDataHelper().eventBusLessonPage.on().listen((event) {
    //   lesson.isCompletedCurrentUser=event as bool;
    //   if(mounted) {
    //     setState(() {});
    //   }
    // });

    debugPrint('lesson initState isComplete ${lesson.isCompletedCurrentUser}');
  }

  @override
  void didUpdateWidget(covariant LessonWidget oldWidget) {
    lesson = widget.lesson;
    debugPrint(
        'lesson didUpdateWidget isComplete ${lesson.isCompletedCurrentUser}');

    // if (widget.lesson.id != oldWidget.lesson.id) {
    //   player.dispose();
    //   player = Player(id: widget.lesson.id);
    // }
    // Sentry.captureMessage(' didUpdateWidget player ${player.id}');
    // print('player ${player.id}');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return bodyWidget();
  }

  Widget bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 624.h,
           // width: 950.w,
            margin: EdgeInsets.only(left:242.w,right: 120.w),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE4E6E9)),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                SizedBox(
                  height: 32.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 19.w,
                    ),
                    Icon(
                      Icons.videocam,
                      size: 28.sp,
                    ),
                    SizedBox(
                      width: 23.w,
                    ),
                    Expanded(
                      child: Text(
                        '${lesson.name} ${lesson.videoNum}',
                        // overflow:TextOverflow.ellipsis ,
                        style: TextStyle(
                        height: 1,
                            fontSize: 36.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    // SizedBox(
                    //   width: 32.w,
                    // ),
                    Icon(
                      Icons.access_time,
                      size: 15.sp,
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    Text(
                      widget.lesson.time,
                      style: TextStyle(
                          fontSize: 16.sp, color: colors.blackColorApp),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                        height: 20.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                            color: lesson.isCompletedCurrentUser
                                ? colors.lightGreen2ColorApp
                                : colors.lightBlueColorApp,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            lesson.isCompletedCurrentUser ? 'הושלם' : 'בלמידה',
                            //  textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: colors.blackColorApp,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                    SizedBox(
                      width: 18.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 22.h,
                ),
                /*videoWidget*/
                VideoWidget(
                    key: Key(lesson.vimeo.toString()),
                    videoNum: lesson.videoNum,
                    isLesson: true,
                    height: 515.h,
                    width: 914.w,
                    fileId: MainPageChild.of(context)!.widget.course.id,
                    videoId: MainPageChild.of(context)!.widget.course.isSync
                        ? lesson.vimeo
                        : lesson.videoNum),
                SizedBox(
                  height: 21.h,
                )
              ],
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
          if (lesson.questionnaire.isNotEmpty)
            Container(
             // width: 950.w,
             // height: 66.h,
              margin: EdgeInsets.only(left:242.w,right: 120.w),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE4E6E9)),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: lesson.questionnaire.length,
                  itemBuilder: (ctx, qIndex) {
                    return Container(
                      padding: EdgeInsets.only(left: 18.w, right: 18.w),
                      height: 66.h,
                      width: 950.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.create,
                            size: 19.sp,
                          ),
                          SizedBox(
                            width: 33.w,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () =>goToQuiz(qIndex),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.only(right: 5.w,left: 5.w,top: 5.h,bottom: 5.h),
                                  minimumSize: Size.zero,
                                  textStyle: TextStyle(fontFamily: 'RAG-Sans')
                              ),
                                child: Text(

                                  lesson.questionnaire.elementAt(qIndex).title,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: colors.blackColorApp,
                                      fontSize: 22.sp, fontWeight: FontWeight.w600),
                                )),
                            ),
                          ),
                         // Spacer(),
                          SizedBox(width: 65.w),
                          Icon(Icons.access_time, size: 14.sp),
                          Text(
                            "  30 דק'  ",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          //  Spacer(),
                          SizedBox(width: 10.w),
                          Container(
                            height: 20.h,
                            //width: 70.w,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color(0xFFF4F4F3)),
                            child: TextButton(
                              child: Row(
                                children: [
                                  Text(
                                    '  לתרגול ',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF2D2828)),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 10.sp,
                                    color: const Color(0xFF2D2828),
                                  )
                                ],
                              ),
                              onPressed: () =>goToQuiz(qIndex),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          SizedBox(
            // height: 62.h,
            height: 60.h,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20.h ,left: 242.w),

            // width: 950.w,
            child: Row(
              children: [
                const Spacer(),
                Visibility(
                  visible: widget.onNext != null,
                  child: Container(
                    height: 40.h,
                  //  margin: EdgeInsets.only(bottom: 20.h ,left: 242.w),
                    decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                        color: Color( MainPageChild.of(context)!.widget.knowledgeColor != -1
                            ? MainPageChild.of(context)!.widget.knowledgeColor
                            : 0xFF32D489)),
                    child: TextButton(
                      child: Row(
                        children: [
                          Text(
                            '  לשיעור הבא ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 16.sp,
                            color: Colors.white,
                          )
                        ],
                      ),
                      onPressed: () async {
                        // lesson= await IsarService().updateLessonCompleted(lesson.id);
                        widget.updateComplete(widget.lesson.lessonId);
                        widget.onNext!();
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  goToQuiz(int qIndex)
  {
    setState(() {
      MainPageChild.of(context)
          ?.questionPickedIndex = qIndex;
      MainPageChild.of(context)?.bodyWidget =
          QuestionnaireWidget(
              quiz: lesson.questionnaire
                  .elementAt(qIndex),onNext: widget.onNext,);
    });
  }

  @override
  void dispose() {
    // player.stop();
    super.dispose();
  }
}
