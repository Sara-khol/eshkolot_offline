import 'dart:async';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/services/installationDataHelper.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/services/localFileHelper.dart';
import 'package:eshkolot_offline/services/network_check.dart';
import 'package:eshkolot_offline/services/vimoe_service.dart';
import 'package:eshkolot_offline/ui/screens/login/login_page.dart';
import 'package:eshkolot_offline/ui/screens/main_page/title_bar_widget.dart';
import 'package:eshkolot_offline/utils/constants.dart' as Constants;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_size/window_size.dart';
import 'models/course.dart';
import 'models/knowledge.dart';
import 'models/lesson.dart';
import 'models/quiz.dart';
import 'dart:convert';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'models/videoIsar.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FutureOr<SentryEvent?> beforeSend(SentryEvent event, {Hint? hint}) async {
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
        // options.debug = true;
        options.sendDefaultPii = true;
        options.enablePrintBreadcrumbs = true;

        //  options.debug=false;
        // options.beforeBreadcrumb =beforeBreadcrumbCallback;
        options.beforeSend = beforeSend;

        // options.maxRequestBodySize = MaxRequestBodySize.small;
        // options.maxResponseBodySize = MaxResponseBodySize.small;
      },
      // appRunner: () => runApp(MyApp()),
    );

    DartVLC.initialize();

    late String destDirPath;
    List<Course> myCourses = [];

    extractZipFile(String extractPath) async {
      try {
        // Get a list of files in the "lessons" folder
        List<FileSystemEntity> lessonFiles = Directory(extractPath).listSync();

        for (FileSystemEntity file in lessonFiles) {
          if (file is File && file.path.endsWith('.zip')) {
            // Extract each zip file
            String zipFilePath = file.path;

            // Create the destination folder based on the zip file's name
            String destinationFolderName =
                file.path.split('/').last.replaceAll('.zip', '');
            String destinationPath = '$extractPath/$destinationFolderName/';

            // Create the destination folder if it doesn't exist
            Directory(destinationPath).createSync(recursive: true);

            // Read the zip file
            List<int> bytes = await file.readAsBytes();

            // Extract the zip contents
            Archive archive = ZipDecoder().decodeBytes(bytes);
            for (ArchiveFile archiveFile in archive) {
              String fileName = archiveFile.name;
              if (archiveFile.isFile) {
                // Get the file content as a List<int>
                List<int> fileData = archiveFile.content as List<int>;

                // Create the file in the destination folder
                File destinationFile = File('$destinationPath$fileName');
                destinationFile.createSync(recursive: true);
                destinationFile.writeAsBytesSync(fileData);
              } else {
                // If it's a directory, create the directory in the destination folder
                Directory('$destinationPath$fileName')
                    .createSync(recursive: true);
              }
            }
            debugPrint('Zip extraction completed for: $zipFilePath');
          }
        }
      } catch (e) {
        debugPrint('Error extracting zips: $e');
      }
    }

    setDataFiles() async {
      final Directory directory = await getApplicationSupportDirectory();
      destDirPath = directory.path;
      await extractZipFile('$destDirPath/${Constants.lessonPath}/');
      await extractZipFile('$destDirPath/${Constants.quizPath}/');
    }

    IsarService().init();

    initData() async {
      // if (await IsarService().checkIfDBisEmpty()) {
      // await extractZipFile();
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
      setWindowTitle('My Demo');
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

  MyApp({super.key, required this.courses, required this.dataWasFilled});

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

  @override
  void initState() {
    // networkConnectivity.startNetworkConnectivityCheck();
    // if(!widget.dataWasFilled)
    //   {
    //

    _networkConnectivity.initialise();
    // myFuture = isVideosDownload();
    if(!widget.dataWasFilled) {
      myFuture = setDataFiles();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      //  textStyle: const TextStyle(fontSize: 19.0, color: Colors.white),
      //  backgroundColor: Colors.grey,
      //  animationCurve: Curves.easeIn,
      // // animationBuilder: const Miui10AnimBuilder(),
      //  animationDuration: const Duration(milliseconds: 200),
      //  duration: const Duration(seconds: 3),
      child: ScreenUtilInit(
          designSize: const Size(1920, 1080),
          minTextAdapt: true,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                    primarySwatch: Colors.blue, fontFamily: 'RAG-Sans'),
                home: Scaffold(
                    backgroundColor: Colors.white,
                    body: widget.dataWasFilled
                        ? LoginPage()
                        : FutureBuilder(
                            future: myFuture,
                            builder: (context, s) {
                              if (s.hasData) {
                                for(Course course in widget.courses) {
                                  InstallationDataHelper().setLessonVideosNum(course);
                                }
                                return LoginPage();
                              }
                              return const Center(child: CircularProgressIndicator());
                            }))
                // FutureBuilder(
                //     future: myFuture,
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         vi = snapshot.data ?? [];
                //         if (allDownloaded) return LoginPage();
                //       //???
                //         return  /*(widget.dataWasFilled &&
                //                     widget.courses.isNotEmpty) ||
                //                 !widget.dataWasFilled
                //             ?*/
                //           ChangeNotifierProvider<VimoeService>(
                //                 create: (_) => VimoeService(),
                //                 builder: (context, child) {
                //                   {
                //                     if (firstTime) {
                //                       context
                //                               .read<VimoeService>()
                //                               .isNetWorkConnection =
                //                           isNetWorkConnection;
                //                       if (widget.courses.isNotEmpty ||
                //                           vi.isEmpty || checkDateExpired()) {
                //                         context.read<VimoeService>().courses =
                //                             widget.courses;
                //                       context.read<VimoeService>().start();
                //                       } else {
                //                         context
                //                             .read<VimoeService>()
                //                             .isarVideoList = vi;
                //                         context
                //                             .read<VimoeService>()
                //                             .startDownLoading();
                //                         context
                //                             .read<VimoeService>()
                //                             .finishConnectToVimoe = true;
                //                       }
                //                       firstTime = false;
                //                     }
                //
                //                     return Consumer<VimoeService>(
                //                         builder: (context, vimoeResult, child) {
                //                       switch (vimoeResult.downloadStatus) {
                //                         case DownloadStatus.downloading:
                //                           return displayLoadingDialog(
                //                               false, context, false, false);
                //                         case DownloadStatus.blockError:
                //                           return displayLoadingDialog(
                //                               true, context, true, false);
                //                         case DownloadStatus.error:
                //                           return displayLoadingDialog(
                //                               true, context, false, false);
                //                         case DownloadStatus.downloaded:
                //                           context.read<VimoeService>().dispose();
                //                           return LoginPage();
                //                         case DownloadStatus.netWorkError:
                //                           return displayLoadingDialog(
                //                               false, context, false, true);
                //                       }
                //                     });
                //                   }
                //                 });
                //       }
                //       return const Center(
                //         child: Scaffold(
                //             backgroundColor: Colors.white,
                //             body: Center(child: CircularProgressIndicator())),
                //       );
                //     })
                );
          }),
    );
  }

  Future<bool> setDataFiles() async {
    final Directory directory = await getApplicationSupportDirectory();
    destDirPath = directory.path;
    await extractZipFile('$destDirPath/${Constants.lessonPath}/');
    await extractZipFile('$destDirPath/${Constants.quizPath}/');
    debugPrint('finish!!!');
    return true;
  }

  extractZipFile(String extractPath) async {
    try {
      // Get a list of files in the "lessons" folder
      List<FileSystemEntity> lessonFiles = Directory(extractPath).listSync();

      for (FileSystemEntity file in lessonFiles) {
        if (file is File && file.path.endsWith('.zip')) {
          // Extract each zip file
          String zipFilePath = file.path;

          // Create the destination folder based on the zip file's name
          String destinationFolderName =
              file.path.split('/').last.replaceAll('.zip', '');
          String destinationPath = '$extractPath/$destinationFolderName/';

          // Create the destination folder if it doesn't exist
          Directory(destinationPath).createSync(recursive: true);

          // Read the zip file
          List<int> bytes = await file.readAsBytes();

          // Extract the zip contents
          Archive archive = ZipDecoder().decodeBytes(bytes);
          for (ArchiveFile archiveFile in archive) {
            String fileName = archiveFile.name;
            if (archiveFile.isFile) {
              // Get the file content as a List<int>
              List<int> fileData = archiveFile.content as List<int>;

              // Create the file in the destination folder
              File destinationFile = File('$destinationPath$fileName');
              destinationFile.createSync(recursive: true);
              destinationFile.writeAsBytesSync(fileData);
            } else {
              // If it's a directory, create the directory in the destination folder
              Directory('$destinationPath$fileName')
                  .createSync(recursive: true);
            }
          }
          debugPrint('Zip extraction completed for: $zipFilePath');
        }
      }
    } catch (e) {
      debugPrint('Error extracting zips: $e');
    }
  }

  Widget displayLoadingDialog(bool isError, BuildContext context,
      bool blockError, bool isNetWorkError) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            TitleBarWidget(),
            Expanded(
              child: Container(
                color: Colors.black12,
                child: isError && !isNetWorkError
                    ? SimpleDialog(
                        contentPadding: EdgeInsets.all(30),
                        title: Center(child: Text('!ישנה בעיה')),
                        children: <Widget>[
                            if (blockError)
                              Center(
                                  child: Text(
                                      'נראה שהלינקים הלללו חסומים ברשת האינטרנט שלך')),
                            if (blockError)
                              Center(
                                  child: Text(
                                      'נא פנה לספק האינטרנט שלך על מנת להסדיר את הענין')),
                            SizedBox(
                              height: 15,
                            ),
                            if (blockError)
                              SizedBox(
                                width: double.minPositive,
                                child: ListView(
                                    shrinkWrap: true,
                                    children: displayBlockedLinks(context)),
                              ),
                            ElevatedButton(
                                onPressed: () {
                                  // context
                                  //     .read<VimoeService>().startDownLoading(
                                  //     notify: true);

                                  context
                                      .read<VimoeService>()
                                      .start(notify: true);
                                },
                                child: Text('נסה שנית'))
                          ])
                    : !isNetWorkError
                        ? const SimpleDialog(
                            title: Center(child: Text('הנתונים נטענים')),
                            children: <Widget>[
                                Center(child: CircularProgressIndicator()),
                                // Text(context
                                //     .read<VimoeService>()
                                //     .numCoursesDownloaded
                                //     .toString())
                              ])
                        : const SimpleDialog(
                            title: Center(child: Text('אין חיבור לאינטרנט')),
                            children: <Widget>[
                                Center(
                                    child: Text(
                                        'נא בדוק את החיבורים על מנת שנוכל להמשיך בהורדת הנתונים')),
                              ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  displayBlockedLinks(BuildContext context) {
    List<Widget> myLinks = [];
    for (String link in context.read<VimoeService>().blockLinks) {
      // myLinks.add(SelectableText(link,style: TextStyle(decoration: TextDecoration.underline),));
      myLinks.add(Padding(
        padding: EdgeInsets.only(bottom: 7),
        child: Center(
          child: InkWell(
            child: Text(link,
                style: TextStyle(decoration: TextDecoration.underline)),
            onTap: () => _launchUrl(link),
          ),
        ),
      ));
    }

    return myLinks;
  }

  Future<void> _launchUrl(String link) async {
    Uri uri = Uri.parse(link);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  Future<List<VideoIsar>> isVideosDownload() async {
    // isNetWorkConnection = await checkConnectivity();
    isNetWorkConnection = await _networkConnectivity.checkConnectivity();

    allDownloaded = await IsarService().checkIfAllVideosAreDownloaded(true);
    if (!allDownloaded) {
      return IsarService().getAllVideosToDownload([]);
    }

    return [];
  }

  checkDateExpired() {
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    // Convert current datetime to seconds

    for (VideoIsar videoIsar in vi) {
      if (!videoIsar.isDownload && currentTimestamp > videoIsar.expiredDate) {
        debugPrint('url was expired');
        return true;
      }
    }

    return false;
  }
}
