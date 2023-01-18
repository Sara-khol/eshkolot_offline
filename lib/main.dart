import 'package:eshkolot_offline/isar_service.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/ui/screens/course_main/course_main_page.dart';
import 'package:flutter/material.dart';

import 'models/course.dart';
import 'models/lesson.dart';
import 'models/questionnaire.dart';
import 'dart:convert';
import 'package:dio/dio.dart';



late Course? course;

Future<void> main() async {
  IsarService.instance.init();
 await initData();
 await connectToVimoe();
  runApp(MyApp());
}

initData() async {
 if(await IsarService.instance.checkIfDBisEmpty()) {

   Map<String, List<String>> fillInQ = {
     'ab': ['c'],
     'd e f': ['g'],
     'h': []
   };


      List<Questionnaire> questionnaires = [
        Questionnaire()
          ..question = 'שאלת אפשרות יחידה'
          ..optionA = 'אופציה א'
          ..optionB = 'אופציה ב'
          ..optionC = 'אופציה ג'
          ..optionD = 'אופציה ד'
          ..ans = ['אופציה ג']
          ..type = QType.radio,
        Questionnaire()
          ..question = 'שאלת בחירה מרובה'
          ..optionA = 'אופציה א'
          ..optionB = 'אופציה ב'
          ..optionC = 'אופציה ג'
          ..optionD = 'אופציה ד'
          ..ans = ['אופציה ג','אופציה א']
          ..type = QType.checkbox,
        Questionnaire()
          ..question = 'שאלת בחירה חופשית'
          ..ans = ['אופציה ג','אופציה א']
          ..type = QType.freeChoice,
        Questionnaire()
          ..question = 'שאלה מלא את החסר'
          ..fillInQuestion=json.encode(fillInQ)
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
      print('data is filled');
}

connectToVimoe() async
 {
   // String token='fb7f92745521f268deae101b7e3abbc4';
   // String token='4eda357f555a3eef86e254b9bf012d85';//privet
   String token='adf22872bed862a3aa5993a3133c5fa2';//privet video files
   int videoId=789969851;
   Dio dio =  Dio();
   dio.options.headers['content-Type'] = 'application/json;charset=UTF-8';
   dio.options.headers["authorization"] = "bearer ${token}";
   // Response response = await dio.get('https://api.vimeo.com/apps/1bba3dc3af2a22c466bfcd4f15817a600b0284e7');
   Response response = await dio.get('https://api.vimeo.com/videos/${videoId}');

   Map result = response.data;
   print('privacy ${result['privacy']}');

   print("data ${response.data}");
   print("headers ${response.headers}");
   print("requestOptions ${response.requestOptions}");
   print("statusCode ${response.statusCode}");
;
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
