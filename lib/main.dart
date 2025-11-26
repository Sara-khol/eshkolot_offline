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
import 'package:path/path.dart' as p;




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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ישנה בעיה\n$errorString',textAlign: TextAlign.center,),
             // SizedBox(height: 20.h),
              // ElevatedButton(onPressed: (){
              //   Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (context) => const LoginPage()));},
              //     child: Text('המשך בכל זאת'))
            ],
          ),
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
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    ':שגיאה',
                                    style: TextStyle(fontSize: 30.sp)),
                                Text(
                                    !extractWorked ? 'לא כל הקבצים חולצו כראוי' : 'חסר סרטונים של קורס אחד לפחות',
                                    style: TextStyle(fontSize: 30.sp)),
                                SizedBox(height: 20.h),
                                ElevatedButton(onPressed: (){
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) => const LoginPage()));},
                                    child: Text('למעבר לתוכנה בכל זאת'))
                              ],
                            )
                            : Text(
                                'התהליך לוקח מידי הרבה זמן,פנה לתמיכה',
                                style: TextStyle(fontSize: 30.sp))));
  }

  /// Returns available space (in bytes) of the disk where [path] is located.
  /// Returns null if cannot determine.
  Future<int?> getAvailableDiskSpace(String path) async {
    try {
      final dir = Directory(path);

      if (!dir.existsSync()) {
        await dir.create(recursive: true);
      }

      final result = await Process.run(
        Platform.isWindows ? 'wmic' : 'df',
        Platform.isWindows
            ? ['logicaldisk', 'where', "DeviceID='${path[0].toUpperCase()}:'", 'get', 'FreeSpace']
            : ['-k', path],
      );

      final output = result.stdout.toString();

      if (Platform.isWindows) {
        // Example: "FreeSpace\n1234567890\n"
        final lines = output.split(RegExp(r'\s+')).where((s) => s.trim().isNotEmpty).toList();
        if (lines.length >= 2) {
          return int.tryParse(lines[1]);
        }
      } else {
        // Example: Filesystem   1K-blocks     Used Available Use% Mounted on
        //          /dev/sda1     30408756 12345678 18000000  41% /
        final parts = output.split(RegExp(r'\s+'));
        if (parts.length > 10) {
          final availableKB = int.tryParse(parts[10]);
          return availableKB != null ? availableKB * 1024 : null;
        }
      }
    } catch (_) {}
    return null;
  }

  Future<int> calculateTotalZipSize(List<String> folders) async {
    int total = 0;

    for (final folder in folders) {
      final dir = Directory(folder);
      if (!dir.existsSync()) continue;

      for (final file in dir.listSync(recursive: false)) {
        if (file is File && file.path.toLowerCase().endsWith('.zip')) {
          total += await file.length();
        }
      }
    }
    return total;
  }

  void deleteZipFiles(List<String> extractPaths) {
    for (final path in extractPaths) {
      final directory = Directory(path);
      if (!directory.existsSync()) continue;

      for (final file in directory.listSync()) {
        if (file is File && file.path.toLowerCase().endsWith('.zip')) {
          try {
            file.deleteSync();
            debugPrint('Deleted zip: ${file.path}');
          } catch (e) {
            debugPrint('❌ Failed to delete zip: $e');
          }
        }
      }
    }
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

    final hasSpace = await hasEnoughSpaceForExtraction(
      zipFolders: [
        '$destDirPath/${Constants.quizPath}/',
        '$destDirPath/${Constants.lessonPath}/',
      ],
      targetPath: destDirPath,
    );

    if (!hasSpace) {
      await Sentry.captureMessage(
          'no space on disk for extraction');
      showProgress = false;
      await showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text("שגיאת מקום בדיסק",  textDirection: TextDirection.rtl),
          content: Text( "אין מספיק מקום כדי לחלץ את הקבצים",  textDirection: TextDirection.rtl),

        ),
      );
      setState(() {});
      return false;
    }


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
           /*   Text('מחולץ ZIP $extractedZips מתוך $totalZips'),
              LinearProgressIndicator(
                value: totalZips == 0 ? null : extractedZips / totalZips,
                minHeight: 15,
              ),*/
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ],
    );
  }


  Future<int> calculateZipTotalSize(List<String> folders) async {
    int total = 0;

    for (final folder in folders) {
      final dir = Directory(folder);
      if (!dir.existsSync()) continue;

      for (final file in dir.listSync(followLinks: false)) {
        if (file is File && file.path.toLowerCase().endsWith('.zip')) {
          total += await file.length();
        }
      }
    }
    return total; // bytes
  }

  Future<bool> hasEnoughSpaceForExtraction({
    required List<String> zipFolders,
    required String targetPath,
    int reserveBytes = 500 * 1024 * 1024, // רזרבה מומלצת 500MB
  }) async {

    // 1. כמה מקום פנוי יש
    final freeBytes = await getAvailableDiskSpace(targetPath);
    debugPrint('freeBytes $freeBytes');
    if (freeBytes == null) return true; // לא ידוע – נותנים להתקדם

    // 2. כמה שוקלים כל הזיפים
    final zipBytes = await calculateZipTotalSize(zipFolders);
    debugPrint('zipBytes $zipBytes');
    if (zipBytes == 0) return true; // אין ZIP – אין מה לחשב

    // 3. הערכת גודל החילוץ
    final expectedExtractSize = zipBytes * 2;
    debugPrint('expectedExtractSize $expectedExtractSize');


    // 4. בלי הזיפים לאחר המחיקה
    final effectiveFree = freeBytes + zipBytes;
    debugPrint('effectiveFree $effectiveFree');


    return effectiveFree >= expectedExtractSize + reserveBytes;
  }



  Future<int> extractZipFileUsingIsolate(List<String> extractPath) async {
    ReceivePort receivePort = ReceivePort();
    late Isolate isolate;
    try {
      isolate = await Isolate.spawn(
          extractZipIsolate, [receivePort.sendPort, extractPath]);

      String? finalResult;
      final completer = Completer<String>();

      // 🟦 שומעים על כל ההודעות מה-isolate
      late StreamSubscription sub;
      sub = receivePort.listen((msg) {
        if (msg is String) {

          // ---- Finish ----
          if (msg == 'finish') {
            finalResult = 'finish';
            completer.complete('finish');
          }
        }
      });

      // 🟦 timeout
      final result = await completer.future.timeout(
        const Duration(hours: 4),
        onTimeout: () => 'timeout',
      );

      await sub.cancel(); // חובה!
      return result == 'finish'
          ? 0
          : result == 'timeout'
          ? 1
          : 2;
    } catch (e) {
      debugPrint("isolate failed: $e");
      return 2;
    } finally {
      receivePort.close();
      isolate.kill(priority: Isolate.immediate);
    }
  }
}


