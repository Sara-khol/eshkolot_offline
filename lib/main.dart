import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/services/UsbPreferences.dart';
import 'package:eshkolot_offline/services/installationDataHelper.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/services/localFileHelper.dart';
import 'package:eshkolot_offline/services/network_check.dart';
import 'package:eshkolot_offline/ui/screens/login/login_page.dart';
import 'package:eshkolot_offline/ui/screens/main_page/title_bar_widget.dart';
import 'package:eshkolot_offline/ui/screens/main_page/top_bar_user_widget.dart';
import 'package:eshkolot_offline/utils/common_funcs.dart';
import 'package:eshkolot_offline/utils/constants.dart' as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';
import 'models/course.dart';
import 'models/knowledge.dart';
import 'models/lesson.dart';
import 'models/quiz.dart';
import 'dart:convert';

// import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'models/videoIsar.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;
import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.

class MyRootApp extends StatefulWidget {
  const MyRootApp({super.key});

  @override
  State<MyRootApp> createState() => _MyRootAppState();
}

class _MyRootAppState extends State<MyRootApp> {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
        designSize: const Size(1920, 1080),
        minTextAdapt: true,
        builder: (_, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'אשכולות אופליין',
            theme: ThemeData(
              fontFamily: 'RAG-Sans',
              primaryColor: Colors.blue,
              textTheme: TextTheme(
                bodyMedium: TextStyle(color: Colors.black), // or your colorApp
              ),
            ),
            home: const AppLoader(), // your actual loader
          );
        },
      ),
    );
  }
}

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  bool _initialized = false;
  bool _initializeError = false;
  String errorString='';
  List<Course> myCourses = [];
  bool databaseInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized && !_initializeError) {
      // You can customize this screen however you want
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if(!_initialized && _initializeError) {
      return Scaffold(
        body: Center(
          child: Text('ישנה בעיה\n$errorString',textAlign: TextAlign.center,),
        ),
      );
    }

    // Once ready, load your main app
    return MyApp(
      courses: myCourses,
      dataWasFilled: databaseInitialized,
    );
  }

  Future<void> _initializeApp() async {
    debugPrint('_initializeApp...');
    await CommonFuncs().getEshkolotWorkingDirectory();
    MediaKit.ensureInitialized();

    await IsarService().init();

    SharedPreferences preferences = await SharedPreferences.getInstance();

    final usbDir = await CommonFuncs().getEshkolotWorkingDirectory();
    final usbPreferences = UsbPreferences(usbDir);

    databaseInitialized = await checkDatabaseInitialized(preferences);

    if (!databaseInitialized) {
      if (CommonFuncs().checkIfUsb()) {
        await usbPreferences.setBool('database_initialized', false);
      }
      //else?? or save no matter
      await preferences.setBool('database_initialized', false);
      try {
        await InstallationDataHelper().init();
      }
      catch (e,s) {
        debugPrint("error!!! $e");
        debugPrint("stack $s");
        setState(() {
          _initializeError = true;
          errorString=e.toString();
        // Sentry.addBreadcrumb(Breadcrumb(message: "error!!!"));
        Sentry.addBreadcrumb(Breadcrumb(message: "error!!! $e" "stack $s"));
        });
      }
      await IsarService().cleanDb();

      myCourses.addAll(InstallationDataHelper().myCourses);

      List<Quiz> questionnaires = [];
      List<Lesson> lessons = [];
      final List<Subject> subjects = [];

      subjects.addAll(InstallationDataHelper().mySubjects);
      lessons.addAll(InstallationDataHelper().myLessons);
      questionnaires.addAll(InstallationDataHelper().myQuizzes);

      List<Knowledge> knowledgeList = [];
      List<LearnPath> paths = [];

      knowledgeList.addAll(InstallationDataHelper().myKnowledgeList);
      paths.addAll(InstallationDataHelper().myPathList);

      debugPrint('filling!!');
      Sentry.addBreadcrumb(Breadcrumb(message: 'filling data!!'));
      await IsarService().initData(
          myCourses,
          subjects,
          lessons,
          questionnaires,
          knowledgeList,
          paths,
          InstallationDataHelper().data['users'].cast<Map<String, dynamic>>());
      await IsarService().updateUserParentData(InstallationDataHelper().data['user_type'],
          InstallationDataHelper().data['user_mail']??'');
      await preferences.setBool('database_initialized', true);
      if (CommonFuncs().checkIfUsb()) {
        await usbPreferences.setBool('database_initialized', true);
      }
    } else {
      debugPrint('data was filled');
      Sentry.addBreadcrumb(Breadcrumb(message: 'data was filled'));
      //todo needed?? not in old version
      //  myCourses = InstallationDataHelper().myCourses;
    }

    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      Sentry.captureException(
        errorDetails.exception,
        stackTrace: errorDetails.stack,
      );

      if (kDebugMode) {
        FlutterError.presentError(errorDetails);
      }
    };

    setState(() {
      _initialized = true;
      debugPrint('_initialized $_initialized');
    });

    Future.microtask(() {
      if (!appWindow.isVisible) {
        debugPrint('🟢 Flutter ready — showing window now');
        appWindow.show();
      }
    });
  }

  Future<bool> checkDatabaseInitialized(preferences) async {
    if (CommonFuncs().checkIfUsb()) {
      Directory dir = await CommonFuncs().getEshkolotWorkingDirectory();
      final prefs = UsbPreferences(dir);
      return !await IsarService().checkIfDBisEmpty() &&
          (await prefs.getBool('database_initialized') ?? false);
    } else {
      return !await IsarService().checkIfDBisEmpty() &&
          (preferences.getBool('database_initialized') ?? false);
    }
  }
}

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FutureOr<SentryEvent?> beforeSend(SentryEvent event, Hint hint) async {
      var connectivityResult = await Connectivity().checkConnectivity();

      if (!await NetworkConnectivity.instance.checkConnectivity()) {
        String eventJson = const JsonEncoder().convert(event.toJson());
        await LocalFileHelper().writeEvent(eventJson);
        return null;
      }

      return event;
    }

    await Sentry.init((options) {
      options.dsn = kDebugMode
          ? ''
          : 'https://0305d132e35b4bfea621838e8aaee3de@o4505141567619072.ingest.sentry.io/4505141614084096';
      options.tracesSampleRate = 1.0;
      options.sendDefaultPii = true;
      options.enablePrintBreadcrumbs = true;
      options.beforeSend = beforeSend;
    });

    runApp(const MyRootApp());

    // await Future.delayed(const Duration(milliseconds: 10000));

    doWhenWindowReady(() async {
      debugPrint('✅ doWhenWindowReady');

      setWindowVisibility(visible: true);
      setWindowTitle('אשכולות אופליין');
      // appWindow.show();
    });
  }, (error, stackTrace) {
    print('Error : $error');
    print('StackTrace : $stackTrace');
    Sentry.captureException(error, stackTrace: stackTrace);
  });
}

