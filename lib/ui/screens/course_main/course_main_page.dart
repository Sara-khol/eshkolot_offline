import 'package:eshkolot_offline/ui/screens/course_main/lesson_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../isar_service.dart';
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
          children: [
            Container(
              color: Colors.grey.shade100,
              width: screenSize.width * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: Colors.blueAccent,
                    child: Center(
                      child: Text(
                        widget.course.title,
                        style: TextStyle(color: Colors.white, fontSize: 25),
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
                                  padding: const EdgeInsets.all(10.0),
                                  height: 50,
                                  width: double.infinity,
                                  color: Colors.cyan,
                                  child: Text(currentSubject.name)),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: currentSubject.lessons.length,
                                  itemBuilder: (ctx, lIndex) {
                                    Lesson currentLesson = currentSubject
                                        .lessons
                                        .elementAt(lIndex);
                                    return Center(
                                        child: Column(
                                      children: [
                                        ListTile(
                                            title: Text(currentLesson.name),
                                            onTap: () => setState(() =>
                                                mainWidget = LessonWidget(
                                                    lesson: currentLesson))),
                                        if (currentLesson.questionnaire.isNotEmpty)
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              mainWidget = QuestionnaireWidget(
                                                  questionnaire: currentLesson
                                                      .questionnaire.elementAt(0));
                                            }),
                                            child: Container(
                                              color:
                                                  Colors.greenAccent.shade100,
                                              child: ListTile(
                                                  title: Text(currentLesson
                                                      .questionnaire
                                                      .elementAt(0)
                                                      .question!)),
                                            ),
                                          ),
                                      ],
                                    ));
                                  }),
                              if (currentSubject.questionnaire.isNotEmpty)
                                GestureDetector(
                                  onTap: () => setState(() {
                                    mainWidget = QuestionnaireWidget(
                                        questionnaire: currentSubject
                                            .questionnaire.elementAt(0));
                                  }),
                                  child: Container(
                                    width: double.infinity,
                                    height: 40,
                                    color: Colors.black26,
                                    child: Center(
                                      child: Text(currentSubject
                                          .questionnaire.elementAt(0).question!),
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
            ),
            Expanded(child: mainWidget)
          ],
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     showModalBottomSheet(
        //         context: context,
        //         builder: (context) {
        //           return CourseModal(service);
        //         });
        //   },
        //   child: const Text("Add Course"),
        // ),
        // const SizedBox(height: 8),
        // ElevatedButton(
        //   onPressed: () {
        //     showModalBottomSheet(
        //         context: context,
        //         builder: (context) {
        //           return StudentModal(service);
        //         });
        //   },
        //   child: const Text("Add Student"),
        // ),
        // const SizedBox(height: 8),
        // ElevatedButton(
        //   onPressed: () {
        //     showModalBottomSheet(
        //         context: context,
        //         builder: (context) {
        //           return TeacherModal(service);
        //         });
        //   },
        //   child: const Text("Add Teacher"),
        // ),
        // const SizedBox(height: 8),
        //],
      ),
    );
  }
}
