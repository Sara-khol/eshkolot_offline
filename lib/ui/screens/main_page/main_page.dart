
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/services/vimoe_service.dart';
import 'package:eshkolot_offline/ui/screens/main_page/side_menu_widget.dart';
import 'package:eshkolot_offline/ui/screens/main_page/title_bar_widget.dart';
import 'package:eshkolot_offline/ui/screens/main_page/top_bar_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/course.dart';
import '../../../models/knowledge.dart';
import '../../../services/isar_service.dart';
import '../home_page.dart';

typedef void changeMainWidget(Widget mainWidget);

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.user});

  final User user;

  @override
  State<MainPage> createState() => _MainPageState();

  static _MainPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainPageState>();
}

class _MainPageState extends State<MainPage> {
  late List<Knowledge> knowledgeList = [];
  late List<LearnPath> pathList = [];

  //late Future<User?> userFunc;
  late Widget _mainWidget;
  late List<Widget> menuWidgets;
  int sIndex = 0;
  Course? lastCourseSelected;
  int coursesIndex = 0;
  IsarLinks<Course>? courses;


  // late User myUser;

  set mainWidget(Widget value) => setState(() => _mainWidget = value);

  @override
  void initState() {
    //  userFunc = getUser();

    knowledgeList = widget.user.knowledgeList;
    pathList = widget.user.pathList;
    _mainWidget = HomePage(user: widget.user);

    //todo fix... need to get all courses
    courses = widget.user.knowledgeList[0].courses;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int numDownloadedCourses = 0;

    return ChangeNotifierProvider<VimoeService>(
      create: (_) => VimoeService(),
      builder:(context, child) {
        if(courses!=null) {
          context
              .read<VimoeService>()
              .numCourses = courses!.length;
          for (Course course in courses!) {
            //todo remove!!!
            // course.isDownloaded = true;
            // if (course.serverId == 2567060)
            //   course.isDownloaded = true;

            context
                .read<VimoeService>()
                .projectId =
                course.serverId;

            // if (!course.isDownloaded) {
            //   context.read<VimoeService>().connectToVimoe();
            // } else {

            coursesIndex++;
            if (coursesIndex == courses!.length) {
              context
                  .read<VimoeService>()
                  .downloadStatus = DownloadStatus.allDownloaded;
            }
            // return displayWidget();
           //  }
          }
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                body: /*FutureBuilder<User?>(
              future: userFunc,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  User? user = snapshot.data;
                  if (user != null) {*/

                Consumer<VimoeService>(
                    builder: (context, vimoeResult, child) {
                      switch (vimoeResult.downloadStatus) {
                        case DownloadStatus.downloading:
                          return displayLoadingDialog(false, context, false);
                        case DownloadStatus.blockError:
                          return displayLoadingDialog(true, context, true);
                        case DownloadStatus.error:
                          return displayLoadingDialog(false, context, false);
                        case DownloadStatus.downloaded:
                          coursesIndex++;
                          return displayLoadingDialog(false, context, false);
                        case DownloadStatus.allDownloaded:
                          return displayWidget();

                      // return CourseMainPage(course: course);
                      }
                    })


              // print('error...');
              // return Center(child: const CircularProgressIndicator());
              //   }
              //   print('wait...');
              //   return Center(child: const CircularProgressIndicator());
              // }),
            ),
          );
        }
        return Text('error');
      } ,
      // lazy: false,
     /* child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: *//*FutureBuilder<User?>(
              future: userFunc,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  User? user = snapshot.data;
                  if (user != null) {*//*

                       Consumer<VimoeService>(
                          builder: (context, vimoeResult, child) {
                        switch (vimoeResult.downloadStatus) {
                          case DownloadStatus.downloading:
                            return displayLoadingDialog(false, context, false);
                          case DownloadStatus.blockError:
                            return displayLoadingDialog(true, context, true);
                          case DownloadStatus.error:
                            return displayLoadingDialog(false, context, false);
                          case DownloadStatus.downloaded:
                            coursesIndex++;
                            return displayLoadingDialog(false, context, false);
                          case DownloadStatus.allDownloaded:
                            return displayWidget();

                          // return CourseMainPage(course: course);
                        }
                      })


                  // print('error...');
                  // return Center(child: const CircularProgressIndicator());
              //   }
              //   print('wait...');
              //   return Center(child: const CircularProgressIndicator());
              // }),
        ),
      ),*/
    );
  }

  Widget displayLoadingDialog(
      bool isError, BuildContext context, bool blockError) {
    return Container(
      color: Colors.black12,
      child: isError
          ? SimpleDialog(
              contentPadding: EdgeInsets.all(30),
              title: Center(child: Text('!ישנה בעיה')),
              children: <Widget>[
                  if (blockError)
                    Text('נראה שהלינקים הלללו חסומים ברשת האינטרנט שלך'),
                  if (blockError)
                    Text('נא פנה לספק האינטרנט שלך על מנת להסדיר את הענין'),
                  SizedBox(
                    height: 15,
                  ),
                  if (blockError)
                    Column(children: displayBlockedLinks(context)),
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<VimoeService>()
                            .connectToVimoe(notify: true);
                      },
                      child: Text('נסה שנית'))
                ])
          : SimpleDialog(
              title: Center(child: Text('הנתונים נטענים')),
              children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  Text(context
                      .read<VimoeService>()
                      .numCoursesDownloaded
                      .toString())
                ]),
    );
  }

  displayBlockedLinks(BuildContext context) {
    List<Widget> myLinks = [];
    for (String link in context.read<VimoeService>().blockLinks) {
      // myLinks.add(SelectableText(link,style: TextStyle(decoration: TextDecoration.underline),));
      myLinks.add(Padding(
        padding: EdgeInsets.only(bottom: 7),
        child: InkWell(
          child: Text(link,
              style: TextStyle(decoration: TextDecoration.underline)),
          onTap: () => _launchUrl(link),
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

  Future<Course?> getFirstEnglishCourse() async {
    return await IsarService.instance.getFirstCourse();
  }

  Future<User?> getUser() async {
    User? user = await IsarService.instance.getUser();
    knowledgeList = user?.knowledgeList ?? [];
    pathList = user?.pathList ?? [];
    if (user != null) {
      _mainWidget = HomePage(user: user);
    }
    return user;
  }

  Future<void> updateDownload(int id) async {
    await IsarService.instance.updateDownloadCourse(id);
  }

  Widget displayWidget() {
    return Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TitleBarWidget(),
          Expanded(
              child: Row(children: [
                SideMenuWidget(myUser: widget.user),
                Expanded(
                    child: Column(children: [
                      TopBarUserWidget(),
                      Expanded(child: _mainWidget)
            ]))
          ]))
        ]);
  }
}
