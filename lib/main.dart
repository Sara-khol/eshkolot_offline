import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/ui/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_size/window_size.dart';
import 'models/course.dart';
import 'models/knowledge.dart';
import 'models/lesson.dart';
import 'models/questionnaire.dart';
import 'dart:convert';
import 'package:bitsdojo_window/bitsdojo_window.dart';

Future<void> main() async {



  IsarService.instance.init();
  await initData();
  runApp(MyApp());

  doWhenWindowReady(() {
    setWindowVisibility(visible: true);
    setWindowTitle('My Demo');
    // const initialSize = Size(1280, 720);
    // appWindow.minSize = initialSize;
    // appWindow.size = initialSize;
    // appWindow.alignment = Alignment.center;
    //
    // appWindow.show();
  });
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
        ..options = ['אופציה א', 'אופציה ב', 'אופציה ג', 'אופציה ד']
        ..ans = ['אופציה ג']
        ..type = QType.radio,
      Questionnaire()
        ..question = 'שאלת בחירה מרובה'
        ..options = ['אופציה א', 'אופציה ב', 'אופציה ג', 'אופציה ד']
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
      ..subjects.addAll(subjects)
      ..serverId = 2567060
      ..status = Status.middle));
    myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 2782842
      ..status = Status.finish);




    myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 55
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 66
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 77
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 88
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 99
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 00
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 678
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 890
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 65
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 32
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 6754
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 5678
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 898
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 8890
      ..status = Status.finish);  myCourses.add(Course()
      ..title = 'אנגלית בסיסית ב'
      ..serverId = 9090
      ..status = Status.finish);


    Course algebraCourse = Course()
      ..title = 'אלגברה בסיסית א’'
      ..serverId = 1
      ..status = Status.synchronized;
    Course phCourse = Course()
      ..title = 'פיזיקה רעיונית א’'
      ..serverId = 2;
    List<Knowledge> knowledgeList = [
      Knowledge()
        ..title = 'אנגלית'
        ..color = 0xff32D489
        ..iconPath = 'english'
        ..isOpen=false
        ..courses.addAll(myCourses)..id=1,
      Knowledge()
        ..title = 'מתמטיקה'
        ..color = 0xff5956DA
        ..iconPath = 'math'
        ..isOpen=false
        ..courses.add(algebraCourse)..id=2,
      Knowledge()
        ..title = 'פיזיקה'
        ..color = 0xffFF317B
        ..iconPath = 'math'
        ..isOpen=false
        ..courses.add(phCourse)..id=3
    ];
    List<Course> meymadList = [
      algebraCourse,
      Course()
        ..title = 'אלגברה בסיסית ב’'
        ..serverId = 5
        ..status = Status.synchronized,
      Course()
        ..title = 'קורס גאומטריה בסיסית'
        ..serverId = 6
        ..status = Status.synchronized
    ];

    List<LearnPath> paths = [
      LearnPath()
        ..id = 1
        ..title = 'מסלול אמירם'
        ..courses.addAll(myCourses)..color=0xff32D489..iconPath='english',
      LearnPath()
        ..id = 2
        ..title = 'מסלול מימד'
        ..courses.addAll(meymadList)..color=0xff5956DA..iconPath='math',
    ];

    // User user= User()..courses.addAll(myCourses);
    final List<User> users = [
      User()
        ..name = 'שמואל'
        ..knowledgeIds=[1,2,3]
        ..pathIds=[1,2]..tz='123456789'
    ];
    // final List<User> users=[User()..courses.addAll([UserCourse()..courseId=myCourses[0].id..status=Status.middle
    //   ..lessonStopId=myCourses[0].subjects.elementAt(0).lessons.elementAt(0).id,
    //   UserCourse()..courseId=myCourses[1].id..status=Status.start,
    //   UserCourse()..courseId=myCourses[0].id..status=Status.start]
    // )];
    print('filling!!');
    await IsarService.instance.initCourses(myCourses, subjects, lessons,
        questionnaires, knowledgeList, users, paths);
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
            debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: LoginPage());
        });
  }
}
