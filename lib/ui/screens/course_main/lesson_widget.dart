import 'package:eshkolot_offline/utils/my_colors.dart' as colors;
import 'package:eshkolot_offline/ui/screens/course_main/main_page_child.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/video_widget.dart';
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
            width: 950.w,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE4E6E9)),
                borderRadius: BorderRadius.all(Radius.circular(10))),
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
                    fileId: MainPageChild.of(context)!.widget.course.id,
                    vimoeId: MainPageChild.of(context)!.widget.course.isSync
                        ? lesson.vimeo
                        : lesson.videoNum),
                SizedBox(
                  height: 22.h,
                )
              ],
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
          if (lesson.questionnaire.isNotEmpty)
            Container(
              width: 950.w,
              // height: 66.h,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE4E6E9)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
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
                            child: Text(
                              'תרגול - ${lesson.name} ${qIndex + 1}',
                              style: TextStyle(
                                  fontSize: 22.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(width: 65.h),
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
                            decoration: BoxDecoration(
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
                                        color: Color(0xFF2D2828)),
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
                                  MainPageChild.of(context)
                                      ?.questionPickedIndex = qIndex;
                                  MainPageChild.of(context)?.bodyWidget =
                                      QuestionnaireWidget(
                                          quiz: lesson.questionnaire
                                              .elementAt(qIndex));
                                });
                                // QuestionnaireWidget(key: UniqueKey(),questionnaires: widget.subject.lessons.elementAt(lessonIndex).questionnaire);
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          SizedBox(
            height: 62.h,
          ),
          SizedBox(
            width: 950.w,
            child: Row(
              children: [
                Spacer(),
                Visibility(
                  visible: widget.onNext != null,
                  child: Container(
                    height: 40.h,
                    margin: EdgeInsets.only(bottom: 37.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xFF32D489)),
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

  @override
  void dispose() {
    // player.stop();
    super.dispose();
  }
}
