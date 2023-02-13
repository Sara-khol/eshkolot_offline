import 'package:eshkolot_offline/ui/screens/course_main/lesson_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      color: Color.fromARGB(255, 249, 249, 249),
      width: screenSize.width * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 74.h,
            color: Color.fromARGB(255, 110, 112, 114),
            child: Row(children: [
              Padding(
                padding: EdgeInsets.all(12.w),
                child: FaIcon(
                  FontAwesomeIcons.file,
                  size: 15.w,
                  color: Colors.white,
                ),
              ),
              Text(
                widget.course.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
            ]),
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
                        height: 96.h,
                        width: double.infinity,
                        color: Color.fromARGB(255, 249, 249, 249),
                        child: Center(
                          child: Row(
                            children: [
                              const Padding(
                              padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.circle_outlined, size: 15),
                              ),
                              Text(
                              currentSubject.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ],
                          )
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 55.w),
                        child: ListView.builder(
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
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight:
                                          lessonPickedIndex == lIndex
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                      )
                                    ),
                                    leading: currentLesson.isCompleted
                                    ? Visibility(
                                        visible: currentLesson.isCompleted,
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Color.fromARGB(
                                              255, 45, 40, 40),
                                          size: 14,
                                        )
                                    )
                                      : const Visibility(
                                          maintainSize: true,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          child: Icon(
                                            Icons.circle_outlined,
                                            color: Color.fromARGB(
                                                255, 228, 230, 233),
                                            size: 15,
                                          )),
                                      onTap: () {
                                        if (lIndex == 0 || currentSubject.lessons.elementAt(lIndex - 1).isCompleted) {
                                          setState(() => mainWidget =
                                          LessonWidget(
                                              lesson: currentLesson,
                                              notifyParent: refresh));
                                      lessonPickedIndex = lIndex;
                                    } else {
                                      showAlert();
                                    }
                                  }),
                              //const Divider(height: 1, color: Colors.black12),
                              if (currentLesson.questionnaire.isNotEmpty)
                                GestureDetector(
                                  onTap: () => setState(() {
                                    mainWidget = QuestionnaireWidget(
                                        key: UniqueKey(),
                                        questionnaires:
                                            currentLesson.questionnaire);
                                  }),
                                  child: Container(
                                    color: Color.fromARGB(255, 249, 249, 249),
                                    child: ListTile(
                                        title: Center(
                                          child: Row(children: [
                                            Icon(
                                              Icons.create,
                                              color: currentLesson.isCompleted
                                              ? Color.fromARGB(
                                                  255, 45, 40, 40)
                                              : Color.fromARGB(
                                                  255, 228, 230, 233),
                                              size: 20,
                                            ),
                                            Text('תרגול - ${currentLesson.name}',
                                            style: TextStyle(
                                                decoration: TextDecoration
                                                    .underline)),
                                      ]),
                                    )),
                                  ),
                                ),
                              ],
                            ));
                          },
                        ),
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
                              child: Text(currentSubject.questionnaire.elementAt(0).question),
                            ),
                          ),
                        )
                    ],
                  );
                }
            ),
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