/*  final res = await receivePort.first.timeout(
      const Duration(hours: 4), // משך הזמן המקסימלי להמתנה
      onTimeout: () {
        return 'timeout';
      },
    );

  //   final res = await receivePort.first;
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
  }}*/



bool _containsInvalidPath(String name) {
  // Normalize separators to forward slash
  final normalized = name.replaceAll(r'\', '/');

  // Split into segments and check for any segment that's exactly ".."
  final parts = normalized.split('/');
  for (final seg in parts) {
    if (seg == '..') return true; // path traversal attempt
    if (seg.isEmpty) continue;
    // also check for illegal characters in each segment:
    if (RegExp(r'[<>:"/\\|?*\x00-\x1F]').hasMatch(seg)) return true;
  }

  return false;
}

void _extractZipSkippingInvalid({
  required String zipFilePath,
  required String destinationPath,
  required void Function(String msg) send,
}) {
  InputFileStream? input;
  try {
    input = InputFileStream(zipFilePath);
    final original = ZipDecoder().decodeBuffer(input);

    // Build a new Archive containing only valid entries
    final cleaned = Archive();
    int skipped = 0;

    for (final entry in original.files) {
      final originalName = entry.name;

      if (_containsInvalidPath(originalName)) {
        debugPrint('invalid $originalName');
        skipped++;
        ('⚠️ Skipping invalid entry: ${entry.name}');
        continue;
      }

      // נרמול מפרידים ובניית נתיב יעד חוצה-פלטפורמות
      final relNormalized = originalName.replaceAll(r'\', '/');
      final parts = relNormalized.split('/').where((s) => s.isNotEmpty).toList();
      final outPath = p.joinAll([destinationPath, ...parts]);
      // Keep the entry as-is (no renaming)
      cleaned.addFile(entry);


      if (entry.isFile) {
        // יוצרים תיקיית אב, ואז כותבים בסטרימינג (ללא טעינה לזיכרון)
        Directory(p.dirname(outPath)).createSync(recursive: true);
        final out = OutputFileStream(outPath);
        try {
          entry.writeContent(out);
        } finally {
          out.close();
        }
        //written++;
      } else {
        // רשומת תיקייה
        Directory(outPath).createSync(recursive: true);
        //dirs++;
      }

    }

    // // Ensure destination exists
    // Directory(destinationPath).createSync(recursive: true);
    //
    // // Extract remaining files
    // extractArchiveToDisk(cleaned, destinationPath);

    debugPrint('✅ Zip extracted: $zipFilePath (skipped: $skipped)');
  } catch (e) {
    send('❌ Error extracting "$zipFilePath": $e');
   // sendPort.send('Error extracting zips for path $path: $e');
    debugPrint('Error extracting zips for path $zipFilePath: $e');
    Sentry.addBreadcrumb(
        Breadcrumb(message: 'Error extracting zips for path $zipFilePath: $e'));
  } finally {
    input?.close();
  }
}

Future<void> extractZipFile(String path, SendPort sendPort) async {
  int totalZips = 0;
  int extractedZips = 0;

  // List ZIP files in the given directory
  final pathFiles = Directory(path).listSync();

  final zipFiles = pathFiles
      .where((f) => f is File && f.path.toLowerCase().endsWith('.zip'))
      .toList();

  totalZips += zipFiles.length;     // ← ספירת ZIPים
  sendPort.send("TOTAL_ZIPS:$totalZips");



  for (final file in zipFiles) {
    // if (file is! File) continue;
    // if (!file.path.toLowerCase().endsWith('.zip')) continue;

    final zipFilePath = file.path;

    // Build destination folder safely across platforms
    final baseName = p.basenameWithoutExtension(zipFilePath);
    final destinationPath = p.join(path, baseName);

    try {
      _extractZipSkippingInvalid(
        zipFilePath: zipFilePath,
        destinationPath: destinationPath,
        send: (msg) => sendPort.send(msg),
      );

      try {
        await Future.delayed(Duration(milliseconds: 30)); // fix for Windows
        File(zipFilePath).deleteSync();
      } catch (e) {
        debugPrint("Failed deleting ZIP: $e");
      }

      // 3️⃣ Update progress
      extractedZips++;
      sendPort.send("PROGRESS:$extractedZips/$totalZips");

    } catch (e) {
      sendPort.send('❌ Error extracting "$zipFilePath": $e');
      // continue to next zip
    }
  }
}

void extractZipIsolate(List<dynamic> args) async {
  final SendPort sendPort = args[0];
  final List<String> extractPaths = args[1];

  for (final path in extractPaths) {
    try {
      await extractZipFile(path, sendPort);
    } catch (e) {
      debugPrint('Error extracting zips for path $path: $e');
      Sentry.addBreadcrumb(
          Breadcrumb(message: 'Error extracting zips for path $path: $e'));
      sendPort.send('❌ Error extracting zips for path $path: $e');
    }
  }
  Isolate.exit(sendPort, 'finish');
}

