import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/ui/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'models/course.dart';
import 'models/knowledge.dart';
import 'models/lesson.dart';
import 'models/questionnaire.dart';
import 'dart:convert';

Future<void> main() async {
  IsarService.instance.init();
  await initData();
  //await VimoeService().connectToVimoe();
  runApp(MyApp());
}

initData() async {
  if (await IsarService.instance.checkIfDBisEmpty()) {
    Map<String, List<String>> fillInQ = {
      'ab': ['c'],
      'd e f': ['g'],
      'h': []
    };

    List<Questionnaire> questionnaires = [
      Questionnaire()
        ..question = 'שאלת אפשרות יחידה'
        ..options=['אופציה א','אופציה ב','אופציה ג','אופציה ד']
        ..ans = ['אופציה ג']
        ..type = QType.radio,
      Questionnaire()
        ..question = 'שאלת בחירה מרובה'
        ..options=['אופציה א','אופציה ב','אופציה ג','אופציה ד']
        ..ans = ['אופציה ג', 'אופציה א']
        ..type = QType.checkbox,
      Questionnaire()
        ..question = 'שאלת בחירה חופשית'
        ..ans = ['אופציה ג', 'אופציה א']
        ..type = QType.freeChoice,
      Questionnaire()
        ..question = 'שאלה מלא את החסר'
        ..fillInQuestion = json.encode(fillInQ)
        ..type = QType.fillIn
    ];

    List<Lesson> lessons = [
      Lesson()
        ..name = 'מבוא ואותיות ניקוד'
        ..questionnaire.add(questionnaires.first),
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
        ..questionnaire.addAll(questionnaires),
      Subject()..name = 'מבנה המשפט התיאורי'
      //..lessons.add(lessons[0])
    ];


    final List<Course> myCourses = [
      // (Course()
      //   ..title = 'אנגלית בסיסית א'..serverId=3
      //   ..subjects.addAll(subjects)),
      // (Course()..title = 'אנגלית בסיסית ב'..serverId=4)
    ];

    myCourses.add((Course()
      ..title = 'אנגלית בסיסית א'
      ..subjects.addAll(subjects)..serverId=3..status=Status.middle));
    myCourses.add(Course()..title = 'אנגלית בסיסית ב'..serverId=4..status=Status.finish);

    List<Knowledge> knowledgeList = [
      Knowledge()
        ..title = 'אנגלית'
        ..color = 0xff32D489
        ..iconPath = 'english'
        ..courses.addAll(myCourses),
      Knowledge()
        ..title = 'מתמטיקה'
        ..color = 0xff5956DA
        ..iconPath = 'math'
        ..courses.add(Course()..title='אלגברה בסיסית א’'..serverId=1..status=Status.synchronized),
      Knowledge()
        ..title = 'פיזיקה'
        ..color = 0xffFF317B
        ..iconPath = 'math'
        ..courses.add(Course()..title='פיזיקה רעיונית א’'..serverId=2)];

   // User user= User()..courses.addAll(myCourses);
  final List<User> users=[User()..name='שמואל'..knowledgeList.addAll(knowledgeList)];
  // final List<User> users=[User()..courses.addAll([UserCourse()..courseId=myCourses[0].id..status=Status.middle
  //   ..lessonStopId=myCourses[0].subjects.elementAt(0).lessons.elementAt(0).id,
  //   UserCourse()..courseId=myCourses[1].id..status=Status.start,
  //   UserCourse()..courseId=myCourses[0].id..status=Status.start]
 // )];
    print('filling!!');
    await IsarService.instance
        .initCourses(myCourses, subjects, lessons, questionnaires,knowledgeList,users);
    // course = await IsarService.instance.getFirstCourse();
  } else
    print('data is filled');
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1920, 1080),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: HomePage());
        });
  }
}
