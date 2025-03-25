import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/services/installationDataHelper.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/services/localFileHelper.dart';
import 'package:eshkolot_offline/services/network_check.dart';
import 'package:eshkolot_offline/ui/screens/login/login_page.dart';
import 'package:eshkolot_offline/ui/screens/main_page/title_bar_widget.dart';
import 'package:eshkolot_offline/ui/screens/main_page/top_bar_user_widget.dart';
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
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'models/videoIsar.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;
import 'package:media_kit/media_kit.dart';                      // Provides [Player], [Media], [Playlist] etc.


Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    beforeSend(SentryEvent event, {Hint? hint}) async {
// Check internet connectivity
      var connectivityResult = await Connectivity().checkConnectivity();
      // if (connectivityResult == ConnectivityResult.none) {
      if (!await NetworkConnectivity.instance.checkConnectivity()) {
        // Store the event locally for later sending
        String eventJson = const JsonEncoder().convert(event.toJson());

        await LocalFileHelper().writeEvent(eventJson);
        return null; // Prevent the event from being sent
      }
      // Send the event to Sentry
      return event;
    }

    await Sentry.init(
      (options) {
        options.dsn = kDebugMode
            ? ''
            : 'https://0305d132e35b4bfea621838e8aaee3de@o4505141567619072.ingest.sentry.io/4505141614084096';
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
         //options.debug = true;
        options.sendDefaultPii = true;
        options.enablePrintBreadcrumbs = true;

        //  options.debug=false;
        // options.beforeBreadcrumb =beforeBreadcrumbCallback;
        options.beforeSend = beforeSend as BeforeSendCallback?;



        // options.maxRequestBodySize = MaxRequestBodySize.small;
        // options.maxResponseBodySize = MaxResponseBodySize.small;
      },
      // appRunner: () => runApp(MyApp()),
    );

   WidgetsFlutterBinding.ensureInitialized();
    // Necessary initialization for package:media_kit.
    MediaKit.ensureInitialized();

    List<Course> myCourses = [];

    IsarService().init();

    initData() async {
      await InstallationDataHelper().init();
      await IsarService().cleanDb();

      myCourses.addAll(InstallationDataHelper().myCourses);

      //  generateJsonData();

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
      await IsarService().initCourses(
          myCourses /*data['courses'].cast<Map<String, dynamic>>()*/,
          subjects,
          lessons,
          questionnaires,
          knowledgeList,
          paths,
          InstallationDataHelper().data['users'].cast<Map<String, dynamic>>());
      // course = await IsarService.instance.getFirstCourse();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();

    Future<bool> checkDatabaseInitialized(SharedPreferences preferences) async {
      return !await IsarService().checkIfDBisEmpty() &&
          (preferences.getBool('database_initialized') ?? false);
    }

    bool databaseInitialized = await checkDatabaseInitialized(preferences);

    if (!databaseInitialized) {
      //when db was erased manually
      //todo remove??
      await preferences.setBool('database_initialized', false);
      await initData();
      await preferences.setBool('database_initialized', true);
      //  await setDataFiles();
      // for(Course course in myCourses) {
      //   InstallationDataHelper().setLessonVideosNum(course);
      // }
    } else {
      debugPrint('data was filled');
      Sentry.addBreadcrumb(Breadcrumb(message: 'data was filled'));
    }
    // Course? c1, c2;
    // if (myCourses.isNotEmpty) {
    //   c1 = myCourses.firstWhere((item) => item.serverId == 2782842);
    //   c2 = myCourses.firstWhere((item) => item.serverId == 2567060);
    // }

    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      Sentry.captureException(
        errorDetails.exception,
        stackTrace: errorDetails.stack,
      );
      if (kDebugMode) {
        FlutterError.presentError(errorDetails);
        // myErrorsHandler.onErrorDetails(errorDetails);
      }
    };

    // FlutterError.onError = (details) {
    //   FlutterError.presentError(details);
    //   myErrorsHandler.onErrorDetails(details);
    // };
    // PlatformDispatcher.instance.onError = (error, stack) {
    //   myErrorsHandler.onError(error, stack);
    //   return true;
    // };

    // runApp(MyApp());

    runApp(MyApp(
        courses: myCourses /*c1 == null || c2 == null ? myCourses : [c1, c2]*/,
        dataWasFilled: databaseInitialized));

    doWhenWindowReady(() {
      setWindowVisibility(visible: true);
      setWindowTitle('אשכולות אופליין');
      // const initialSize = Size(1280, 720);
      // appWindow.minSize = initialSize;
      // appWindow.size = initialSize;
      // appWindow.alignment = Alignment.center;
      //
      //appWindow.show();
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
  late bool showProgress=false , extractWorked;
  bool didGetVideosCorrect = false;
  late SharedPreferences preferences;
  late List<Course> courses;
  bool isLoading= false;

  @override
  void initState() {
    courses= widget.courses;
    _networkConnectivity.initialise();
    if (!widget.dataWasFilled) {
      // myFuture =setDataFiles();
      setDataFiles();
    }
    else{
      showProgress=true;
      getSharedPrefs().then((value) {
        if(!extractWorked) {
          setDataFiles();
        }
        else
          {
            showProgress=false;
          }
        // else if(!didGetVideosCorrect)
        //   {
        //
        //   }
      });


    }

    super.initState();
  }

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    extractWorked = prefs.getBool("extractWorked")??false;
    didGetVideosCorrect = prefs.getBool("didGetVideosCorrect")??false;
    if(courses.isEmpty)
    {
      courses=await  IsarService().getAllCourses();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
          designSize: const Size(1920, 1080),
          minTextAdapt: true,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                    primaryColor: Colors.blue, fontFamily: 'RAG-Sans',
                textTheme:
                TextTheme(bodyMedium: TextStyle(color: colors.blackColorApp))),
                home: Scaffold(
                    backgroundColor: Colors.white,
                    body: widget.dataWasFilled && didGetVideosCorrect && extractWorked
                        ? const LoginPage()
                        : showProgress
                            ?  showProgressExtractWidget()
                    // todo disable continue if not all videos files of courses are existed
                            : extractWorked /*&& didGetVideosCorrect*/
                                ? const LoginPage()
                                : Center(
                                    child: Text(!extractWorked?'ישנה בעיה 1':'ישנה בעיה 2',
                                        style: TextStyle(fontSize: 30.sp)))));
          }),
    );
  }

  Future<bool> setDataFiles() async {
    int numOfCourseWithVideos = 0;
    showProgress = true;
    setState(() {});
    preferences = await SharedPreferences.getInstance();
    preferences.setBool('extractWorked', false);
    final Directory directory = await getApplicationSupportDirectory();
    destDirPath = directory.path;
    extractWorked = await extractZipFileUsingIsolate([
      '$destDirPath/${Constants.quizPath}/',
      '$destDirPath/${Constants.lessonPath}/'
    ]);
    if (extractWorked) {
      debugPrint('extractWorked ${courses.length}');
      preferences.setBool('extractWorked', true);
     // await Sentry.captureMessage('extract Worked $extractWorked');
      for (Course course in courses) {
        bool b = await InstallationDataHelper().setLessonVideosNum(course);
        if (b) {
          numOfCourseWithVideos++;
        }
      }
      if (numOfCourseWithVideos == courses.length) {
        preferences.setBool('didGetVideosCorrect', true);
        didGetVideosCorrect = true;
      }
      else{
        preferences.setBool('didGetVideosCorrect', false);
        didGetVideosCorrect = false;
      }
      debugPrint('extractWorked  $extractWorked didGetVideosCorrect $didGetVideosCorrect');
      await Sentry.captureMessage('extractWorked  $extractWorked didGetVideosCorrect $didGetVideosCorrect');
    }
    showProgress = false;
    setState(() {});
    return true;
  }

  showProgressExtractWidget()
  {
    return Column(
      children: [
        const TitleBarWidget(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('...מתכונן להפעלת התוכנה, פעולה זו עלולה לקחת כמה דקות', style: TextStyle(
                  fontWeight: FontWeight.w600,fontSize: 40.sp
              )),
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

Future<bool> extractZipFileUsingIsolate(List<String> extractPath) async {
  ReceivePort receivePort = ReceivePort();
  late Isolate isolate;
  try {
    isolate = await Isolate.spawn(
        extractZipIsolate, [receivePort.sendPort, extractPath]);

    final res = await receivePort.first;
    debugPrint('result $res');
    Sentry.addBreadcrumb(Breadcrumb(message:'result from extract $res' ));

    // if (res is String) {
    //   return res == 'finish';
    // }
    if (res is String && res == 'finish') {
      return true;
    }
    return false;
  } on Object {
    debugPrint('isolate failed');
    return false;
  } finally {
    //is needed??
    receivePort.close();
    isolate.kill();
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


      /*   // Use an InputFileStream to access the zip file without storing it in memory.
          final inputStream = InputFileStream(zipFilePath);
          // Decode the zip from the InputFileStream. The archive will have the contents of the
          // zip, without having stored the data in memory.
          final archive = ZipDecoder().decodeBuffer(inputStream);
         extractArchiveToDisk(archive, destinationPath);*/

      // For all of the entries in the archive
      /*for (var file in archive.files) {
            // If it's a file and not a directory
            if (file.isFile) {
              // Write the file content to a directory called 'out'.
              // In practice, you should make sure file.name doesn't include '..' paths
              // that would put it outside of the extraction directory.
              // An OutputFileStream will write the data to disk.
              final outputStream = OutputFileStream('$destinationPath${file.name}');
              // The writeContent method will decompress the file content directly to disk without
              // storing the decompressed data in memory.
              file.writeContent(outputStream);
              // Make sure to close the output stream so the File is closed.
              outputStream.close();
            }
          }*/

      // Create the destination folder if it doesn't exist
      //Directory(destinationPath).createSync(recursive: true);

      // // Read the zip file
      // List<int> bytes = await file.readAsBytes();
      //
      // Archive archive =  ZipDecoder().decodeBytes(bytes);
      // debugPrint('archiveeeeee');
      // for (ArchiveFile archiveFile in archive) {
      //   String fileName = archiveFile.name;
      //
      //   debugPrint('fileName $fileName');
      //
      //   if (archiveFile.isFile) {
      //     // Get the file content as a List<int>
      //     List<int> fileData = archiveFile.content as List<int>;
      //
      //     // Create the file in the destination folder
      //     File destinationFile = File('$destinationPath$fileName');
      //      destinationFile.createSync(recursive: true);
      //     destinationFile.writeAsBytesSync(fileData);
      //   } else {
      //     // If it's a directory, create the directory in the destination folder
      //     Directory('$destinationPath$fileName').createSync(
      //         recursive: true);
      //   }
      // }
      //debugPrint('Zip extraction completed for: $zipFilePath');
      // Sentry.addBreadcrumb(
      //     Breadcrumb(
      //         message: 'Zip extraction completed for: $zipFilePath'));
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
