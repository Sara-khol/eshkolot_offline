import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/services/vimoe_service.dart';
import 'package:eshkolot_offline/ui/screens/login_page.dart';
import 'package:eshkolot_offline/ui/screens/main_page/title_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_size/window_size.dart';
import 'models/course.dart';
import 'models/knowledge.dart';
import 'models/lesson.dart';
import 'models/questionnaire.dart';
import 'dart:convert';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'models/videoIsar.dart';

Future<void> main() async {
   DartVLC.initialize();
  List<Course> myCourses = [];
  bool dataWasFilled = false;

  IsarService().init();

  initData() async {
    if (await IsarService().checkIfDBisEmpty()) {
      dataWasFilled = true;
      Map<String, List<String>> fillInQ = {
        'ab': ['c'],
        'd e f': ['g'],
        'h': []
      };

      List<Questionnaire> questionnaires = [
        Questionnaire()
          ..question = 'שאלת אפשרות יחידה'
          ..options = ['אופציה א', 'אופציה ב', 'אופציה ג', 'אופציה ד']
          ..ans = ['אופציה ג']
          ..type = QType.radio,
        Questionnaire()
          ..question = 'שאלת בחירה מרובה'
          ..options = ['אופציה א', 'אופציה ב', 'אופציה ג', 'אופציה ד']
          ..ans = ['אופציה ג', 'אופציה א']
          ..type = QType.checkbox,
        Questionnaire()
          ..question = 'שאלת בחירה חופשית'
          ..ans = ['אופציה ג', 'אופציה א']
          ..type = QType.freeChoice,
        Questionnaire()
          ..question = 'שאלה מלא את החסר'
          ..fillInQuestion = json.encode(fillInQ)
          ..type = QType.fillIn
      ];

      List<Lesson> lessons = [
        Lesson()
          ..name = 'מבוא ואותיות ניקוד'..vimoeId=467058608
          ..questionnaire.add(questionnaires.first),
        Lesson()..name = 'אותיות עיצור א'..vimoeId=458427089,
        Lesson()..name = 'אותיות עיצור ב'..vimoeId=458427439,
        Lesson()..name = 'אותיות עיצור ג'..vimoeId=458427853,
        Lesson()..name = 'אותיות עיצור ד'..vimoeId=458428550,
        Lesson()..name = 'אותיות עיצור ה'..vimoeId=458429636,
        Lesson()..name = 'אותיות עיצור ו'..vimoeId=458429870,
        Lesson()..name = 'אותיות עיצור ז'..vimoeId=458431017,
        Lesson()..name = 'אותיות עיצור ח'..vimoeId=458484739,
        Lesson()..name = 'אותיות עיצור ט'..vimoeId=458486785,
        Lesson()..name = 'אותיות עיצור י'..vimoeId=458487712,
        Lesson()..name = 'אותיות עיצור כ'..vimoeId=458488614,
        Lesson()..name = 'אותיות עיצור ל'..vimoeId=458493015,
        Lesson()..name = 'אותיות עיצור מ'..vimoeId=458587389,
      ];

      final List<Subject> subjects = [
        Subject()
          ..name = 'חוקי קריאה והגיה'
          ..lessons.addAll(lessons)
          ..questionnaire.addAll(questionnaires),
        Subject()..name = 'מבנה המשפט התיאורי'..lessons.addAll([Lesson()..name = '5555'..
    vimoeId=458427089..questionnaire.addAll(questionnaires),Lesson()..name = '66666']),

        //..lessons.add(lessons[0])
      ];



      myCourses.add((Course()
        ..title = 'אנגלית בסיסית א'
        ..subjects.addAll(subjects)
        ..serverId = /*14518542*/ 2567060
        ..status = Status.middle
        ..questionnaire.addAll(questionnaires)));
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        // ..serverId = 2782842
        ..serverId = 1
        ..status = Status.finish);

      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 2
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 3
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 4
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 5
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 6
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 7
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 8
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 9
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 10
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 11
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 12
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 13
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 14
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 15
        ..status = Status.finish);
      myCourses.add(Course()
        ..title = 'אנגלית בסיסית ב'
        ..serverId = 16
        ..status = Status.finish);

      Course algebraCourse = Course()
        ..title = 'אלגברה בסיסית א’'
        ..serverId = 17
        ..status = Status.synchronized;
      Course phCourse = Course()..title = 'פיזיקה רעיונית א’'..serverId = 18;
      List<Knowledge> knowledgeList = [
        Knowledge()
          ..title = 'אנגלית'
          ..color = 0xff32D489
          ..iconPath = 'english'
          ..isOpen = false
          ..courses.addAll(myCourses)
          ..id = 1,
        Knowledge()
          ..title = 'מתמטיקה'
          ..color = 0xff5956DA
          ..iconPath = 'math'
          ..isOpen = false
          ..courses.add(algebraCourse)
          ..id = 2,
        Knowledge()
          ..title = 'פיזיקה'
          ..color = 0xffFF317B
          ..iconPath = 'math'
          ..isOpen = false
          ..courses.add(phCourse)
          ..id = 3
      ];
      List<Course> meymadList = [
        algebraCourse,
        Course()
          ..title = 'אלגברה בסיסית ב’'
          ..serverId = 19
          ..status = Status.synchronized,
        Course()
          ..title = 'קורס גאומטריה בסיסית'
          ..serverId = 20
          ..status = Status.synchronized
      ];

      List<LearnPath> paths = [
        LearnPath()
          ..id = 1
          ..title = 'מסלול אמירם'
          ..courses.addAll(myCourses)
          ..color = 0xff32D489
          ..iconPath = 'english',
        LearnPath()
          ..id = 2
          ..title = 'מסלול מימד'
          ..courses.addAll(meymadList)
          ..color = 0xff5956DA
          ..iconPath = 'math',
      ];

      // User user= User()..courses.addAll(myCourses);
      final List<User> users = [
        User()
          ..name = 'שמואל'
          ..knowledgeIds = [1, 2, 3]
          ..pathIds = [1, 2]
          ..tz = '123456789'..courses=[
          //  UserCourse()..courseId=2567060..subjectStopId=1..lessonStopId=1
        ]
      ];
      // final List<User> users=[User()..courses.addAll([UserCourse()..courseId=myCourses[0].id..status=Status.middle
      //   ..lessonStopId=myCourses[0].subjects.elementAt(0).lessons.elementAt(0).id,
      //   UserCourse()..courseId=myCourses[1].id..status=Status.start,
      //   UserCourse()..courseId=myCourses[0].id..status=Status.start]
      // )];
      print('filling!!');
      await IsarService().initCourses(myCourses, subjects, lessons,
          questionnaires, knowledgeList, users, paths);
      // course = await IsarService.instance.getFirstCourse();
    } else
      print('data is filled');
  }

  await initData();
  // Course? c1, c2;
  // if (myCourses.isNotEmpty) {
  //   c1 = myCourses.firstWhere((item) => item.serverId == 2782842);
  //   c2 = myCourses.firstWhere((item) => item.serverId == 2567060);
  // }
  runApp(MyApp(
      courses: myCourses /*c1 == null || c2 == null ? myCourses : [c1, c2]*/
      , dataWasFilled: dataWasFilled));

  doWhenWindowReady(() {
    setWindowVisibility(visible: true);
    setWindowTitle('My Demo');
    // const initialSize = Size(1280, 720);
    // appWindow.minSize = initialSize;
    // appWindow.size = initialSize;
    // appWindow.alignment = Alignment.center;
    //
    // appWindow.show();
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
  late Future myFuture;
  bool firstTime=true;
  final Connectivity _connectivity = Connectivity();
 late bool isNetWorkConnection;


  @override
  void initState() {
    myFuture = isVideosDownload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1920, 1080),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                  fontFamily: 'RAG-Sans'
              ),
              home: FutureBuilder(
                  future: myFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      vi = snapshot.data ?? [];
                      if (allDownloaded) return LoginPage();
                      return (widget.dataWasFilled &&
                                  (widget.courses.isNotEmpty)) ||
                              !widget.dataWasFilled
                          ? ChangeNotifierProvider<VimoeService>(
                              create: (_) => VimoeService(),
                              builder: (context, child) {
                                {

                                    if(firstTime) {
                                      context.read<VimoeService>().isNetWorkConnection=isNetWorkConnection;
                                      if (widget.courses.isNotEmpty || vi.isEmpty) {
                                        context
                                            .read<VimoeService>()
                                            .courses = widget.courses;
                                        context.read<VimoeService>().start();
                                      } else {
                                        context
                                            .read<VimoeService>()
                                            .isarVideoList =
                                            vi;
                                        context
                                            .read<VimoeService>()
                                            .startDownLoading();
                                        context
                                            .read<VimoeService>().finishConnectToVimoe=true;
                                      }
                                      firstTime=false;
                                    }

                                    return Consumer<VimoeService>(
                                        builder: (context, vimoeResult, child) {
                                          switch (vimoeResult.downloadStatus) {
                                            case DownloadStatus.downloading:
                                              return displayLoadingDialog(
                                                  false, context, false, false);
                                            case DownloadStatus.blockError:
                                              return displayLoadingDialog(
                                                  true, context, true, false);
                                            case DownloadStatus.error:
                                              return displayLoadingDialog(
                                                  true, context, false, false);
                                            case DownloadStatus.downloaded:
                                              context.read<VimoeService>().dispose();
                                              return LoginPage();
                                            case DownloadStatus.netWorkError:
                                              return displayLoadingDialog(
                                                  false, context, false, true);
                                          }
                                        });

                                }
                              })
                          : LoginPage();
                    }
                    return const Center(
                      child: Scaffold(body: Center(child: CircularProgressIndicator())),
                    );
                  }));
        });
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
                                  context
                                      .read<VimoeService>().startDownLoading(notify: true);
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
    isNetWorkConnection=await checkConnectivity();
    allDownloaded = await IsarService().checkIfAllVideosAreDownloaded();
    if (!allDownloaded) {
      return IsarService().getAllVideosDownloaded();
    }

    return [];
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
