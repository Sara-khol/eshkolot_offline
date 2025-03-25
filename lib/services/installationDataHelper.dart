import 'dart:convert';
import 'dart:io';
import 'package:collection/src/iterable_extensions.dart';
import 'package:dio/dio.dart';

import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/services/api_service.dart';
import 'package:eshkolot_offline/services/download_data_service.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eshkolot_offline/utils/constants.dart' as constants;
import 'package:sentry_flutter/sentry_flutter.dart';

import '../models/course.dart';
import '../models/linkQuizIsar.dart';
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

  EventBus eventBusHomePage = EventBus();
  EventBus eventBusMainPageChild = EventBus();
  EventBus eventBusSubjectPage = EventBus();
  EventBus eventBusLessonPage = EventBus();
  EventBus eventBusQuizPage = EventBus();
  EventBus eventBusSideMenu = EventBus();
  EventBus eventBusVimeo = EventBus();
  EventBus eventBusDialogs = EventBus();

  int numOfQuizUrls = 0;
  int numOfCoursesDownloadQuiz=0;

  List<Course> coursesList = [];

  init() async {
    late String destDirPath;
    final Directory directory = await getApplicationSupportDirectory();
    destDirPath = directory.path;
    //  try {
    final file =
        File('$destDirPath/${constants.dataPath}/download_software.json');
    //  final file = await File('$destDirPath/download_software(2).json');
    //  final file = await File('$destDirPath/download_software(7).json');
    final contents = await file.readAsString();
    String cleanedJson = contents.replaceAll('\\n', '');
    data = await json.decode(cleanedJson);
    // data = await json.decode(contents);
    await setDataFromJson(data);
    // }
    // catch (e) {
    // debugPrint("error $e");
    // }
  }

  setDataFromJson(Map<String, dynamic> data) async {
    // try{
    debugPrint('set data from json');
    users = data['users'] as List<dynamic>;
    Map<String, dynamic> courses = data['courses'] as Map<String, dynamic>;
    Map<String, dynamic> subjects = data['subjects'] as Map<String, dynamic>;
    Map<String, dynamic> lessons = data['lessons'] as Map<String, dynamic>;
    Map<String, dynamic> questionnaires =
        data['questionnaire'] as Map<String, dynamic>;
    // Map<String, dynamic> questionnairesTest =
    // data['testing_question'] as Map<String, dynamic>;
    Map<String, dynamic> knowledgeAreas =
        data['knowledge'] as Map<String, dynamic>;
    Map<String, dynamic> learnPaths = data['learnPath'] as Map<String, dynamic>;
    // Map<String, dynamic> learnPaths={} /*= data['learnPath'] as Map<String, dynamic>*/;

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
        //   final userCourse = UserCourse();

        //set user courses with correct data , done for converting to right enum status
        UserCourse userCourse = UserCourse.fromJson(courseJson);

        var c = courses[userCourse.courseId.toString()];
        Course course = Course.fromJson(c, userCourse.courseId);

        // //add course to correct knowledge list
        // myKnowledgeList
        //     .firstWhere((k) => k.id == course.knowledgeId)
        //     .courses
        //     .add(course);
        // int i=0;

        if (myCourses.firstWhereOrNull((element) => element.id == course.id) ==
            null) {
          for (int subjectId in course.subjectIds) {
            var s = subjects[subjectId.toString()];
            Subject subject = Subject.fromJson(s, subjectId);

            for (int lessonId in subject.lessonsIds) {
              var l = lessons[lessonId.toString()];
              Lesson lesson = Lesson.fromJson(l, lessonId, course.id);

              for (int qId in lesson.questionnaireIds) {
                var q = questionnaires[qId.toString()];

                Quiz quiz = Quiz.fromJson(q, qId);
                for(String url in quiz.quizUrls)
                  {
                    String name = url.substring(url.lastIndexOf('/') + 1, url.length);
                    if (!isValidFileName(name)) {
                      String oldName=name;;
                      debugPrint("url: $url");
                      debugPrint("File name is not valid: $name");

                      name = '${removeUnsupportedChars(name)}.png';

                      // Proceed with saving the file
                      debugPrint("change name: $name");

                      quiz=  changeQuizUsingProblematicFileName(quiz,oldName,name);
                    }
                  }
                lesson.questionnaire.add(quiz);
                myQuizzes.add(quiz);
              }
              subject.lessonsList.add(lesson);
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
          for (int qId in course.questionnaireIds) {
            var q = questionnaires[qId.toString()];
            Quiz quiz = Quiz.fromJson(q, qId);
            course.questionnaires.add(quiz);
            myQuizzes.add(quiz);
          }
          myCourses.add(course);
        }
        return userCourse;
      }).toList();

      List<dynamic> userPathIds = user['pathIds']==null?[]:user['pathIds'] as List<dynamic>;
      //check if path already existed
      myPathList.addAll(userPathIds.map((pId) {
        var p = learnPaths[pId.toString()];
        LearnPath path = LearnPath.fromJson(p, pId);

        for (int courseId in path.coursesIds) {
          Course? c =
              myCourses.firstWhereOrNull((element) => element.id == courseId);
          //todo is a problem in json file ?
          if (c != null) {
            path.coursesPath.add(c);
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

  bool isValidFileName(String fileName) {
    RegExp regExp = RegExp(r'[<>:"/\\|?*;&]');
    return !regExp.hasMatch(fileName);
  }

  String removeUnsupportedChars(String fileName) {
    RegExp regExp = RegExp(r'[<>:"/\\|?*;&]');
    return fileName.replaceAll(regExp, '_');
  }

 Quiz changeQuizUsingProblematicFileName(
      Quiz quiz, String fileName, fixedFileName) {
   debugPrint('=== iddd ${quiz.id} ===');

    debugPrint('fileName $fileName');
    debugPrint('fixedFileName $fixedFileName');
    for (Question question in quiz.questionList) {
      if (question.question.contains(fileName)) {
        question.question=  question.question.replaceAll(fileName, fixedFileName);
        debugPrint('changed!! question ${question.question}');

      }
      if (question.type == QType.customEditor) {
        if (question.moreData != null) {
          for (CustomQuizQuestionsFields f in question.moreData!.quizFields) {
            if (f.type == 'image' && f.defaultValue.contains(fileName)) {
              f.defaultValue=  f.defaultValue.replaceAll(fileName, fixedFileName);
              debugPrint('changed!! defaultValue ${f.defaultValue}');

            }
          }
        }
      }
    }

    return quiz;
  }

  Future<Course> setSyncNewCourse(Map<String, dynamic> data,bool isSingleInCourse) async {
    myQuizzes.clear();
    mySubjects.clear();
    myLessons.clear();
    late Course course;
    // Map<String, dynamic> sanitizedData = {};
    // data.forEach((key, value) {
    //   if (value is String) {
    //     sanitizedData[key] = value.replaceAll('\n', '');
    //   } else {
    //     sanitizedData[key] = value;
    //   }
    // });
    Map<String, dynamic> sanitizedData = removeNewlines(data);
    Map<String, dynamic> courses =
        sanitizedData['courses'] as Map<String, dynamic>;
    Map<String, dynamic> subjects =
        sanitizedData['subjects'] as Map<String, dynamic>;
    Map<String, dynamic> lessons =
        sanitizedData['lessons'] as Map<String, dynamic>;
    Map<String, dynamic> questionnaires =
        sanitizedData['questionnaire'] as Map<String, dynamic>;
    Map<String, dynamic> knowledgeAreas =
        sanitizedData['knowledge'] as Map<String, dynamic>;

    int courseId = int.parse(courses.keys.first);

    Map<String, dynamic> c = courses.values.first;
    course = Course.fromJson(c, courseId);
    course.isSync = true;

    for (int subjectId in course.subjectIds) {
      //List<Subject> courseSubjects=[];
      var s = subjects[subjectId.toString()];
      Subject subject = Subject.fromJson(s, subjectId);

      for (int lessonId in subject.lessonsIds) {
        var l = lessons[lessonId.toString()];
        Lesson lesson = Lesson.fromJson(l, lessonId, course.id);

        for (int qId in lesson.questionnaireIds) {
          var q = questionnaires[qId.toString()];
          Quiz quiz = Quiz.fromJson(q, qId);
          lesson.questionnaire.add(quiz);
          myQuizzes.add(quiz);
         // numOfQuizUrls += quiz.quizUrls.length;
          // await DownloadService()
          //     .downloadQuizFiles(quiz.quizUrls, quiz.id, courseId);
        }
        subject.lessonsList.add(lesson);
        myLessons.add(lesson);
      }

      for (int qId in subject.questionnaireIds) {
        var q = questionnaires[qId.toString()];
        //debugPrint('===qId $qId====');
        Quiz quiz = Quiz.fromJson(q, qId);
        subject.questionnaire.add(quiz);
       // numOfQuizUrls += quiz.quizUrls.length;
        myQuizzes.add(quiz);
      }

      course.subjects.add(subject);
      //courseSubjects.add(subject);
      mySubjects.add(subject);
    }
    for (int qId in course.questionnaireIds) {
      var q = questionnaires[qId.toString()];
      //debugPrint('===qId $qId====');
      Quiz quiz = Quiz.fromJson(q, qId);
      course.questionnaires.add(quiz);
    //  numOfQuizUrls += quiz.quizUrls.length;
      myQuizzes.add(quiz);
    }
    // await IsarService().addQuizzes(myQuizzes);
    //  await IsarService().addLessons(myLessons);
    // await IsarService().addSubjects(mySubjects);
    //  await IsarService().addCourse(course);
    await IsarService().addDataOfSyncCourse(
        quizzes: myQuizzes,
        course: course,
        subjects: mySubjects,
        lessons: myLessons);
//because there is only one ...
    Map<String, dynamic> k = knowledgeAreas.values.first;
    int knowledgeId = int.parse(knowledgeAreas.keys.first);
    Knowledge knowledge = Knowledge.fromJson(k, knowledgeId);
    if (await IsarService().getKnowledgeById(knowledgeId)==null) {
      await IsarService().addKnowledge(knowledge);
    }

    await IsarService().updateUserCourse(course.id, knowledge,isSingleInCourse);
    return course;
  }

  Map<String, dynamic> removeNewlines(Map<String, dynamic> input) {
    Map<String, dynamic> result = {};

    input.forEach((key, value) {
      if (value is String) {
        // if(key!='answer') {
        result[key] = value.replaceAll('\n', '');
        //   }
        //    else{
        //      result[key]=value;
        //      debugPrint('result[key] $key value $value }');
        //    }
      } else if (value is Map<String, dynamic>) {
        result[key] = removeNewlines(value);
      } else if (value is List) {
        result[key] = removeNewlinesFromList(value);
      } else {
        result[key] = value;
      }
    });

    return result;
  }

  List removeNewlinesFromList(List input) {
    List result = [];

    for (var item in input) {
      if (item is String) {
        result.add(item.replaceAll('\n', ''));
      } else if (item is Map<String, dynamic>) {
        result.add(removeNewlines(item));
      } else if (item is List) {
        result.add(removeNewlinesFromList(item));
      } else {
        result.add(item);
      }
    }

    return result;
  }

  syncDataCourse(Map<String, dynamic> data, Function(bool b) onSuccess) async {
    List<dynamic> pathIds = data['pathIds'] as List<dynamic>;
    List<dynamic> userCourseMap = data['UserCourse'] as List<dynamic>;
    List<dynamic> lessonCompleted = data['lessonCompleted'] as List<dynamic>;
    List<dynamic> subjectCompleted = data['subjectCompleted'] as List<dynamic>;
    List<dynamic> questionCompleted =
        data['questionCompleted'] as List<dynamic>;

    // questionCompleted.add(33070);
    List<UserCourse> userCourseList = [];
    for (var userCourse in userCourseMap) {
      //UserCourse? uc = IsarService().getUserCourseData(userCourse['courseId']);
      // if (uc != null) {
      //  debugPrint('uc ${uc.courseId}');
      UserCourse uc = UserCourse.fromJson(userCourse);
      userCourseList.add(uc);
    }

    for (var idPath in pathIds) {
      LearnPath? path = await IsarService().getPathById(idPath);
      if (path == null) {
        List<int> newCoursesIds =
        await ApiService().getPathCourses(id: idPath, onError: () {});

      }
    }

    bool getVideos = await IsarService().updateCourseData(userCourseList);

    debugPrint('after getting course $getVideos');
    for (int lessonId in lessonCompleted) {
      await IsarService().updateLessonCompleted(lessonId,
          updateLesson: true, updateUser: true);
    }

    for (int subjectId in subjectCompleted) {
      await IsarService().updateSubjectCompleted(subjectId);
    }

    for (int qId in questionCompleted) {
      await IsarService().updateQuizCompleted(qId);
    }
    // if (!getVideos) {
    onSuccess(getVideos);
    //   }
  }

  Future<bool> setLessonVideosNum(Course course) async {
    var dir = await getApplicationSupportDirectory();
    String courseVideosPath =
        '${dir.path}${Platform.pathSeparator}${constants.lessonPath}${Platform.pathSeparator}${course.id}';
    List<Lesson> updateLessons = [];
    if (await Directory(courseVideosPath).exists()) {
      debugPrint('course.id ${course.id}');
      List l = Directory(courseVideosPath).listSync();
      List<String> fileNames = [];

      for (var d in l) {
        String fileName =
            (d.path.split(Platform.pathSeparator)?.last).split('.')[0];
        //if contains letters
        if (double.tryParse(fileName) == null) {
          fileNames.add(fileName);
        }
      }
      List<Lesson>? list = await IsarService().getAllLessonsOfCourse(course.id);
      if (list != null) {
        if (fileNames.isEmpty) {
          int i = 1;
          for (Lesson lesson in list) {
            lesson.videoNum = (i++).toString();
            updateLessons.add(lesson);
          }
        } else {
          int i = 1;
          String videoNum = i.toString();
          for (Lesson lesson in list) {
            //lesson.videoNum = videoNum;
            if (fileNames.isNotEmpty && double.tryParse(videoNum) != null) {
              /*if (fileNames.contains('$iא') || fileNames.contains(' א$i')) {
                debugPrint('yyy');
                videoNum = '$iא';
                fileNames.remove('$iא');
              }*/
              RegExp pattern = RegExp('^$i\\s*a');
              String? matchingItem;

              for (String fileName in fileNames) {
                if (pattern.hasMatch(fileName)) {
                  matchingItem = fileName;
                  debugPrint('matchingItem $matchingItem');
                  break; // Stop iterating after finding the first match
                }
              }
              if (matchingItem != null) {
                videoNum = matchingItem;
                fileNames.remove(matchingItem);
                lesson.videoNum = videoNum;
              } else {
                videoNum = i.toString();
                lesson.videoNum = videoNum;
                i++;
              }
            } else {
              /* if (fileNames.isNotEmpty && fileNames.contains('$iב')) {
                videoNum = '$iב';
                fileNames.remove('$iב');
              } */
              RegExp pattern = RegExp('^$i\\s*b');
              String? matchingItem;

              for (String fileName in fileNames) {
                if (pattern.hasMatch(fileName)) {
                  matchingItem = fileName;
                  debugPrint('matchingItem $matchingItem');
                  break; // Stop iterating after finding the first match
                }
              }
              if (matchingItem != null) {
                videoNum = matchingItem;
                fileNames.remove(matchingItem);
                lesson.videoNum = videoNum;
                i++;
              } else {
                videoNum = i.toString();
                lesson.videoNum = videoNum;
                i++;
              }
            }
            updateLessons.add(lesson);
          }
        }
        IsarService().updateVideoNum(updateLessons);
      }
      return true;
    } else {
      //if videos do not exist fill video num with consecutive numbers
      int i = 1;

      List<Lesson>? list = await IsarService().getAllLessonsOfCourse(course.id);
      if (list != null) {
        debugPrint(
            'course.id ${course.id} videos do not exists fill video num with consecutive numbers');
        Sentry.addBreadcrumb(Breadcrumb(
            message:
                'course.id ${course.id} videos do not exists fill video num with consecutive numbers'));
        for (Lesson lesson in list) {
          lesson.videoNum = (i++).toString();
          updateLessons.add(lesson);
        }
        IsarService().updateVideoNum(updateLessons);
      }
    }
    return false;
  }

  downLoadQuizFilesByCourse(List<Course> courses) async {
    debugPrint('downLoadQuizFiles==');
    DownloadService().cancelToken = CancelToken();
    DownloadService().tryAgain = false;
    DownloadService().numDownloadFiles = 0;
    DownloadService().numOfErrorFiles = 0;
    DownloadService().numOfCourses = 0;
    DownloadService().didCheckCompleted = false;
    DownloadService().isCancelled = false;
    DownloadService().courseIds = courses.map((course) => course.id).toList();
    numOfQuizUrls=0;

    List<LinkQuizIsar> list=await IsarService().getAllLinksToDownload();


    // Use map to extract the courseIds and then convert to a Set to remove duplicates

    List<int> courseIdsLinks = list.map((quiz) => quiz.courseId).toSet().toList();
    debugPrint('courseIds of links $courseIdsLinks');

    List<int> courseIds =  courses.map((quiz) => quiz.id).toSet().toList();
    debugPrint('courseIds of courses $courseIds length ${courseIds.length}');


    for(int id in courseIdsLinks)
      {
        if(!courseIds.contains(id))
          {
               courses.add(Course()..id=id..errorLinks=true);
               debugPrint('course error links $id');
          }
      }
    numOfCoursesDownloadQuiz=courses.length;
    debugPrint('numOfCoursesDownloadQuiz $numOfCoursesDownloadQuiz');

    for (Course course in courses) {
      List<CC> cc = [];
      bool isNewCourse=true;

      if(courseIdsLinks.contains(course.id) || course.errorLinks)
        {
          isNewCourse=false;
          // Filter and add items to the cc list
          for (LinkQuizIsar quiz in list) {
            if (quiz.courseId == course.id && quiz.isDownload == false) {
              cc.add(CC(url: quiz.downloadLink, quizId: quiz.quizId));
            }
          }
        }
      else {
        if (course.questionnaires.isNotEmpty) {
          for (Quiz quiz in course.questionnaires) {
            for (var url in quiz.quizUrls) {
              cc.add(CC(url: url, quizId: quiz.id));
            }
          }
        }
        for (Subject subject in course.subjects) {
          if (subject.questionnaire.isNotEmpty) {
            for (Quiz quiz in subject.questionnaire) {
              for (var url in quiz.quizUrls) {
                cc.add(CC(url: url, quizId: quiz.id));
              }
            }
            //   DownloadService()
            //       .downloadQuizFiles(quiz.quizUrls, quiz.id, course.id);
            // }
          }
          for (Lesson lesson in subject.lessonsList) {
            if (lesson.questionnaire.isNotEmpty) {
              for (Quiz quiz in lesson.questionnaire) {
                // DownloadService()
                //     .downloadQuizFiles(quiz.quizUrls, quiz.id, course.id);
                for (var url in quiz.quizUrls) {
                  cc.add(CC(url: url, quizId: quiz.id));
                }
              }
            }
          }
        }
      }
        numOfQuizUrls+=cc.length;
      await DownloadService().downloadQuizFiles(cc,course.id,isNewCourse);
      }
    debugPrint('numOfQuizUrls $numOfQuizUrls');

   // await IsarService().deleteLinkIsarByIds(idsToRemove);
    list=await IsarService().getAllLinksToDownload();
  //  await DownloadService().startDownLoadingBlockedLinks(list);
  }

}

class CC
{
 late String url;
 late int quizId;

 CC({required this.url,required this.quizId});

}
