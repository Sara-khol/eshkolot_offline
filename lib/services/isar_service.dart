import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/linkQuizIsar.dart';
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

import '../utils/common_funcs.dart';

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
    // final dir = await getApplicationSupportDirectory();
    final dir = await CommonFuncs().getEshkolotWorkingDirectory();
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
        LinkQuizIsarSchema,
      ], inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  // Future<void> saveListCoursesFresh(List<Course> coursesList) async
  // {
  //   final isar = await db;
  //   isar.writeTxnSync(() async {
  //    await isar.clear();
  //     isar.courses.putAllSync(coursesList);
  //   });
  // }

  Future<void> initData(
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
      //quiz  needs to be first
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
      isar.linkQuizIsars.clearSync();
    });
  }

  updateUserParentData(String userType,String userMail) async {
    final isar = await db;
    List<User> users = await getAllUsers();
    for (User user in users) {
      user.userType = userType;
      user.userMail = userMail;

      await isar.writeTxn(() async {
        await isar.users.put(user);
        // _user = user;
      });
    }
  }

  addIsarVideo(VideoIsar videoIsar) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.videoIsars.put(videoIsar);
    });
  }

  addLearnPath(LearnPath path) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.learnPaths.put(path);
    });
  }

  addIsarQuiz(LinkQuizIsar linkQuizIsar) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.linkQuizIsars.put(linkQuizIsar);
    });
  }

  Future<bool> checkIsarQuizExistes(int id) async {
    final isar = await db;
    LinkQuizIsar? linkQuizIsar = await isar.linkQuizIsars.get(id);
    return linkQuizIsar != null;
  }

  updateIsarVideo(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      VideoIsar? vi = await isar.videoIsars.get(id);
      vi!.isDownload = true;
      await isar.videoIsars.put(vi);
    });
  }

  // updateIsarVideoError(int id) async {
  //   final isar = await db;
  //   await isar.writeTxn(() async {
  //     VideoIsar? vi = await isar.videoIsars.get(id);
  //     vi!.isBlockedOrError = true;
  //     await isar.videoIsars.put(vi);
  //   });
  // }

  Future<bool> updateLinkQuiz(int id) async {
    debugPrint('updateLinkQuiz id $id');
    final isar = await db;
    await isar.writeTxn(() async {
      LinkQuizIsar? linkQuizIsar = await isar.linkQuizIsars.get(id);
      // linkQuizIsar!.isDownload = true;
      // await isar.linkQuizIsars.put(linkQuizIsar);

      if (linkQuizIsar != null) {
        await isar.linkQuizIsars.delete(linkQuizIsar.id);
        return true;
      } else {
        debugPrint('can not delete LinkQuiz id $id');
        return false;
      }
    });
    return false;
  }

  Future<bool> updateLinkQuizByName(String name, int quizId) async {
    name = '/$name';
   // debugPrint('updateLinkQuizByName name $name quizId $quizId');
    final isar = await db;
    await isar.writeTxn(() async {
      LinkQuizIsar? linkQuizIsar = await isar.linkQuizIsars
          .filter()
          .nameEqualTo(name)
          .and()
          .quizIdEqualTo(quizId)
          .findFirst();
      //linkQuizIsar!.isDownload = true;
      if (linkQuizIsar != null) {
        await isar.linkQuizIsars.delete(linkQuizIsar.id);
        return true;
      } else {
        debugPrint('can not delete LinkQuiz name $name quizId $quizId');
        return false;
      }
    });
    return false;
  }

  Future<bool> updateLinkQuizToNewName(
      String name, int quizId, String newName) async {
    name = '/$name';
    debugPrint('updateLinkQuizToNewName name $name quizId $quizId');
    final isar = await db;
    await isar.writeTxn(() async {
      LinkQuizIsar? linkQuizIsar = await isar.linkQuizIsars
          .filter()
          .nameEqualTo(name)
          .and()
          .quizIdEqualTo(quizId)
          .findFirst();
      //linkQuizIsar!.isDownload = true;
      if (linkQuizIsar != null) {
        linkQuizIsar.name = '/$newName';
        await isar.linkQuizIsars.put(linkQuizIsar);
        // await isar.linkQuizIsars.delete(linkQuizIsar.id);
        return true;
      } else {
        debugPrint('can not delete LinkQuiz name $name quizId $quizId');
        return false;
      }
    });
    return false;
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

  Future<bool> checkIfLinkIsarIsEmpty(List<int> ids) async {
    final isar = await db;
    IsarCollection<LinkQuizIsar> v = isar.collection<LinkQuizIsar>();
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

  Future<List<LinkQuizIsar>> getAllLinksToDownload() async {
    final isar = await db;
    final result = await isar.linkQuizIsars
        .filter()
        //.anyOf(ids, (q, int id) => q.courseIdEqualTo(id))
        .isDownloadEqualTo(false)
        .findAll();
    debugPrint('getAllLinksToDownload length ${result.length}');
    return result;
  }

  deleteLinkIsarByIds(List<int> idsToRemove) async {
    debugPrint('idsToRemove ${idsToRemove.length}');
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.linkQuizIsars.deleteAll(idsToRemove);
    });
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

  checkIfAllLinksAreDownloaded(bool newCourse) async {
    bool b = false;
    List<int> ids = getUserUserCoursesId();
    if (newCourse) {
      if (await checkIfLinkIsarIsEmpty(ids)) {
        return b;
      }
    }
    await getAllLinksToDownload().then((value) {
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

  clearLinkIsar() async {
    final isar = await db;
    // IsarCollection<VideoIsar> v = isar.collection<VideoIsar>();
    final linkIds = await isar.linkQuizIsars.where().idProperty().findAll();

    await isar.writeTxn(() async {
      await isar.linkQuizIsars.deleteAll(linkIds);
    });
  }

  Future<Course?> getCourseById(int courseId, [bool sort = false]) async {
    final isar = await db;
    IsarCollection<Course> coursesCollection = isar.collection<Course>();
    Course? course =
        await coursesCollection.where().idEqualTo(courseId).findFirst();

    // if(course!=null && sort) {
    //   // Step 2: Begin a transaction to make changes atomically
    //   await isar.writeTxn(() async {
    //     course.subjects.sorted((a, b) => a.id.compareTo(b.id));
    //     // Step 3: Clear existing links to start fresh
    //     // course.subjects.clear();
    //     //
    //     // // Step 4: Re-add the subjects in the desired order
    //     // for (int subjectId in course.subjectIds) {
    //     //   // Fetch each subject by its ID
    //     //   Subject? subject = await isar.subjects.get(subjectId);
    //     //   if (subject != null) {
    //     //     // Re-add the subject to the course's IsarLinks in the new order
    //     //     course.subjects.add(subject);
    //     //   }
    //     // }
    //     //
    //     // // Step 5: Save the course to persist changes
    //     await isar.courses.put(course);
    //   });
    //   return
    //   await coursesCollection.where().idEqualTo(courseId).findFirst();
    // }
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

  Future<List<User>> getAllUsers() async {
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
      user.courses.sort((a, b) => a.courseId.compareTo(b.courseId));
      for (UserCourse userCourse in user.courses) {
        if (userCourse.isSingleCourse) {
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
      }
      // user.knowledgeCoursesMap.removeWhere((knowledge, courses) => courses.isEmpty);

      // Sorting courses by course.id for each knowledge entry in the map
      user.knowledgeCoursesMap.forEach((knowledge, courses) {
        courses.sort((a, b) => a.id.compareTo(b.id));
      });
      for (var entry in user.knowledgeCoursesMap.entries) {
        debugPrint('knowledge ${entry.key.id}');
        for (Course v in entry.value) {
          debugPrint('course ${v.title}');
        }
      }
      for (int pathId in user.pathIds) {
        LearnPath? path = await getPathById(pathId);
        if (path != null) {
          user.pathList.add(path);
        }
      }
      await resetCompletedItems();

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

  User getCurrentUser() {
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
      //  User? user = await isar.users.get(_user.id);
      // User? user = _user;
      UserCourse? course = _user.courses.firstWhereOrNull(
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
        _user.courses[_user.courses.indexWhere(
            (course) => course.courseId == newDataCourse.courseId)] = course;

        // course=userCourse;
        // user.courses.add(userCourse);
      }
      await isar.users.put(_user);
      // _user = user;
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
        debugPrint('000 111 ${newDataCourse.courseId}');
        //update
        debugPrint('update progressPercent ${newDataCourse.progressPercent}');
        _user.courses[_user.courses.indexWhere(
                (course) => course.courseId == newDataCourse.courseId)] =
            newDataCourse;

        if (c != null) {
          if (!c.isDownLoadData && c.isSync /*&& !c.isDownloadQuiz*/) {
            debugPrint('000 444 ${newDataCourse.courseId}');
            debugPrint('course get quiz files');
            c.isSyncNotCompleted = true;
            updateCourseSyncComplete([c.id], true);
            coursesList.add(c);
          }

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

        //check if   course exists by other user
        //if not
        if (c == null) {
          debugPrint('000 222 ${newDataCourse.courseId}');

          // getVideos = true;
          Course? course = await ApiService().getCourseData(
              id: newDataCourse.courseId,
              /*onSuccess: (){},*/
              onError: () {},
              isSingleInCourse: newDataCourse.isSingleCourse);
          if (course != null) {
            coursesList.add(course);
          }
        } else {
          debugPrint('000 3333 ${newDataCourse.courseId}');
          if (!c.isDownLoadData && c.isSync) {
            debugPrint('000 444 ${newDataCourse.courseId}');
            debugPrint('course get quiz files');
            c.isSyncNotCompleted = true;
            updateCourseSyncComplete([c.id], true);
            coursesList.add(c);
          }

          Knowledge? knowledge =
              await IsarService().getKnowledgeById(c.knowledgeId!);
          if (c.knowledgeId != null &&
              !_user.knowledgeIds.contains(c.knowledgeId)) {
            List<int> kList = List.from(_user.knowledgeIds);
            kList.add(c.knowledgeId!);
            _user.knowledgeIds = kList;
            if (knowledge != null) {
              //  user.knowledgeIds.add(knowledgeId);
              debugPrint('add knowledge1 ${c.knowledgeId!}');
              if (newDataCourse.isSingleCourse) {
                _user.knowledgeCoursesMap[knowledge] = [c];
              } else {
                debugPrint('add knowledge without course');
                _user.knowledgeCoursesMap[knowledge];
              }
            }
          } else {
            debugPrint('update knowledge ${c.knowledgeId!}');
            Knowledge findK = _user.knowledgeCoursesMap.keys
                .firstWhere((element) => element.id == c.knowledgeId);
            _user.knowledgeCoursesMap[findK]?.add(c);
          }
        }
        List<UserCourse> courses = List.from(_user.courses);
        courses.add(newDataCourse);
        _user.courses = courses;
      }
    }
    for (UserCourse userCourse in _user.courses) {
      Course? ccourse = await getCourseById(userCourse.courseId);
      await updateLearnPath(ccourse!);
    }

    //todo ?????
    // if (coursesList.isNotEmpty) {
    //   debugPrint('sending event full');
    //   InstallationDataHelper().eventBusDialogs.fire(coursesList);
    // } else /* if (getVideos)*/ {
    //   debugPrint('sending event empty');
    //   InstallationDataHelper().eventBusDialogs.fire('');
    // }
    // bool allNotCompleted = false;
    bool isNotCompleted = false;
    if (coursesList.isEmpty) {
      debugPrint('sending event empty');
      InstallationDataHelper().eventBusDialogs.fire(isNotCompleted);
    } else {
      InstallationDataHelper().coursesList = coursesList;

      List<Course> downloadQuizFilesCourses =
          coursesList.where((obj) => obj.isDownloadQuiz == false).toList();
      if (downloadQuizFilesCourses.isNotEmpty) {
        debugPrint('start loading ${downloadQuizFilesCourses.length}');

        InstallationDataHelper()
            .downLoadQuizFilesByCourse(downloadQuizFilesCourses);
      } else {
        //todo ????
        InstallationDataHelper().eventBusDialogs.fire(isNotCompleted);
      }
      //todo check from isar??
      // allNotCompleted =
      //     coursesList.every((obj) => obj.isSyncNotCompleted == true);
      // isNotCompleted =
      //     coursesList.any((obj) => obj.isSyncNotCompleted == true);

      // if (!isNotCompleted) {
      //   InstallationDataHelper().downLoadQuizFilesByCourse(coursesList);
      // } else {
      //   InstallationDataHelper().eventBusDialogs.fire(isNotCompleted);
      // }
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

  Future<Quiz?> getQuizById(int id) async {
    final isar = await db;

    Quiz? quiz = await isar.quizs.get(id);
    return quiz;
  }

  updateQuiz(Quiz q) async {
    debugPrint('updateQuiz  ${q.id} ${q.title}');
    final isar = await db;
    await isar.writeTxn(() async {
      isar.quizs.put(q);
    });
  }

  Future<LearnPath?> getPathById(int id) async {
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

  resetCompletedItems() async {
    final isar = await db;
    List<Lesson> lessons = await isar.lessons.where().findAll();
    await isar.writeTxn(() async {
      for (var i = 0; i < lessons.length; i++) {
        lessons[i].isCompletedCurrentUser = false;
        await isar.lessons.put(lessons[i]);
      }
    });

    List<Subject> subjects = await isar.subjects.where().findAll();
    await isar.writeTxn(() async {
      for (var i = 0; i < subjects.length; i++) {
        subjects[i].isCompletedCurrentUser = false;
        await isar.subjects.put(subjects[i]);
      }
    });

    List<Quiz> quizList = await isar.quizs.where().findAll();
    await isar.writeTxn(() async {
      for (var i = 0; i < quizList.length; i++) {
        quizList[i].isCompletedCurrentUser = false;
        await isar.quizs.put(quizList[i]);
      }
    });
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

  updateCourseDownloaded(List<int> ids) async {
    final isar = await db;
    Course? course;
    await isar.writeTxn(() async {
      for (int id in ids) {
        course = await isar.courses.where().idEqualTo(id).findFirst();
        course!.isDownLoadData = true;
        await isar.courses.put(course!);
      }
    });
  }

  updateCourseSyncComplete(List<int> ids, bool update) async {
    final isar = await db;
    Course? course;
    await isar.writeTxn(() async {
      for (int id in ids) {
        course = await isar.courses.where().idEqualTo(id).findFirst();
        course!.isSyncNotCompleted = update;
        await isar.courses.put(course!);
      }
    });
  }

  Future<List<int>> checkCoursesNotCompleted(List<int> ids) async {
    final isar = await db;
    if (ids.isEmpty) {
      final result = await isar.courses
          .filter()
          .isSyncNotCompletedEqualTo(true)
          .idProperty()
          .findAll();
      return result;
    }

    final result = await isar.courses
        .filter()
        .anyOf(ids, (q, int id) => q.idEqualTo(id))
        .idProperty()
        .findAll();

    // Check if all results have isSyncNotCompleted set to true
    // return result.every((course) => course.isSyncNotCompleted);
    return result;
  }

  updateSubjectCompleted(int id, [bool updateUser = false]) async {
    final isar = await db;
    await isar.writeTxn(() async {
      if (!updateUser) {
        // Subject? subject = await isar.subjects.get(id);
        Subject? subject =
            await isar.subjects.where().subjectIdEqualTo(id).findFirst();

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

  updateQuizCompleted(int id, [updateQuizCompletedList = false]) async {
    final isar = await db;
    await isar.writeTxn(() async {
      Quiz? quiz = await isar.quizs.get(id);
      quiz!.isCompletedCurrentUser = true;
      await isar.quizs.put(quiz);

      if (updateQuizCompletedList) {
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

  Future<List<Lesson>?> getAllLessonsOfCourse(int courseId) async {
    final isar = await db;
    return isar.lessons.where().courseIdEqualTo(courseId).findAll();
  }

  updateGrade(UserGrade userGrade) async {
    final isar = await db;
    await isar.writeTxn(() async {
      List<UserGrade> gradeList = List.from(_user.percentages);
      UserGrade? grade =
          gradeList.firstWhereOrNull((g) => g.quizId == userGrade.quizId);
      if (grade == null) {
        gradeList.add(userGrade);
      } else {
        grade = userGrade;
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
      isar.quizs.putAllSync(quizzes);
    });
  }

  addDataOfSyncCourse(
      {required List<Quiz> quizzes,
      required Course course,
      required List<Subject> subjects,
      required List<Lesson> lessons}) async {
    final isar = await db;
    debugPrint('quizzes length ${quizzes.length}');
    // await isar.writeTxn(() async {
    //   await isar.quizs.putAll(quizzes);
    // });
    isar.writeTxnSync(() async {
      //the order matters for isarlinks!!!
      //quiz  needs to be first
      List<Quiz> qq = [];
      for (Quiz quiz in quizzes) {
        List<Question> q = quiz.questionList;
        quiz.questionList = [];
        // debugPrint('lll ${q.length} id: ${quiz.id}');
        for (int i = 0; i < q.length; i++) {
          quiz.questionList.add(q[i]);
        }
        qq.add(quiz);
      }
      isar.quizs.putAllSync(qq);
      // isar.quizs.putAllSync(quizzes);
      isar.lessons.putAllSync(lessons);
      isar.subjects.putAllSync(subjects);
      isar.courses.putSync(course);
    });
  }

  // Check if a course with a specific ID exists
  Future<bool> isCourseExist(int courseId) async {
    final isar = await db;

    Course? course = await isar.courses.where().idEqualTo(courseId).findFirst();
    return course != null;
  }

  updateUserCourse(
      int courseId, Knowledge knowledge, bool isSingleCourse) async {
    debugPrint('updateUserCourse===');
    final isar = await db;
    //get the course direct from isar so all the items will be in right order
    Course? course = await getCourseById(courseId);
    await isar.writeTxn(() async {
      // User? user = await isar.users.get(_user.id);

      if (!_user.knowledgeIds.contains(knowledge.id)) {
        List<int> kList = List.from(_user.knowledgeIds);
        kList.add(knowledge.id);
        _user.knowledgeIds = kList;

        //  user.knowledgeIds.add(knowledgeId);
        debugPrint('add knowledge ${knowledge.id}');
        if (isSingleCourse) {
          _user.knowledgeCoursesMap[knowledge] = [course!];
        } else {
          _user.knowledgeCoursesMap[knowledge] = [];
          // aa(course!);
        }
      } else {
        if (isSingleCourse) {
          Knowledge findK = _user.knowledgeCoursesMap.keys
              .firstWhere((element) => element.id == knowledge.id);
          _user.knowledgeCoursesMap[findK]?.add(course!);
        } else {
          // aa(course!);
        }
      }
      await isar.users.put(_user);
    });

    // Call the aa function outside of the transaction
    // if (!isSingleCourse || (_user.knowledgeCoursesMap[knowledge]?.contains(course) ?? false)) {
    //   updateLearnPath(course!);
    //   }
  }

  updateLearnPath(Course course) async {
    final isar = await db;
    for (int pathId in _user.pathIds) {
      LearnPath? path = await getPathById(pathId);
      if (path != null) {
        bool isPathUpdate = false;
        if (path.coursesIds.contains(course.id) &&
            !path.coursesPath.contains(course)) {
          isPathUpdate = true;
          path.coursesPath.add(course);
          debugPrint(
              'learnPath ${path.id} course ${course.id} ${course.title}');

          LearnPath path1 = _user.pathList.where((i) => i.id == path.id).first;
          if (!path1.coursesPath.contains(course)) {
            path1.coursesPath.add(course);
          }
        }
        // for (int pId in path.coursesIds)
        //   {
        //     if(course.id==pId)
        //       {
        //         isPathUpdate=true;
        //         path.coursesPath.add(course);
        //         debugPrint('learnPath ${path.id} course ${course.id} ${course.title}');
        //       }
        //   }
        if (isPathUpdate) {
          await isar.writeTxnSync(() async {
            isar.learnPaths.putSync(path);
            isar.users.putSync(_user);
          });
        }
      }
    }
  }

  Future<List<int>> getAllCourseIds() async {
    final isar = await db;

    List<int> courseIds = await isar.videoIsars
        .where(distinct: true)
        .anyCourseId()
        .courseIdProperty()
        .findAll();

    print('All distinct courseIds: $courseIds');
    return courseIds;
  }

  Future<List<int>> setPath(LearnPath path) async {
    final isar = await db;
    List<int> newCoursesIds = [];
    for (int courseId in path.coursesIds) {
      Course? c = await getCourseById(courseId);
      if (c != null) {
        // This will automatically handle linking and updating the IsarLinks
        path.coursesPath.add(c);
      } else {
        newCoursesIds.add(courseId);
      }
    }
    _user.pathList.add(path);

    List<int> pList = List.from(_user.pathIds);
    pList.add(path.id);
    _user.pathIds = pList;
    debugPrint('_user.pathIds ${_user.pathIds}');

    await isar.writeTxnSync(() async {
      isar.learnPaths.putSync(path);
      isar.users.putSync(_user);
    });
    return newCoursesIds;
  }

  updateCourseDownloadFiles(int courseId) async {
    final isar = await db;
    Course? course = await isar.courses.where().idEqualTo(courseId).findFirst();
    if (course != null) {
      course.isDownloadQuiz = true;
      await isar.writeTxn(() async {
        isar.courses.put(course);
      });
    }
  }
}
