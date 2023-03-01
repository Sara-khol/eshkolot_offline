import 'package:eshkolot_offline/services/vimoe_service.dart';
import 'package:eshkolot_offline/ui/screens/course_main/main_page_child.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/course.dart';
import '../../../services/isar_service.dart';
import '../course_main/subject_main_page.dart';
import '../course_main/course_main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VimoeService>(
        create: (_) => VimoeService(),
        lazy: false,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: FutureBuilder<Course?>(
              future: getFirstEnglishCourse(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Course? course = snapshot.data;

                  course!.isDownloaded=true;
                  if (!course!.isDownloaded) {
                    context.read<VimoeService>().connectToVimoe();
                    return Consumer<VimoeService>(
                        builder: (context, vimoeResult, child) {
                      switch (vimoeResult.downloadStatus) {
                        case DownloadStatus.downloading:
                          return displayLoadingDialog(false, context, false);
                        case DownloadStatus.blockError:
                          return displayLoadingDialog(true, context, true);
                        case DownloadStatus.error:
                          return displayLoadingDialog(false, context, false);
                        case DownloadStatus.downloaded:
                          updateDownload(course.id);
                          return SubjectMainPage(course: course);
                          // return  HomeMainWidget();
                      }
                    });
                  } else {
                    return MainPageChild(course: course);
                    // return HomeMainWidget();
                  }
                }
                print('wait...');
                return Center(child: const CircularProgressIndicator());
              }),
        ),
      ),
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
                        context.read<VimoeService>().connectToVimoe(notify: true);
                      },
                      child: Text('נסה שנית'))
                ])
          : SimpleDialog(
              title: Center(child: Text('הנתונים נטענים')),
              children: <Widget>[
                  Center(child: CircularProgressIndicator()),
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

  Future<void> updateDownload(int id) async {
    await IsarService.instance.updateDownloadCourse(id);
  }
}
