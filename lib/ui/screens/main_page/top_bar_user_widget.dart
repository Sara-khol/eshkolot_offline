import 'package:eshkolot_offline/services/download_data_service.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/ui/screens/course_main/main_page_child.dart';
import 'package:eshkolot_offline/ui/screens/home_page.dart';
import 'package:eshkolot_offline/ui/screens/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/installationDataHelper.dart';
import '../../../services/network_check.dart';
import '../dialogs/sync_dialogs.dart';
import 'main_page.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;


class TopBarUserWidget extends StatefulWidget {
  // final void Function() updateLastPosition;

  const TopBarUserWidget({super.key /*,required this.updateLastPosition*/
      });

  @override
  State<TopBarUserWidget> createState() => _TopBarUserWidgetState();
}

class _TopBarUserWidgetState extends State<TopBarUserWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  Future? _dialog;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });

    //controller.isCompleted
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffDCDDE1))),
      ),
      padding: EdgeInsets.only(left: 132.w),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container(
              //   width: 40.w,
              //   height: 40.w,
              //   decoration: const BoxDecoration(
              //       shape: BoxShape.circle, color: Color(0xffF4F4F3)),
              //   child: const Icon(Icons.search),
              // ),
              SizedBox(width: 12.w),
              InkWell(
                onTap: () async {
                  //              var tempDir = await getTemporaryDirectory();
                  //              String fullPath = tempDir.path + "/boo2.mp4";
                  //              print('full path ${fullPath}');
                  //              String url='https://player.vimeo.com/progressive_redirect/download/458693918/container/fcea5fae-cd24-4ca5-9175-5b11c1236ffe/7a1d4543/%D7%94%D7%A4%D7%95%D7%A2%D7%9C_be_-_%D7%9E%D7%A9%D7%A4%D7%98_%D7%A9%D7%9C%D7%99%D7%9C%D7%99%20%28540p%29.mp4?expires=1694083455&loc=external&oauth2_token_id=1697788611&signature=593da3a60b3d72a3aa6412f4a5eb385b79e177480124ba4b2e5fbf0aab8f3e8a';
                  // Dio().download(url,fullPath);
                  if (await NetworkConnectivity.instance.checkConnectivity()) {
                    syncFunc();
                    if (context.mounted) {
                      //  SyncDialogs().showSyncDialog(context,controller);
                      _dialog = showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const SyncDialogs();
                          });
                    }
                  }
                  else {
                    if (context.mounted) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const SyncDialogs(
                              isOffline: true,
                            );
                          });
                      // }
                    }
                  }
                },
                child: Container(
                  height: 40.h,
                  width: 154.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 20.sp,
                      ),
                      Text(
                        '  סינכרון נתונים  ',
                        style: TextStyle(
                            color: colors.blackColorApp,
                            fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                child: Container(
                  height: 40.h,
                  width: 175.w,
                  decoration:  BoxDecoration(
                      color: colors.blackColorApp,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                      Text(
                        ' החלפת משתמש  ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  syncFunc() async {
    Function(bool b) updateFunc;

    updateFunc = (getVideos) {
      // if (_dialog != null && !getVideos) {
      //   debugPrint('111 $_dialog');
      //   InstallationDataHelper().eventBusDialogs.fire('');
      // }
      if (MainPage.of(context)?.getMainWidget is HomePage) {
        InstallationDataHelper().eventBusHomePage.fire('event fire');
        debugPrint('eventBusHomePage');
      } else if (MainPage.of(context)?.getMainWidget is MainPageChild) {
        InstallationDataHelper().eventBusMainPageChild.fire('event fire');
      }
      InstallationDataHelper().eventBusSideMenu.fire('');
    };
    User user = IsarService().getCurrentUser();

    List<int> courseCompleted = user.courses
        .where((course) => course.status == Status.finish)
        .map((course) => course.courseId)
        .toList();

    final List<Map<String, dynamic>> jsonList =
    user.percentages.map((grade) => grade.toJson()).toList();

    Map<String, dynamic> map = {
      'id_user': user.id,
      'lessonCompleted': user.lessonCompleted,
      'questionCompleted': user.questionCompleted,
      'subjectCompleted': user.subjectCompleted,
      'coursesCompleted': courseCompleted,
      'percentages': jsonList
    };
   DownloadService().blockLinks=[];
    ApiService().syncData(onSuccess: updateFunc, onError: () {}, jsonMap: map);
  }
}
