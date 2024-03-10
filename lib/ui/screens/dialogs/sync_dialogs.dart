import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eshkolot_offline/models/linkQuizIsar.dart';
import 'package:eshkolot_offline/services/api_service.dart';
import 'package:eshkolot_offline/services/download_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/course.dart';
import '../../../models/videoIsar.dart';
import '../../../services/installationDataHelper.dart';
import '../../../services/isar_service.dart';
import '../../../services/network_check.dart';
import '../../../services/vimoe_service.dart';
import '../home_page.dart';
import '../main_page/main_page.dart';

class SyncDialogs extends StatefulWidget {
  final bool isOffline;

  const SyncDialogs({super.key, this.isOffline = false});

  @override
  State<SyncDialogs> createState() => _SyncDialogsState();
}

class _SyncDialogsState extends State<SyncDialogs>
    with TickerProviderStateMixin {
  late Widget mainWidget;
  Widget? lastMainWidget;
  late AnimationController controller;
  late bool allDownloadedVideos;
  late bool allDownloadedLinks;
  late List<VideoIsar> vi;
  late List<LinkQuizIsar> linkList;
  bool firstTimeVimeo = true;
  List<Course> c = [];

  //todo
  late bool isNetWorkConnection = true;

  late StreamSubscription subscription;
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  Map _source = {ConnectivityResult.none: false};
  bool onlyOnce = true;
  late StreamSubscription eventSubscription;

  @override
  void initState() {
    _networkConnectivity.whileDownloading = true;

    listenToNetWork();

    eventSubscription =
        InstallationDataHelper().eventBusDialogs.on().listen((event) async {
      debugPrint('eventBusDialogs listen event $event');
      if (event == '') {
        vi = await isVideosDownload(false);
        linkList = await isLinksDownload(false);
        if (allDownloadedVideos && allDownloadedLinks) {
          updateEndDialog();
        } else if (!allDownloadedLinks) {
          downloadLinksStart();
        } else {
          vimeoStart();
        }
      } else {
        if (event is List<Course>) {
          debugPrint('downloade vimeo');
          vi = await isVideosDownload(true);
          linkList = await isLinksDownload(false);
          c = event as List<Course>;
          for (Course course in c) {
            debugPrint('Course ID: ${course.id}');
          }
          if (allDownloadedVideos && allDownloadedLinks) {
            debugPrint('111');
            updateEndDialog();
          } else {
            debugPrint('222');

            if (!allDownloadedVideos) {
              debugPrint('333');
              vimeoStart(newCourse: true);
            } else {
              downloadLinksStart(newCourse: true);
            }
          }
        }
        else
          {
            debugPrint('4444');
            if(!allDownloadedVideos) {
              vimeoStart();
            } else {
              mainWidget= showErrorDialog(context,isVimeo: false);
              setState(() {});
            }

          }
        //   SyncDialogs().showVimeoDialog(context, c, controller);
      }
    });

    // InstallationDataHelper().eventBusVimeo.on().listen((event) async {
    //   debugPrint('kkk');
    //   // Navigator.pop(context);
    //   List <Course> c = [];
    //   c.add(event as Course);
    //   await isVideosDownload();
    //   SyncDialogs().showVimeoDialog(context, c, controller);
    // });

    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
   mainWidget = widget.isOffline ? showOfflineSyncWidget() : showSyncWidget();
    super.initState();
  }

  listenToNetWork() {
    _networkConnectivity.reOpen();
    subscription = _networkConnectivity.myStream.listen((source) async {
      _source = source;
      debugPrint('source11 $_source');
      if (_source.keys.toList()[0] == ConnectivityResult.none) {
        onlyOnce = true;
        isNetWorkConnection = false;
        lastMainWidget = mainWidget;
        mainWidget = showOfflineSyncWidget();
        ApiService().cancelRequests();

        if (mounted) {
          setState(() {});
        }
      } else if (onlyOnce) {
        isNetWorkConnection = true;
        onlyOnce = false;
        Navigator.of(context).pop();
      }
    });
  }

// todo 1
  Future<List<VideoIsar>> isVideosDownload(bool newCourse) async {
    debugPrint('===isVideosDownload===');
    // isNetWorkConnection = await checkConnectivity();
    isNetWorkConnection = await _networkConnectivity.checkConnectivity();

    allDownloadedVideos =
        await IsarService().checkIfAllVideosAreDownloaded(newCourse);
    if (!allDownloadedVideos) {
      return IsarService()
          .getAllVideosToDownload(IsarService().getUserUserCoursesId());
    }

    return [];
  }

  Future<List<LinkQuizIsar>> isLinksDownload(bool newCourse) async {
    debugPrint('isLinksDownload');
    // isNetWorkConnection = await checkConnectivity();
    isNetWorkConnection = await _networkConnectivity.checkConnectivity();

    allDownloadedLinks =
        await IsarService().checkIfAllLinksAreDownloaded(newCourse);
    if (!allDownloadedLinks) {
      return IsarService()
          .getAllLinksToDownload(IsarService().getUserUserCoursesId());
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        elevation: 0,
        backgroundColor: Colors.white,
        content: Wrap(
          children: [
            Container(
                // height: 640.h,
                width: 656.w,
                // padding: EdgeInsets.only(top: 51.h),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: mainWidget),
          ],
        ),
      ),
    );
  }

  vimeoStart({bool newCourse = false, oldLinks = false}) async {
    // _networkConnectivity.disposeStream();
    //mmm
    subscription.cancel();

    late List<int> ids;
    bool didDateExpired = checkDateExpired();
    // bool didDateExpired = true;
    if (didDateExpired) {
      ids = await IsarService().getAllCourseIds();
      for (int cId in ids) {
        Course? course = await IsarService().getCourseById(cId);
        if (course != null) {
          c.add(course);
          debugPrint('cId $cId added');
        }
      }
    }

    mainWidget = ChangeNotifierProvider<VimoeService>(
        create: (_) => VimoeService(),
        builder: (context, child) {
          {
            if (firstTimeVimeo) {
              context.read<VimoeService>().isNetWorkConnection =
                  isNetWorkConnection;

              if (/*vi.isEmpty*/ newCourse || didDateExpired) {
                debugPrint('hhh');
                if (didDateExpired) {
                  context.read<VimoeService>().courses = c;
                  context.read<VimoeService>().start();
                } else {
                  context.read<VimoeService>().finishConnectToVimoe = false;
                  context.read<VimoeService>().courses = c;

                  if (vi.isNotEmpty) {
                    context.read<VimoeService>().isarVideoList = vi;
                  }
                  context.read<VimoeService>().start(oldLinks: vi.isNotEmpty);
                }
              } else {
                debugPrint('111');
                context.read<VimoeService>().isarVideoList = vi;
                context.read<VimoeService>().startDownLoading();
                context.read<VimoeService>().finishConnectToVimoe = true;
              }
              firstTimeVimeo = false;
            }

            return Consumer<VimoeService>(
                builder: (context, vimoeResult, child) {
              // debugPrint('downloadStatus ${vimoeResult.downloadStatus}');
              if (vimoeResult.downloadStatus == DownloadStatus.downloaded) {
                context.read<VimoeService>().dispose();
                if (linkList.isEmpty) {
                  debugPrint('111');
                  // vimeoWidget= showEndSyncWidget();
                  return showEndSyncWidget();
                } else {
                  if (newCourse)
                    return showErrorDialog(context,isBlockedLinks: false);
                  else
                    downloadLinksStart(newCourse: newCourse);
                  return showSyncWidget();
                }
                // setState(() {});
              } else if (vimoeResult.downloadStatus ==
                  DownloadStatus.netWorkError) {
                return showOfflineSyncWidget();
              } else if (vimoeResult.downloadStatus ==
                  DownloadStatus.blockError) {
                return showErrorDialog(context);
              } else if (vimoeResult.downloadStatus == DownloadStatus.error) {
                return showErrorDialog(context, isBlockedLinks: false);
              }
              return showSyncWidget();
            });
          }
        });
    if (mounted) setState(() {});
  }

  downloadLinksStart({bool newCourse = false, oldLinks = false}) async {
    await DownloadService().startDownLoadingBlockedLinks(linkList);
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

  showSyncWidget() {
    // _networkConnectivity.reOpen();
    // if(!isVimeo) {
    //
    //   listenToNetWork();
    // }

    return Column(
      children: [
        // Align(
        //   alignment: Alignment.topRight,
        //   child: TextButton(
        //     child: Image.asset('assets/images/X.jpg', height: 18.h),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        Padding(
          // padding: EdgeInsets.only(top: 51.h, right: 70.w, left: 70.w),
          padding: EdgeInsets.only(top: 80.h, right: 70.w, left: 70.w,bottom: 80.h),
          child: Column(
            children: [
              Image.asset('assets/images/sync.jpg', height: 153.h),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'אנחנו מסנכרנים את התקדמות הלמידה שלכם',
                style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w600),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 45.h,
              ),
              Text(
                  'כדי שהאתר באונליין יהיה מעודכן בהתקדמות הלמידה שלכם\n וכדי שתוכלו לקבל תעודה והחזר על דמי הפיקדון\n חשוב לנו לסנכרן את נתוני הלמידה.',
                  style: TextStyle(fontSize: 18.sp),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center),
              SizedBox(
                height: 36.h,
              ),
              Text(
                'יש להשאיר את הלשונית פתוחה',
                style: TextStyle(fontSize: 18.sp),
              ),
              Text(
                'אימייל עדכון ישלח בסיום תהליך הסנכרון',
                style: TextStyle(fontSize: 18.sp),
              ),
              // SizedBox(
              //   height: 30.h,
              // ),
              //todo remove percent for now
              // LinearProgressIndicator(
              //   color: Color(0xFFFFDA6C),
              //   backgroundColor: Color(0xFFE4E6E9),
              //   minHeight: 9.h,
              //   value: controller.value + 0.3,
              // ),
              // SizedBox(
              //   height: 12.sp,
              // ),
              // Text(
              //   "סונכרנו %${controller.value.toInt()}   |  זמן משוער שנותר 7 דק'",
              //   textDirection: TextDirection.rtl,
              //   style: TextStyle(
              //     fontSize: 9.sp,
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }

  showEndSyncWidget() {
    return Column(
      children: [
        SizedBox(height: 19.h),
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            child: Image.asset('assets/images/X.jpg', height: 22.h),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              /*top: 44.h,*/
              right: 70.w,
              left: 70.w),
          child: Column(
            children: [
              Image.asset('assets/images/sync_done.jpg', height: 153.h),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'מצוין! המערכת סיימה לסנכרן את נתוני הלמידה',
                style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w600),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 35.h,
              ),
              Text(
                  'במידה והשלמתם קורס התעודה מחכה לכם באזור האישי\n'
                  ' ותוכלו לקבל בחזרה את דמי הפיקדון או להשתמש\n בהם כדי להוריד קורס נוסף',
                  style: TextStyle(fontSize: 18.sp),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center),
              SizedBox(
                height: 25.h,
              ),
              Text(
                'כל הכבוד על ההתמדה והלמידה!',
                style: TextStyle(fontSize: 18.sp),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: 63.h,
              ),
              Container(
                height: 40.h,
                width: 171.w,
                decoration: const BoxDecoration(
                    color: Color(0xFF2D2828),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 15.sp,
                      ),
                      Text(
                        ' להמשך למידה ',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    MainPage.of(context)?.mainWidget =
                        HomePage(user: IsarService().getCurrentUser());
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ],
    );
  }

  showOfflineSyncWidget() {
    return Column(
      children: [
        SizedBox(
          height: 19.h,
        ),
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            child: Image.asset('assets/images/X.jpg', height: 22.h),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              /*top: 45.h,*/
              right: 70.w,
              left: 70.w),
          child: Column(
            children: [
              Image.asset('assets/images/offline.jpg', height: 153.h),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'המערכת במצב לא מקוון',
                style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w600),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 45.h,
              ),
              Text('כדי לסנכרן את נתוני הלמידה באתר\n יש לעבוד במצב מקוון.',
                  style: TextStyle(fontSize: 18.sp),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center),
              SizedBox(
                height: 35.h,
              ),
              Text(
                'ניתן גם לסנכרן נתונים ממחשב אחר שמחובר לרשת\n באמצעות הדיסק און קי אליו הורדת את התוכנה\n (אם הדיסק און קי מחובר למחשב עליו מותקנת התוכנה).',
                style: TextStyle(fontSize: 18.sp),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: 27.h,
              ),
              Container(
                height: 40.h,
                width: 171.w,
                decoration: const BoxDecoration(
                    color: Color(0xFF2D2828),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: TextButton(
                  child: Text(
                    ' הבנתי, תודה! ',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 50.h),
      ],
    );
  }

  showErrorDialog(BuildContext context, {bool isBlockedLinks = true,bool isVimeo=true}) {
    return Center(
      child: ListView(
        shrinkWrap: true,
          // mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 51.h,
            ),
            const Center(child: Text('!ישנה בעיה')),
            if (isBlockedLinks)
              const Center(
                  child: Text('נראה שהלינקים הלללו חסומים ברשת האינטרנט שלך')),
            if (isBlockedLinks)
              const Center(
                  child:
                      Text('נא פנה לספק האינטרנט שלך על מנת להסדיר את הענין')),
            if (isBlockedLinks)
              const SizedBox(
                height: 15,
              ),
            if (isBlockedLinks && isVimeo) const Text('סרטוני וידאו'),
            if (isBlockedLinks && isVimeo)
              Expanded(
                flex: 3,
                child: ListView(
                    shrinkWrap: true,
                    children: displayBlockedLinks(
                        context, context.read<VimoeService>().blockLinks)
                    //),
                    ),
              ),
            if (DownloadService().blockLinks.isNotEmpty)
              const Text('חומרים בשאלונים'),
            if (DownloadService().blockLinks.isNotEmpty)
              Expanded(
                flex: 1,
                child: ListView(
                    shrinkWrap: true,
                    children: displayBlockedLinks(
                        context, DownloadService().blockLinks)
                    //),
                    ),
              ),
            if (isBlockedLinks)
              const SizedBox(
                height: 15,
              ),
            ElevatedButton(
                onPressed: () {
                  if(isVimeo) {
                    //if started from going to vimeo will try again
                    if (vi.isEmpty || checkDateExpired()) {
                      context
                          .read<VimoeService>()
                          .finishConnectToVimoe = false;
                      context
                          .read<VimoeService>()
                          .courses = c;
                      context.read<VimoeService>().start(notify: true);
                    } else {
                      //if did start from videos that were saved and did not go to vimeo will get to here
                      context
                          .read<VimoeService>()
                          .isarVideoList = vi;
                      context.read<VimoeService>().startDownLoading(notify: true);
                      context
                          .read<VimoeService>()
                          .finishConnectToVimoe = true;
                    }
                  }
                  if (DownloadService().blockLinks.isNotEmpty) {
                    if(!isVimeo)
                      {
                        mainWidget=showSyncWidget();
                        setState(() {});
                      }
                    DownloadService().startDownLoadingBlockedLinks(linkList);
                  }
                },
                child: const Text('נסה שנית')),
            SizedBox(height: 20.h),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('סגור')),
            SizedBox(height: 30.h),
          ]),
    );
  }

  displayBlockedLinks(BuildContext context, List<String> links) {
    List<Widget> myLinks = [];
    for (String link in links) {
      // myLinks.add(SelectableText(link,style: TextStyle(decoration: TextDecoration.underline),));
      myLinks.add(Padding(
        padding: EdgeInsets.only(bottom: 7, right: 10.w, left: 10.w),
        child: Center(
          child: InkWell(
            child: Text(link,
                textAlign: TextAlign.center,
                style: const TextStyle(decoration: TextDecoration.underline)),
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

  updateEndDialog() {
    if (mounted) {
      setState(() {
        debugPrint('222');
        mainWidget = showEndSyncWidget();
      });
    }
  }

  @override
  void dispose() {
    debugPrint('jjj dispose');

    subscription.cancel();
    //mmm
    _networkConnectivity.disposeStream();
    _networkConnectivity.whileDownloading = false;
    ApiService().cancelRequests();
    eventSubscription.cancel();
    super.dispose();
  }
}
