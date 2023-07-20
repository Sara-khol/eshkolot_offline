import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/models/videoIsar.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/course.dart';
import '../models/subject.dart';
import 'package:collection/collection.dart';

class IsarService {
  late Future<Isar> db;

  IsarService._privateConstructor();

  static final IsarService _instance = IsarService._privateConstructor();

  // static IsarService get instance => _instance;

  factory IsarService() => _instance;

  late User _user;

  //late Isar isarInstance;

  init() async {
    //isarInstance = await Isar.open([InventorySchema]);
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationSupportDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([
        CourseSchema,
        SubjectSchema,
        LessonSchema,
        QuizSchema,
        KnowledgeSchema,
        UserSchema,
        LearnPathSchema,
        VideoIsarSchema,
      ], inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<void> saveCourse(Course newCourse) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.courses.putSync(newCourse));
  }

  // Future<void> saveListCoursesFresh(List<Course> coursesList) async
  // {
  //   final isar = await db;
  //   isar.writeTxnSync(() async {
  //    await isar.clear();
  //     isar.courses.putAllSync(coursesList);
  //   });
  // }

  Future<void> initCourses(
    var coursesList,
    List<Subject> subjectList,
    List<Lesson> lessonList,
    List<Quiz> qList,
    List<Knowledge> knowledgeList,
    // List<User> usersList,
    var jsonPaths,
    var jsonUsers,
  ) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.clear();
    });
    isar.writeTxnSync(() {
      //the order matters for isarlinks!!!
      //quiz  needs to boe first
      isar.quizs.putAllSync(qList);
      isar.lessons.putAllSync(lessonList);
      isar.subjects.putAllSync(subjectList);
      isar.courses.putAllSync(coursesList);
      isar.knowledges.putAllSync(knowledgeList);
      isar.users.importJsonSync(jsonUsers);
      //   isar.learnPaths.importJsonSync(jsonPaths);
      isar.learnPaths.putAllSync(jsonPaths);

      // isar.users.importJsonSync(jsonUsers);

      // for (var user in jsonUsers) {
      //    isar.users.importJsonSync([user]);
      // }
      isar.videoIsars.clearSync();
    });
  }

  addIsarVideo(VideoIsar videoIsar) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.videoIsars.put(videoIsar);
    });
  }

  updateIsarVideo(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      VideoIsar? vi = await isar.videoIsars.get(id);
      vi!.isDownload = true;
      await isar.videoIsars.put(vi);
    });
  }

  setExpitedDateToFirstItem(int date) async {
    final isar = await db;
    await isar.writeTxn(() async {
      // VideoIsar? vi = await isar.videoIsars.where();
      // vi!.isDownload = true;
      // // await isar.videoIsars.put(vi);

      // final isar = await db;
      IsarCollection<VideoIsar> videoCollection = isar.collection<VideoIsar>();
      VideoIsar? vi = await videoCollection.where().findFirst();
      vi!.expiredDate = date;
      await isar.videoIsars.put(vi);
    });
  }

  Future<VideoIsar?> getVideoById(int id) async {
    final isar = await db;
    VideoIsar? videoIsar = await isar.videoIsars.get(id);
    return videoIsar;
  }

  Future<bool> checkIfDBisEmpty() async {
    final isar = await db;
    IsarCollection<User> userCollection = isar.collection<User>();
    return await userCollection.count() == 0;
  }

  Future<bool> checkIfVideoIsarIsEmpty() async {
    final isar = await db;
    IsarCollection<VideoIsar> v = isar.collection<VideoIsar>();
    return await v.count() == 0;
  }

  Future<List<VideoIsar>> getAllVideosToDownload() async {
    final isar = await db;
    final result =
        await isar.videoIsars.filter().isDownloadEqualTo(false).findAll();
    return result;
  }

  checkIfAllVideosAreDownloaded() async {
    bool b = false;
    if (await checkIfVideoIsarIsEmpty()) {
      return b;
    }
    await getAllVideosToDownload().then((value) {
      b = value.isEmpty;
    });
    return b;
  }

  clearVideoIsar() async {
    final isar = await db;
    // IsarCollection<VideoIsar> v = isar.collection<VideoIsar>();
    final videoIds = await isar.videoIsars.where().idProperty().findAll();

    await isar.writeTxn(() async {
      await isar.videoIsars.deleteAll(videoIds);
    });
  }

  Future<Course?> getFirstCourse() async {
    final isar = await db;
    IsarCollection<Course> coursesCollection = isar.collection<Course>();
    Course? course = await coursesCollection.where().findFirst();
    return course;
  }

  Future<List<Course>> getAllCourses() async {
    final isar = await db;
    IsarCollection<Course> coursesCollection = isar.collection<Course>();
    return await coursesCollection.where().findAll();
  }

  Future<List<Knowledge>> getAllKnowledge() async {
    final isar = await db;
    List<Knowledge> knowledgeCollection =
        await isar.knowledges.where().anyId().findAll();
    return knowledgeCollection;
  }

  Future<User?> getUserByTz(String tz) async {
    final isar = await db;
    User? user = await isar.users.where().tzEqualTo(tz).findFirst();

    if (user != null) {
      for (int knowledgeId in user.knowledgeIds) {
        Knowledge? knowledge = await getKnowledgeById(knowledgeId, isar);
        if (knowledge != null) {
          user.knowledgeCoursesMap[knowledge] = [];
        }
      }
      for (UserCourse userCourse in user.courses) {
        Course? c = await isar.courses
            .where()
            .serverIdEqualTo(userCourse.courseId)
            .findFirst();
        if (c != null && c.knowledgeId != null) {
          for (var entry in user.knowledgeCoursesMap.entries) {
            Knowledge knowledge = entry.key;
            if (knowledge.id == c.knowledgeId) {
              user.knowledgeCoursesMap[knowledge]?.add(c);
            }
          }
        }
      }
      for (var entry in user.knowledgeCoursesMap.entries) {
        debugPrint('knowledge ${entry.key.id}');
        for (Course v in entry.value) {
          debugPrint('course ${v.title}');
        }
      }
      for (int pathId in user.pathIds) {
        LearnPath? path = await getPathById(pathId, isar);
        if (path != null) {
          user.pathList.add(path);
        }
      }

      for (int lessonId in user.lessonCompleted) {
        await updateLessonCompleted(lessonId);
      }

      for (int subjectId in user.subjectCompleted) {
        await updateSubjectCompleted(subjectId);
      }

      for (int quizId in user.questionCompleted) {
        await updateQuizCompleted(quizId);
      }

      _user = user;
      await isar.writeTxn(() async {
        await isar.users.put(user);
      });
    }
    return user;
  }

  getCurrentUser() {
    return _user;
  }

  UserCourse? getUserCourseData(int courseId) {
    UserCourse? course =
        _user.courses.firstWhereOrNull((course) => course.courseId == courseId);
    return course;
  }

  addUserCourseStop(UserCourse newDataCourse) async {
    final isar = await db;
    await isar.writeTxn(() async {
      User? user = await isar.users.get(_user.id);
      UserCourse? course = user!.courses.firstWhereOrNull(
          (course) => course.courseId == newDataCourse.courseId);

      // // not supposed to get to here

      // if(course==null)
      //   {
      //     //add
      //     user.courses=user.courses.toList();
      //     user.courses.add(newDataCourse);
      //   }
      // else
      if (course != null) {
        //update
        debugPrint('update ${newDataCourse.lessonStopId}');

        course.subjectStopId = newDataCourse.subjectStopId;
        course.lessonStopId = newDataCourse.lessonStopId;
        course.isQuestionnaire = newDataCourse.isQuestionnaire;
        //  course.questionnaireStopId=userCourse.questionnaireStopId;

        // user.courses[user.courses.indexWhere((course) => course.courseId == newDataCourse.courseId)] = newDataCourse;
        user.courses[user.courses.indexWhere(
            (course) => course.courseId == newDataCourse.courseId)] = course;

        // course=userCourse;
        // user.courses.add(userCourse);
      }
      await isar.users.put(user);
      _user = user;
      debugPrint('update ${isar.users.toString()}');
    });
  }

  Future<List<User>> getUsers() async {
    final isar = await db;
    List<User> users = await isar.users.where().findAll();
    return users;
  }

  Future<Knowledge?> getKnowledgeById(int id, Isar isar) async {
    Knowledge? knowledge = await isar.knowledges.get(id);
    return knowledge;
  }

  Future<LearnPath?> getPathById(int id, Isar isar) async {
    final isar = await db;
    LearnPath? path = await isar.learnPaths.get(id);
    return path;
  }

  Stream<List<Course>> listenToCourses() async* {
    final isar = await db;
    yield* isar.courses
        .where()
        .watch(fireImmediately: true /*initialReturn: true*/);
  }

  updateLessonCompleted(int id) async {
    final isar = await db;
    Lesson? lesson;
    await isar.writeTxn(() async {
      lesson = await isar.lessons.get(id);
      lesson!.isCompletedCurrentUser = true;
      await isar.lessons.put(lesson!);
    });
    return lesson;
  }

  updateSubjectCompleted(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      Subject? subject = await isar.subjects.get(id);
      subject!.isCompletedCurrentUser = true;
      await isar.subjects.put(subject);
    });
  }

  updateQuizCompleted(int id) async {
    debugPrint('updateQuizCompleted id $id');
    final isar = await db;
    await isar.writeTxn(() async {
      Quiz? quiz = await isar.quizs.get(id);
      quiz!.isCompletedCurrentUser = true;
      await isar.quizs.put(quiz);
    });
  }

// insertFresh(List<Email> emailList) async {
//   await isarInstance.writeTxn(() async {
//     await isarInstance.clear();
//     for (Email element in emailList) {
//       await isarInstance.emails.put(element);
//     }
//   });
// }
//
// insertOne(Email emailItem) async {
//   late int id;
//   await isarInstance.writeTxn(() async {
//     id = await isarInstance.emails.put(emailItem);
//   });
//   notifyListeners();
//   return id;
// }
//
// getItems() async {
//   IsarCollection<Email> medicineCollection = isarInstance.collection<Email>();
//   List<Email?> medicines = await medicineCollection.where().findAll();
//   return medicines;
// }
//
// removeItem(Email email) async {
//   await isarInstance.writeTxn(() async {
//     await isarInstance.emails.delete(email.id);
//   });
// }

// void updateSync(Email email) async {
// //  email.isSynced = true;
//   await isarInstance.writeTxn(() async {
//     await isarInstance.emails.put(email);
//   });
// }
//
// getUnsyncedData() async {
//   IsarCollection<Email> emailCollection =
//   isarInstance.collection<Email>();
// //  List<Email?> emails =
//   //await emailCollection.filter().isSyncedEqualTo(false).findAll();
//   //return emails;
// }
}
