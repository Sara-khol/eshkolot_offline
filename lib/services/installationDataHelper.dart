import 'dart:convert';
import 'dart:io';
import 'package:collection/src/iterable_extensions.dart';


import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/course.dart';
import '../models/user.dart';

class InstallationDataHelper {
  InstallationDataHelper._privateConstructor();

  static final InstallationDataHelper _instance =
      InstallationDataHelper._privateConstructor();

  factory InstallationDataHelper() => _instance;

  late Map<String, dynamic> data;

  late List<dynamic> users;
  List<Course> myCourses = [];
  List<Subject> mySubjects = [];
  List<Lesson> myLessons = [];
  List<Knowledge> myKnowledgeList = [];
  List<LearnPath> myPathList = [];
  List<Quiz> myQuizzes = [];
  List<Quiz> testQuizzes = [];


  init() async {
    late String destDirPath;
    final Directory directory = await getApplicationSupportDirectory();
    destDirPath = directory.path;
    //  try {
    final file = await File('$destDirPath/download_software.json');
    //  final file = await File('$destDirPath/download_software(2).json');
    //  final file = await File('$destDirPath/download_software(7).json');
    final contents = await file.readAsString();
    data = await json.decode(contents);
    await setDataFromJson();
    // }
    // catch (e) {
    // debugPrint("error $e");
    // }
  }

  setDataFromJson() async {
    // try{
    debugPrint('set data from json');
    users = data['users'] as List<dynamic>;
    Map<String, dynamic> courses = data['courses'] as Map<String, dynamic>;
    Map<String, dynamic> subjects = data['subjects'] as Map<String, dynamic>;
    Map<String, dynamic> lessons = data['lessons'] as Map<String, dynamic>;
    Map<String, dynamic> questionnaires = data['questionnaire'] as Map<String, dynamic>;
    Map<String, dynamic> questionnairesTest = data['testing_question'] as Map<String, dynamic>;
    Map<String, dynamic> knowledgeAreas =
        data['knowledge'] as Map<String, dynamic>;
    Map<String, dynamic> learnPaths = data['learnPath'] as Map<String, dynamic>;

    for (var user in users) {
      debugPrint('user ${user['name']}');
      List<dynamic> userKnowledgeIds = user['knowledgeIds'] as List<dynamic>;
      myKnowledgeList.addAll(userKnowledgeIds.map((kId) {
        //  if(myKnowledgeList.firstWhereOrNull((k) => k.id==kId)==null) {
        var k = knowledgeAreas[kId.toString()];
        Knowledge knowledge = Knowledge.fromJson(k, kId);
       // user['ddd'] = knowledge.toJson();
        return knowledge;
        // }
      }).toList());

      //get courses data of user and save on isar

      List<dynamic> userCoursesJson = user['UserCourse'] as List<dynamic>;
      //check if course already exists
      List<UserCourse> userCourses = userCoursesJson.map((courseJson) {
        final userCourse = UserCourse();

        //set user courses with correct data , done for converting to right enum status
        userCourse.setComputedPropertyFromJson(courseJson);

        var c = courses[userCourse.courseId.toString()];
        Course course = Course.fromJson(c, userCourse.courseId);

        // //add course to correct knowledge list
        // myKnowledgeList
        //     .firstWhere((k) => k.id == course.knowledgeId)
        //     .courses
        //     .add(course);




        for (int subjectId in course.subjectIds) {
          var s = subjects[subjectId.toString()];
          Subject subject = Subject.fromJson(s, subjectId);

          for (int lessonId in subject.lessonsIds) {
            var l = lessons[lessonId.toString()];
            Lesson lesson = Lesson.fromJson(l, lessonId);

            for (int qId in lesson.questionnaireIds) {
              var q = questionnaires[qId.toString()];

              Quiz quiz = Quiz.fromJson(q, qId);
              lesson.questionnaire.add(quiz);
              myQuizzes.add(quiz);
            }
            subject.lessons.add(lesson);
            myLessons.add(lesson);
          }

          for (int qId in subject.questionnaireIds) {
            var q = questionnaires[qId.toString()];

            Quiz quiz = Quiz.fromJson(q, qId);
            subject.questionnaire.add(quiz);
            myQuizzes.add(quiz);
          }

          course.subjects.add(subject);
          mySubjects.add(subject);
        }
    //todo remove  just for testing
        if(course.serverId==78407)
          {
            course.questionnaireIds.addAll([66164,82517,111897,128955,129722]);
          }

        for (int qId in course.questionnaireIds) {
          var q = questionnaires[qId.toString()];
          q ??= questionnairesTest[qId.toString()];
          Quiz quiz = Quiz.fromJson(q, qId);
          // debugPrint('quiz ${quiz.id}');
          // for(Question question  in quiz.questionnaireList)
          //   {
          //     debugPrint('q ${question.question}');
          //     debugPrint('op ${question.options}');
          //
          //   }
          course.questionnaires.add(quiz);
          myQuizzes.add(quiz);



          // Subject1 tryQ = Subject1.fromJson( qId);
          // course.questionnaires.add(tryQ);
          // myTries.add(tryQ);

        }
        myCourses.add(course);
        return userCourse;
      }).toList();

      List<dynamic> userPathIds = user['pathIds'] as List<dynamic>;
      //check if path already existed
      myPathList.addAll(userPathIds.map((pId) {
        var p = learnPaths[pId.toString()];
        LearnPath path = LearnPath.fromJson(p, pId);

        for (int courseId in path.coursesIds) {
          Course? c =
              myCourses.firstWhereOrNull((element) => element.serverId == courseId);
        //todo is a problem in json file ?
          if(c!=null) {
            path.courses.add(c);
          }
        }

        return path;
      }).toList());

      user['UserCourse'] = userCourses.map((uc) => uc.toJson()).toList();
    }

    // final userCoursesJson = data['users'][0]['UserCourse'] as List<dynamic>;
    // final userCourses = userCoursesJson
    //     .map((courseJson) {
    //   final userCourse = UserCourse();
    //   userCourse.setComputedPropertyFromJson(courseJson);
    //   return userCourse;
    // }).toList();
    //
    // data['users'][0]['UserCourse'] = userCourses.map((uc) => uc.toJson()).toList();

    // } catch (e,s) {
    //   debugPrint("error in getting data $e");
    //   debugPrint("stack $s");
    //
    // }
  }

  setAllDataCourse(Course course) {}
}