class MyApp extends StatefulWidget {
  final List<Course> courses;
  final bool dataWasFilled;

  const MyApp({super.key, required this.courses, required this.dataWasFilled});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<VideoIsar> vi;
  late bool allDownloaded;
  Future? myFuture;
  bool firstTime = true;
  final Connectivity _connectivity = Connectivity();
  late bool isNetWorkConnection;
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  late String destDirPath;
  late bool showProgress = false, extractWorked;
  bool didGetVideosCorrect = false;
  late SharedPreferences preferences;
  late List<Course> courses;
  bool isLoading = false;
  bool timeout = false;

  @override
  void initState() {
    courses = widget.courses;
    _networkConnectivity.initialise();
    if (!widget.dataWasFilled) {
      // myFuture =setDataFiles();
      debugPrint('1===setDataFiles');

      setDataFiles();
    } else {
      showProgress = true;
      getSharedPrefs().then((value) {
        if (!extractWorked) {
          debugPrint('2===setDataFiles extractWorked $extractWorked');
          setDataFiles();
        } else {
          showProgress = false;
          setState(() {});
        }
        // else if(!didGetVideosCorrect)
        //   {
        //
        //   }
      });
    }

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: widget.dataWasFilled && didGetVideosCorrect && extractWorked
            ? const LoginPage()
            : showProgress
                ? showProgressExtractWidget()
                // todo disable continue if not all videos files of courses are existed
                : extractWorked && didGetVideosCorrect
                    ? const LoginPage()
                    : Center(
                        child: !timeout
                            ? Text(
                                !extractWorked ? 'ישנה בעיה 1' : 'ישנה בעיה 2',
                                style: TextStyle(fontSize: 30.sp))
                            : Text(
                                'התהליך לוקח מידי הרבה זמן,פנה לתמיכה',
                                style: TextStyle(fontSize: 30.sp))));
  }

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    extractWorked = prefs.getBool("extractWorked") ?? false;
    didGetVideosCorrect = prefs.getBool("didGetVideosCorrect") ?? false;
    if (courses.isEmpty) {
      courses = await IsarService().getAllCourses();
    }
    setState(() {});
  }

  Future<bool> setDataFiles() async {
    debugPrint('setDataFiles===');
    int numOfCourseWithVideos = 0;
    showProgress = true;
    setState(() {});
    preferences = await SharedPreferences.getInstance();
    preferences.setBool('extractWorked', false);
    // final Directory directory = await CommonFuncs().getEshkolotWorkingDirectory();
    final Directory directory =
        await CommonFuncs().getEshkolotWorkingDirectory();
    destDirPath = directory.path;
    //destDirPath = await CommonFuncs().findEshkolotFolderOnUsb();
    int isolateRes = await extractZipFileUsingIsolate([
      '$destDirPath/${Constants.quizPath}/',
      '$destDirPath/${Constants.lessonPath}/'
    ]);
    extractWorked = isolateRes == 0;

    if (extractWorked) {
      debugPrint('extractWorked ${courses.length}');
      preferences.setBool('extractWorked', true);
      for (Course course in courses) {
        bool b = await InstallationDataHelper().setLessonVideosNum(course);
        if (b) {
          numOfCourseWithVideos++;
        }
      }
      if (numOfCourseWithVideos == courses.length) {
        preferences.setBool('didGetVideosCorrect', true);
        didGetVideosCorrect = true;
      } else {
        preferences.setBool('didGetVideosCorrect', false);
        didGetVideosCorrect = false;
      }
    } else {
      if (isolateRes == 1) {
        debugPrint('isolate timeout');
        await Sentry.addBreadcrumb(Breadcrumb(message: 'isolate timeout'));
        timeout = true;
      }
    }
    debugPrint(
        'extractWorked  $extractWorked didGetVideosCorrect $didGetVideosCorrect');
    await Sentry.captureMessage(
        'extractWorked  $extractWorked didGetVideosCorrect $didGetVideosCorrect');

    showProgress = false;
    setState(() {});
    return true;
  }

  showProgressExtractWidget() {
    return Column(
      children: [
        const TitleBarWidget(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('...מתכונן להפעלת התוכנה, פעולה זו עלולה לקחת כמה דקות',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 40.sp)),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ],
    );
  }

