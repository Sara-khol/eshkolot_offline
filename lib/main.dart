import 'package:eshkolot_offline/isar_service.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/ui/screens/course_main/course_main_page.dart';
import 'package:flutter/material.dart';

import 'models/course.dart';
import 'models/lesson.dart';
import 'models/questionnaire.dart';

late Course? course;

Future<void> main() async {
  IsarService.instance.init();
 await initData();
  runApp(MyApp());
}

initData() async {
  await IsarService.instance.getAllCourses().then((list) async {
    if (list.isEmpty) {
      List<Questionnaire> questionnaires = [
        Questionnaire()
          ..question = 'שאלה לשיעור מבוא ואותיות ניקוד'
          ..optionA = 'אופציה א'
          ..optionB = 'אופציה ב'
          ..optionC = 'אופציה ג'
          ..optionD = 'אופציה ד'
          ..ans = ['אופציה ג']
          ..type = QType.oneOption,
        Questionnaire()
          ..question = 'שאלה לנושא חוקי קריאה והגיה'
          ..optionA = 'אופציה א'
          ..optionB = 'אופציה ב'
          ..optionC = 'אופציה ג'
          ..optionD = 'אופציה ד'
          ..ans = ['אופציה ג', 'אופציה א']
          ..type = QType.manyOptions
      ];

      List<Lesson> lessons = [
        Lesson()
          ..name = 'מבוא ואותיות ניקוד'
          ..questionnaire.value = questionnaires.first,
        Lesson()..name = 'אותיות עיצור א',
        Lesson()..name = 'אותיות עיצור ב',
        Lesson()..name = 'אותיות עיצור ג',
        Lesson()..name = 'אותיות עיצור ד',
        Lesson()..name = 'אותיות עיצור ה',
        Lesson()..name = 'אותיות עיצור ו',
        Lesson()..name = 'אותיות עיצור ז',
        Lesson()..name = 'אותיות עיצור ח',
        Lesson()..name = 'אותיות עיצור ט',
        Lesson()..name = 'אותיות עיצור י',
        Lesson()..name = 'אותיות עיצור כ',
        Lesson()..name = 'אותיות עיצור ל',
        Lesson()..name = 'אותיות עיצור מ',
      ];

      final List<Subject> subjects = [
        Subject()
          ..name = 'חוקי קריאה והגיה'
          ..lessons.addAll(lessons)
          ..questionnaire.value=questionnaires[1],
        Subject()
          ..name = 'מבנה המשפט התיאורי'
          //..lessons.add(lessons[0])
      ];

      final List<Course> myCourses = [
        (Course()
          ..title = 'אנגלית בסיסית א'
          ..subjects.addAll(subjects)),
        (Course()..title = 'אנגלית בסיסית ב')
      ];

      print('filling!!');
      await IsarService.instance
          .initCourses(myCourses, subjects, lessons, questionnaires);
      course = await IsarService.instance.getFirstCourse();
    } else
      print('length ${list.length}');
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<Course?>(
          future: getFirstEnglishCourse(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              course = snapshot.data;
              return CourseMainPage(course: course!);
            }
            print('wait...');
            return const CircularProgressIndicator();
          }),
    );
  }

  Future<Course?> getFirstEnglishCourse() async {
    return await IsarService.instance.getFirstCourse();
  }
}
