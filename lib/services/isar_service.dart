import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:eshkolot_offline/models/user.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/course.dart';
import '../models/subject.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  IsarService._privateConstructor();

  static final IsarService _instance = IsarService._privateConstructor();

  static IsarService get instance => _instance;

  //late Isar isarInstance;

  init() async {
    //isarInstance = await Isar.open([InventorySchema]);
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([
        CourseSchema,
        SubjectSchema,
        LessonSchema,
        QuestionnaireSchema,
        KnowledgeSchema,
        UserSchema,
        LearnPathSchema
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
      List<Course> coursesList,
      List<Subject> subjectList,
      List<Lesson> lessonList,
      List<Questionnaire> qList,
      List<Knowledge> knowledgeList,
      List<User> usersList,
      List<LearnPath> pathList) async {
    final isar = await db;
    // await isar.writeTxn(() async {
    //    await isar.clear();
    //    await isar.subjects.putAll(subjectList);
    //    await isar.courses.putAll(coursesList);
    //    await isar.lessons.putAll(lessonList);
    //    await isar.questionnaires.putAll(qList);
    //  await  coursesList[0].subjects.save();
    // // await  coursesList[0].subjects.first.questionnaires.save();
    // // await  coursesList[0].subjects.first.lessons.first.questionnaire.save();
    // // await  coursesList[0].subjects.first.lessons[0].name;
    //
    //    // await isar.teachers.put(mathTeacher);
    //    // await linda.teachers.save();
    //  });
    await isar.writeTxn(() async {
      await isar.clear();
      // await isar.courses.putAll(coursesList);
      // await isar.subjects.putAll(subjectList);
      // await isar.lessons.putAll(lessonList);
      // await isar.questionnaires.putAll(qList);
      // await coursesList[0].subjects.save();
      // coursesList[0].subjects.addAll(subjectList);
      // await coursesList[0].subjects.elementAt(0).lessons.save();
      // await coursesList[0].subjects.elementAt(0).questionnaires.save();
      // // await  coursesList[0].subjects.elementAt(0).lessons.elementAt(0).questionnaire.save();
      //
      // coursesList[0].subjects.elementAt(0).lessons.addAll(lessonList);
      // await coursesList[0]
      //     .subjects
      //     .elementAt(0)
      //     .lessons
      //     .elementAt(0)
      //     .questionnaire
      //     .save();
      //
      // coursesList[0].subjects.elementAt(0).questionnaires.add(qList[1]);
      // coursesList[0]
      //     .subjects
      //     .elementAt(0)
      //     .lessons
      //     .elementAt(0)
      //     .questionnaire
      //     .value = qList[0];
      //
      // await coursesList[0].subjects.elementAt(0).lessons.save();
      // await coursesList[0].subjects.elementAt(0).questionnaires.save();
      // await coursesList[0]
      //     .subjects
      //     .elementAt(0)
      //     .lessons
      //     .elementAt(0)
      //     .questionnaire
      //     .save();
      //
      // print("jjj ${coursesList[0].subjects}");
      // print("hhh ${coursesList[0].subjects.elementAt(0).lessons}");
      // print(
      //     "hhh ${coursesList[0].subjects.elementAt(0).lessons.elementAt(0).name}");
      // print(
      //     "qqq ${coursesList[0].subjects.elementAt(0).questionnaires.elementAt(0).question}");
      // print(
      //     "qqq ${coursesList[0].subjects.elementAt(0).lessons.elementAt(0).questionnaire.value?.question}");
      // //   await  coursesList[0].subjects.elementAt(0).lessons.save();
      //
      // // coursesList[0].subjects.elementAt(0).lessons.save();
      // // await linda.teachers.save();
    });
    isar.writeTxnSync(() {
      isar.lessons.putAllSync(lessonList);
      isar.subjects.putAllSync(subjectList);
      isar.courses.putAllSync(coursesList);
      isar.knowledges.putAllSync(knowledgeList);
      isar.users.putAllSync(usersList);
      isar.learnPaths.putAllSync(pathList);
    });
  }

  Future<bool> checkIfDBisEmpty() async {
    final isar = await db;
    IsarCollection<Course> coursesCollection = isar.collection<Course>();
    return await coursesCollection.count() == 0;
  }

  Future<Course?> getFirstCourse() async {
    final isar = await db;
    IsarCollection<Course> coursesCollection = isar.collection<Course>();
    Course? course = await coursesCollection.where().findFirst();
    return course;
  }

  Future<List<Knowledge>> getAllKnowledge() async {
    final isar = await db;
    List<Knowledge> knowledgeCollection =
        await isar.knowledges.where().anyId().findAll();
    return knowledgeCollection;
  }

  Future<User?> getUser() async {
    final isar = await db;
    User? user = await isar.users.where().findFirst();
    if (user != null) {
      for (int knowledgeId in user.knowledgeIds) {
        Knowledge? knowledge = await getKnowledgeById(knowledgeId,isar);
        if (knowledge != null) {
          user.knowledgeList.add(knowledge);
        }
      }
      for (int pathId in user.pathIds) {
        LearnPath? path = await getPathById(pathId,isar);
        if (path != null) {
          user.pathList.add(path);
        }
      }
    }
    return user;
  }

  Future<User?> getUserByTz(String tz) async {
    final isar = await db;
    User? user = await isar.users.where().tzEqualTo(tz).findFirst();

    if (user != null) {
      for (int knowledgeId in user.knowledgeIds) {
        Knowledge? knowledge = await getKnowledgeById(knowledgeId,isar);
        if (knowledge != null) {
          user.knowledgeList.add(knowledge);
        }
      }
      for (int pathId in user.pathIds) {
        LearnPath? path = await getPathById(pathId,isar);
        if (path != null) {
          user.pathList.add(path);
        }
      }
    }
    return user;
  }

  Future<List<User>> getUsers() async {
    final isar = await db;
    List<User> users = await isar.users.where().findAll();
    return users;
  }

  Future<Knowledge?> getKnowledgeById(int id, Isar isar,) async {
    Knowledge? knowledge = await isar.knowledges.get(id);
    return knowledge;
  }

  Future<LearnPath?> getPathById(int id,Isar isar) async {
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

  updateLesson(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      Lesson? lesson = await isar.lessons.get(id);
      lesson!.isCompleted = true;
      await isar.lessons.put(lesson);
    });
  }

  updateDownloadCourse(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      Course? course = await isar.courses.getByServerId(id);
      course!.isDownloaded = true;
      await isar.courses.put(course);
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