// void extractZipIsolate(SendPort sendPort) {
//   ReceivePort receivePort = ReceivePort();
//   sendPort.send(receivePort.sendPort);
//
//   receivePort.listen((dynamic message) {
//     if (message is String) {
//       extractZipFile(message);
//     }
//   });
// }

// Future<void> extractZipFileUsingIsolate(String extractPath) async {
//   try {
//     ReceivePort receivePort = ReceivePort();
//     await Isolate.spawn(extractZipIsolate, receivePort.sendPort);
//
//     SendPort sendPort = await receivePort.first;
//
//     sendPort.send(extractPath);
//   } catch (e) {
//     debugPrint('Error extracting zips: $e');
//     Sentry.addBreadcrumb(Breadcrumb(message: 'Error extracting zips: $e'));
//   }
// }
}

Future<String?> getInstallerSourcePath() async {
  final exeDir = File(Platform.resolvedExecutable).parent;
  final file = File('${exeDir.path}/installer_source.txt');
  if (await file.exists()) {
    return (await file.readAsString()).trim();
  }
  return null;
}

Future<int> extractZipFileUsingIsolate(List<String> extractPath) async {
  ReceivePort receivePort = ReceivePort();
  late Isolate isolate;
  try {
    isolate = await Isolate.spawn(
        extractZipIsolate, [receivePort.sendPort, extractPath]);
    //
    // final res = await receivePort.first.timeout(
    //   const Duration(minutes: 45), // משך הזמן המקסימלי להמתנה
    //   onTimeout: () {
    //     return 'timeout';
    //   },
    // );

     final res = await receivePort.first;
    debugPrint('result $res');
    Sentry.addBreadcrumb(Breadcrumb(message: 'result from extract $res'));

    if (res is String) {
      if (res == 'finish') {
        return 0;
      } else if (res == 'timeout') {return 1;}
    }
    return 2;
  } on Object {
    debugPrint('isolate failed');
    return 2;
  } finally {
    //is needed??
    receivePort.close();
    // isolate.kill();
    isolate.kill(priority: Isolate.immediate);
  }
}

