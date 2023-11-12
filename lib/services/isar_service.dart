
import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/models/videoIsar.dart';
import 'package:eshkolot_offline/services/api_service.dart';
import 'package:eshkolot_offline/services/installationDataHelper.dart';
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

  Future<bool> checkIfVideoIsarIsEmpty(List<int> ids) async {
    final isar = await db;
    IsarCollection<VideoIsar> v = isar.collection<VideoIsar>();
    int count = await v
        .filter()
        .anyOf(ids, (q, int size) => q.courseIdEqualTo(size))
        .count();
    // return await v.count() == 0;
    return count == 0;
  }

  Future<List<VideoIsar>> getAllVideosToDownload(List<int> ids) async {
    final isar = await db;
    final result = await isar.videoIsars
        .filter()
        .anyOf(ids, (q, int id) => q.courseIdEqualTo(id))
        .isDownloadEqualTo(false)
        .findAll();
    //   final result= await isar.videoIsars.filter().isDownloadEqualTo(false).findAll();
    return result;
  }

  checkIfAllVideosAreDownloaded(bool newCourse) async {
    bool b = false;
    List<int> ids = getUserUserCoursesId();
    if (newCourse) {
      if (await checkIfVideoIsarIsEmpty(ids)) {
        return b;
      }
    }
    await getAllVideosToDownload(ids).then((value) {
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

  Future<Course?> getCourseById(int courseId) async {
    final isar = await db;
    IsarCollection<Course> coursesCollection = isar.collection<Course>();
    Course? course =
        await coursesCollection.where().idEqualTo(courseId).findFirst();
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

  Future<List<User>> getAllUsers() async
  {
    final isar = await db;
    List<User> users = await isar.users.where().findAll();
    return users;
  }

  Future<User?> getUserByTz(String tz) async {
    final isar = await db;
    User? user = await isar.users.where().tzEqualTo(tz).findFirst();

    if (user != null) {
      for (int knowledgeId in user.knowledgeIds) {
        Knowledge? knowledge = await getKnowledgeById(knowledgeId);
        if (knowledge != null) {
          user.knowledgeCoursesMap[knowledge] = [];
        }
      }
      for (UserCourse userCourse in user.courses) {
        Course? c = await getCourseById(userCourse.courseId);
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
        await updateLessonCompleted(lessonId, updateLesson: true);
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

  List<int> getUserUserCoursesId() {
    List<int> ids = [];
    for (UserCourse userCourse in _user.courses) {
      ids.add(userCourse.courseId);
    }
    return ids;
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
        course.questionnaireStopId = newDataCourse.questionnaireStopId;
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

  Future<bool> updateCourseData(List<UserCourse> userCourseList) async {
    bool getVideos = false;
    List<Course> coursesList = [];
    final isar = await db;

    for (UserCourse newDataCourse in userCourseList) {
      UserCourse? course = _user.courses.firstWhereOrNull(
          (course) => course.courseId == newDataCourse.courseId);
      Course? c = await getCourseById(newDataCourse.courseId);
      if (course != null) {
        //update
        debugPrint('update progressPercent ${newDataCourse.progressPercent}');
        _user.courses[_user.courses.indexWhere(
                (course) => course.courseId == newDataCourse.courseId)] =
            newDataCourse;

        if (c != null) {
          for (var courses in _user.knowledgeCoursesMap.values) {
            for (var i = 0; i < courses.length; i++) {
              if (courses[i].id == c.id) {
                courses[i] = c; // Replace the course with the new course
                break; // Exit the loop once the course is replaced
              }
            }
          }
        }
      } else {
        //??
        getVideos = true;
        // _user.courses.add(newDataCourse);
        // if (!await isCourseExist(newDataCourse.courseId)) {
        //when the course exists by other user
        if (c == null) {
          // getVideos = true;
          Course? course = await ApiService().getCourseData(
              id: newDataCourse.courseId, /*onSuccess: (){},*/ onError: () {});
          if (course != null) coursesList.add(course);
        } else {
          // for (var entry in _user.knowledgeCoursesMap.entries) {
          //   Knowledge knowledge = entry.key;
          //   if (knowledge.id == c.knowledgeId) {
          //     _user.knowledgeCoursesMap[knowledge]?.add(c);
          //   }
          // }

          Knowledge? knowledge =
              await IsarService().getKnowledgeById(c.knowledgeId!);
          if (c.knowledgeId != null &&
              !_user.knowledgeIds.contains(c.knowledgeId)) {
            List<int> kList = List.from(_user.knowledgeIds);
            kList.add(c.knowledgeId!);
            _user.knowledgeIds = kList;
            if (knowledge != null) {
              //  user.knowledgeIds.add(knowledgeId);
              debugPrint('add knowledge ${c.knowledgeId!}');
              _user.knowledgeCoursesMap[knowledge] = [c];
            }
          } else {
            debugPrint('update knowledge ${c.knowledgeId!}');
            // for (var entry in _user.knowledgeCoursesMap.entries) {
            //   Knowledge knowledge = entry.key;
            //   if (knowledge.id == c.knowledgeId) {
            //     _user.knowledgeCoursesMap[knowledge]?.add(c);
            //     break;
            //   }
            // }
            Knowledge findK = _user.knowledgeCoursesMap.keys
                .firstWhere((element) => element.id == c.knowledgeId);
            _user.knowledgeCoursesMap[findK]?.add(c);
          }
        }
        List<UserCourse> courses = List.from(_user.courses);
        courses.add(newDataCourse);
        _user.courses = courses;

        // if (c != null) {
        //   for (var entry in _user.knowledgeCoursesMap.entries) {
        //     Knowledge knowledge = entry.key;
        //     if (knowledge.id == c.knowledgeId) {
        //       _user.knowledgeCoursesMap[knowledge]?.add(c);
        //     }
        //   }
        // }
      }
      // //  Course? c = await getCourseById(newDataCourse.courseId);
      // if (c != null) {
      //   for (var courses in _user.knowledgeCoursesMap.values) {
      //     for (var i = 0; i < courses.length; i++) {
      //       if (courses[i].id == c.id) {
      //         courses[i] = c; // Replace the course with the new course
      //         break; // Exit the loop once the course is replaced
      //       }
      //     }
      //   }
      // }
    }

    if (coursesList.isNotEmpty) {
      debugPrint('sending event full');
      InstallationDataHelper().eventBusDialogs.fire(coursesList);
    } else /* if (getVideos)*/ {
      debugPrint('sending event empty');
      InstallationDataHelper().eventBusDialogs.fire('');
    }
    await isar.writeTxn(() async {
      await isar.users.put(_user);
      // _user = user;
    });
    return getVideos;
  }

  updateKnowledgeMap() {}

  Future<List<User>> getUsers() async {
    final isar = await db;
    List<User> users = await isar.users.where().findAll();
    return users;
  }

  Future<Knowledge?> getKnowledgeById(int id) async {
    final isar = await db;

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

  updateLessonCompleted(int id,
      {bool updateLesson = false, bool updateUser = false}) async {
    final isar = await db;
    Lesson? lesson;
    await isar.writeTxn(() async {
      if (updateLesson) {
        // lesson = await isar.lessons.get(id);
        lesson = await isar.lessons.where().lessonIdEqualTo(id).findFirst();
        lesson!.isCompletedCurrentUser = true;
        await isar.lessons.put(lesson!);
      }
      if (updateUser) {
        List<int> lessonCompletedList = List.from(_user.lessonCompleted);
        if (!lessonCompletedList.contains(id)) {
          lessonCompletedList.add(id);
          _user.lessonCompleted = lessonCompletedList;
          await isar.users.put(_user);
        }
      }
    });
  }

  updateCourse(int id, [bool updateComplete = false]) async {
    final isar = await db;
    await isar.writeTxn(() async {
      _user.courses.firstWhere((c) => c.courseId == id).status =
          updateComplete ? Status.finish : Status.middle;
      await isar.users.put(_user);
    });

    // _user.knowledgeCoursesMap.values.firstWhere((List<Course> list) => list.firstWhere(
    //         (course) => course.serverId==id));
    // Course? course;
    // for (final coursesList in _user.knowledgeCoursesMap.values) {
    //    course = coursesList.firstWhereOrNull((course) => course.id == id);
    //   if (course != null) {
    //     break;
    //   }
    // }
    // if(course!=null)
    //   {
    //     course.
    //   }
  }

  updateSubjectCompleted(int id, [bool updateUser = false]) async {
    final isar = await db;
    await isar.writeTxn(() async {
      if (!updateUser) {
        // Subject? subject = await isar.subjects.get(id);
        Subject? subject = await isar.subjects.where().subjectIdEqualTo(id).findFirst();

        subject!.isCompletedCurrentUser = true;
        await isar.subjects.put(subject);
      } else {
        List<int> subjectCompletedList = List.from(_user.subjectCompleted);
        if (!subjectCompletedList.contains(id)) {
          subjectCompletedList.add(id);
          _user.subjectCompleted = subjectCompletedList;

          await isar.users.put(_user);
        }
      }
    });
  }

  updateQuizCompleted(int id, [bool updateUser = false]) async {
    final isar = await db;
    await isar.writeTxn(() async {
      if (!updateUser) {
        Quiz? quiz = await isar.quizs.get(id);
        quiz!.isCompletedCurrentUser = true;
        await isar.quizs.put(quiz);
      } else {
        List<int> quizCompletedList = List.from(_user.questionCompleted);
        if (!quizCompletedList.contains(id)) {
          quizCompletedList.add(id);
          _user.questionCompleted = quizCompletedList;
          await isar.users.put(_user);
        }
      }
    });
  }

  updateVideoNum(List<Lesson> list) async {
    final isar = await db;
    await isar.writeTxnSync(() async {
      isar.lessons.putAllSync(list);
    });
  }
  
  Future<List<Lesson>?> getAllLessonsOfCourse(int  courseId) async
  {
    final isar = await db;
    return   isar.lessons.where().courseIdEqualTo(courseId).findAll();
  }

  updateGrade(UserGrade userGrade) async
  {
    final isar = await db;
    await isar.writeTxn(() async {
      List<UserGrade> gradeList = List.from(_user.percentages);
      UserGrade? grade =
      gradeList.firstWhereOrNull((g) => g.quizId == userGrade.quizId);
      if(grade==null) {
        gradeList.add(userGrade);
      }
      else{
        grade=userGrade;
      }
      _user.percentages = gradeList;
      await isar.users.put(_user);
    });
  }

  addKnowledge(Knowledge knowledge) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.knowledges.put(knowledge);
    });
  }

  addCourse(Course course) async {
    final isar = await db;
    await isar.writeTxnSync(() async {
      await isar.courses.putSync(course);
    });
  }

  addSubjects(List<Subject> subjects) async {
    final isar = await db;
    await isar.writeTxnSync(() async {
      isar.subjects.putAllSync(subjects);
    });
  }

  addLessons(List<Lesson> lessons) async {
    final isar = await db;
    await isar.writeTxnSync(() async {
      isar.lessons.putAllSync(lessons);
    });
  }

  addQuizzes(List<Quiz> quizzes) async {
    final isar = await db;
    await isar.writeTxnSync(() async {
      await isar.quizs.putAllSync(quizzes);
    });
  }

  // Check if a course with a specific ID exists
  Future<bool> isCourseExist(int courseId) async {
    final isar = await db;

    Course? course = await isar.courses.where().idEqualTo(courseId).findFirst();
    return course != null;
  }

  // Check if a course with a specific ID exists
  Future<bool> isKnowledgeExist(int kId) async {
    final isar = await db;

    Knowledge? knowledge =
        await isar.knowledges.where().idEqualTo(kId).findFirst();
    return knowledge != null;
  }



  updateUserCourse( Course course, Knowledge knowledge) async {
    final isar = await db;
    await isar.writeTxn(() async {
      // User? user = await isar.users.get(_user.id);

      if (!_user.knowledgeIds.contains(knowledge.id)) {
        List<int> kList = List.from(_user.knowledgeIds);
        kList.add(knowledge.id);
        _user.knowledgeIds = kList;

        //  user.knowledgeIds.add(knowledgeId);
        debugPrint('add knowledge ${knowledge.id}');
        _user.knowledgeCoursesMap[knowledge] = [course];
      } else {
        Knowledge findK = _user.knowledgeCoursesMap.keys
            .firstWhere((element) => element.id == knowledge.id);
        _user.knowledgeCoursesMap[findK]?.add(course);
      }
      //
      // //todo not supposed to exist added for checking meanwhile
      // if (user.courses.firstWhereOrNull((c) => course.id == c.courseId) ==
      //     null) {
      //   //todo get correct data from service api
      //   UserCourse newUserCourse = UserCourse()
      //     ..courseId = course.id
      //     ..status = Status.start
      //     ..progressPercent = 0;
      //
      //   List<UserCourse> courses = List.from(user.courses);
      //   courses.add(newUserCourse);
      //   user.courses = courses;
      // }
      // user.courses.add(newUserCourse);
      await isar.users.put(_user);
    });
  }
}
