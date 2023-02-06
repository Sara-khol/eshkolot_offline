import 'package:eshkolot_offline/ui/screens/course_main/lesson_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/isar_service.dart';
import '../../../models/course.dart';
import '../../../models/lesson.dart';
import '../../../models/subject.dart';

class CourseMainPage extends StatefulWidget {
  const CourseMainPage({super.key, required this.course});

  final Course course;

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  Widget mainWidget = Container();
  late Size screenSize;
  int lessonPickedIndex = -1;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Isar DB Tutorial'), actions: [
        IconButton(
          onPressed: () => IsarService.instance.cleanDb(),
          icon: const Icon(Icons.delete),
        ),
      ]),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [menuWidget(), Expanded(child: mainWidget)],
        ),
      ),
    );
  }


  Widget menuWidget() {
    return Container(
      color: Colors.grey.shade100,
      width: screenSize.width * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 60.h,
            color: Colors.blueAccent,
            child: Center(
              child: Text(
                widget.course.title,
                style: TextStyle(color: Colors.white, fontSize: 25.sp),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.course.subjects.length,
                itemBuilder: (ctx, sIndex) {
                  Subject currentSubject =
                      widget.course.subjects.elementAt(sIndex);
                  return Column(
                    children: [
                      Container(
                          //padding:  EdgeInsets.all(10.w),
                          height: 50.h,
                          width: double.infinity,
                          color: Colors.cyan,
                          child: Center(child: Text(currentSubject.name))),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: currentSubject.lessons.length,
                        itemBuilder: (ctx, lIndex) {
                          Lesson currentLesson =
                              currentSubject.lessons.elementAt(lIndex);
                          return Center(
                              child: Column(
                            children: [
                              ListTile(
                                  title: Text(currentLesson.name,
                                      style: lessonPickedIndex == lIndex
                                          ? TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            )
                                          : null),
                                  leading: Visibility(
                                      visible: currentLesson.isCompleted,
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: const Icon(Icons.check_circle,color: Color(0xFF2D2828),)),
                                  onTap: () {
                                    if (lIndex == 0 ||
                                        currentSubject.lessons
                                            .elementAt(lIndex - 1)
                                            .isCompleted) {
                                      setState(() => mainWidget =
                                          LessonWidget(lesson: currentLesson,notifyParent: refresh));
                                      lessonPickedIndex = lIndex;
                                    } else {
                                      showAlert();
                                    }
                                  }),
                              const Divider(height: 1, color: Colors.black12),
                              if (currentLesson.questionnaire.isNotEmpty)
                                GestureDetector(
                                  onTap: () => setState(() {
                                    mainWidget = QuestionnaireWidget(
                                      key:  UniqueKey(),
                                        questionnaires:
                                            currentLesson.questionnaire);
                                  }),
                                  child: Container(
                                    color: Colors.greenAccent.shade100,
                                    child: ListTile(
                                        title: Center(
                                      child: Text(currentLesson.questionnaire
                                          .elementAt(0)
                                          .question),
                                    )),
                                  ),
                                ),
                            ],
                          ));
                        },
                      ),
                      if (currentSubject.questionnaire.isNotEmpty)
                        GestureDetector(
                          onTap: () => setState(() {
                            mainWidget = QuestionnaireWidget(
                              key: UniqueKey(),
                                questionnaires: currentSubject.questionnaire);
                          }),
                          child: Container(
                            width: double.infinity,
                            height: 50.h,
                            color: Colors.black26,
                            child: Center(
                              child: Text(currentSubject.questionnaire
                                  .elementAt(0)
                                  .question),
                            ),
                          ),
                        )
                    ],
                  );
                }),
          )

          //   Text(course.subjects.first.name),
          //  Text(course.subjects.first.lessons!.first.name),
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
      //iconStyle: IconStyle.information,
    );
  }
}