extractZipFile(String path, SendPort sendPort) async {
  // Get a list of files in the "lessons" folder
  List<FileSystemEntity> pathFiles = Directory(path).listSync();

  for (FileSystemEntity file in pathFiles) {
    if (file is File && file.path.endsWith('.zip')) {
      // Extract each zip file
      String zipFilePath = file.path;

      // Create the destination folder based on the zip file's name
      String destinationFolderName =
          file.path.split('/').last.replaceAll('.zip', '');
      String destinationPath = '$path$destinationFolderName';
      // Create the destination folder if it doesn't exist
      Directory(destinationPath).createSync(recursive: true);

      if (zipHasInvalidPaths(zipFilePath)) {
        final msg = 'ZIP file contains invalid file names: $zipFilePath';
        debugPrint(msg);
        // sendPort.send(msg);
        Sentry.addBreadcrumb(Breadcrumb(message: msg));
        continue;
      }

      try {
        extractFileToDisk(zipFilePath, destinationPath);
        debugPrint('Zip extraction completed for: $zipFilePath');
        Sentry.addBreadcrumb(
            Breadcrumb(message: 'Zip extraction completed for: $zipFilePath'));
      } catch (e) {
        sendPort.send('Error extracting zips for path $path: $e');
        debugPrint('Error extracting zips for path $path: $e');
        Sentry.addBreadcrumb(
            Breadcrumb(message: 'Error extracting zips for path $path: $e'));
      }
    }
  }
}

void extractZipIsolate(List<dynamic> args) async {
  SendPort sendPort = args[0];
  List<String> extractPaths = args[1];

  for (String path in extractPaths) {
    try {
      debugPrint('path $path');
      await extractZipFile(path, sendPort);
    } catch (e) {
      sendPort.send('Error extracting zips for path $path: $e');
      debugPrint('Error extracting zips for path $path: $e');
      Sentry.addBreadcrumb(
          Breadcrumb(message: 'Error extracting zips for path $path: $e'));
    }
  }
  Isolate.exit(sendPort, 'finish');
}

bool zipHasInvalidPaths(String zipFilePath) {
  try {
    final inputStream = InputFileStream(zipFilePath);
    final archive = ZipDecoder().decodeBuffer(inputStream);

    for (final file in archive.files) {
      if (_containsInvalidPath(file.name)) {
        debugPrint('ZIP contains invalid file name: ${file.name}');
        return true;
      }
    }
  } catch (e) {
    debugPrint('Failed to scan zip file: $zipFilePath, error: $e');
    return true; // לשם הזהירות, אם יש שגיאה בקריאה - נניח שה־ZIP לא תקין
  }

  return false;
}

bool _containsInvalidPath(String path) {
  return RegExp(r'[<>:"/\\|?*]').hasMatch(path);
}
