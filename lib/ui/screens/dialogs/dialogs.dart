// import 'package:eshkolot_offline/services/api_service.dart';
// import 'package:eshkolot_offline/services/isar_service.dart';
// import 'package:eshkolot_offline/ui/screens/home_page.dart';
// import 'package:eshkolot_offline/ui/screens/main_page/main_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../models/course.dart';
// import '../../../models/user.dart';
// import '../../../models/videoIsar.dart';
// import '../../../services/vimoe_service.dart';
// import '../login/login_page.dart';
// import '../main_page/title_bar_widget.dart';
//
// class SyncDialogs {
//   late Future myFuture;
//   late bool allDownloaded;
//
//   //todo
//   late bool isNetWorkConnection = true;
//   late List<VideoIsar> vi;
//   bool firstTime = true;
//
//   showMainDialog(BuildContext context, Widget childWidget) {
//     showDialog(
//         barrierDismissible: false,
//
//         context: context,
//         builder: (BuildContext context) {
//           return Center(
//             child: AlertDialog(
//               content:
//                   SizedBox(height: 640.h, width: 656.w, child: childWidget),
//             ),
//           );
//         });
//   }
//
//   displayBlockedLinks(BuildContext context) {
//     List<Widget> myLinks = [];
//     for (String link in context.read<VimoeService>().blockLinks) {
//       // myLinks.add(SelectableText(link,style: TextStyle(decoration: TextDecoration.underline),));
//       myLinks.add(Padding(
//         padding: EdgeInsets.only(bottom: 7),
//         child: Center(
//           child: InkWell(
//             child: Text(link,
//                 style: TextStyle(decoration: TextDecoration.underline)),
//             onTap: () => _launchUrl(link),
//           ),
//         ),
//       ));
//     }
//
//     return myLinks;
//   }
//
//   Future<void> _launchUrl(String link) async {
//     Uri uri = Uri.parse(link);
//     if (!await launchUrl(uri)) {
//       throw Exception('Could not launch $uri');
//     }
//   }
//
//   Future<List<VideoIsar>> isVideosDownload() async {
//     // isNetWorkConnection = await checkConnectivity();
//     // isNetWorkConnection = await _networkConnectivity.checkConnectivity();
//
//     allDownloaded = await IsarService().checkIfAllVideosAreDownloaded(true);
//     if (!allDownloaded) {
//       return IsarService().getAllVideosToDownload(IsarService().getUserUserCoursesId());
//     }
//
//     return [];
//   }
//
//   checkDateExpired() {
//     int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//     // Convert current datetime to seconds
//
//     for (VideoIsar videoIsar in vi) {
//       if (!videoIsar.isDownload && currentTimestamp > videoIsar.expiredDate) {
//         debugPrint('url was expired');
//         return true;
//       }
//     }
//
//     return false;
//   }
//
//   Widget displayLoadingDialog(bool isError, BuildContext context,
//       bool blockError, bool isNetWorkError) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         body: Column(
//           children: [
//             TitleBarWidget(),
//             Expanded(
//               child: Container(
//                 color: Colors.black12,
//                 child: isError && !isNetWorkError
//                     ? SimpleDialog(
//                         contentPadding: EdgeInsets.all(30),
//                         title: Center(child: Text('!ישנה בעיה')),
//                         children: <Widget>[
//                             if (blockError)
//                               Center(
//                                   child: Text(
//                                       'נראה שהלינקים הלללו חסומים ברשת האינטרנט שלך')),
//                             if (blockError)
//                               Center(
//                                   child: Text(
//                                       'נא פנה לספק האינטרנט שלך על מנת להסדיר את הענין')),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             if (blockError)
//                               SizedBox(
//                                 width: double.minPositive,
//                                 child: ListView(
//                                     shrinkWrap: true,
//                                     children: displayBlockedLinks(context)),
//                               ),
//                             ElevatedButton(
//                                 onPressed: () {
//                                   // context
//                                   //     .read<VimoeService>().startDownLoading(
//                                   //     notify: true);
//
//                                   context
//                                       .read<VimoeService>()
//                                       .start(notify: true);
//                                 },
//                                 child: Text('נסה שנית'))
//                           ])
//                     : !isNetWorkError
//                         ? const SimpleDialog(
//                             title: Center(child: Text('הנתונים נטענים')),
//                             children: <Widget>[
//                                 Center(child: CircularProgressIndicator()),
//                                 // Text(context
//                                 //     .read<VimoeService>()
//                                 //     .numCoursesDownloaded
//                                 //     .toString())
//                               ])
//                         : const SimpleDialog(
//                             title: Center(child: Text('אין חיבור לאינטרנט')),
//                             children: <Widget>[
//                                 Center(
//                                     child: Text(
//                                         'נא בדוק את החיבורים על מנת שנוכל להמשיך בהורדת הנתונים')),
//                               ]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void showSyncDialog(BuildContext context, AnimationController controller) {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: AlertDialog(
//             content: SizedBox(
//               height: 640.h,
//               width: 656.w,
//               child: Column(
//                 children: [
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: TextButton(
//                       child: Image.asset('assets/images/X.jpg', height: 18.h),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         /*top: 45.h,*/
//                         right: 70.w,
//                         left: 70.w),
//                     child: Column(
//                       children: [
//                         Image.asset('assets/images/sync.jpg', height: 153.h),
//                         SizedBox(
//                           height: 40.h,
//                         ),
//                         Text(
//                           'אנחנו מסנכרנים את התקדמות הלמידה שלכם',
//                           style: TextStyle(
//                               fontSize: 36.sp, fontWeight: FontWeight.w600),
//                           textDirection: TextDirection.rtl,
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(
//                           height: 45.h,
//                         ),
//                         Text(
//                             'כדי שהאתר באונליין יהיה מעודכן בהתקדמות הלמידה שלכם\n וכדי שתוכלו לקבל תעודה והחזר על דמי הפיקדון\n חשוב לנו לסנכרן את נתוני הלמידה.',
//                             style: TextStyle(fontSize: 18.sp),
//                             textDirection: TextDirection.rtl,
//                             textAlign: TextAlign.center),
//                         SizedBox(
//                           height: 36.h,
//                         ),
//                         Text(
//                           'יש להשאיר את הלשונית פתוחה',
//                           style: TextStyle(fontSize: 18.sp),
//                         ),
//                         Text(
//                           'אימייל עדכון ישלח בסיום תהליך הסנכרון',
//                           style: TextStyle(fontSize: 18.sp),
//                         ),
//                         SizedBox(
//                           height: 30.h,
//                         ),
//                         LinearProgressIndicator(
//                           color: Color(0xFFFFDA6C),
//                           backgroundColor: Color(0xFFE4E6E9),
//                           minHeight: 9.h,
//                           value: controller.value + 0.3,
//                         ),
//                         SizedBox(
//                           height: 12.sp,
//                         ),
//                         Text(
//                           "סונכרנו %${controller.value.toInt()}   |  זמן משוער שנותר 7 דק'",
//                           textDirection: TextDirection.rtl,
//                           style: TextStyle(
//                             fontSize: 9.sp,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void showVimeoDialog(BuildContext context, List<Course> courses,
//       AnimationController controller) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: AlertDialog(
//             content: SizedBox(
//                 height: 640.h,
//                 width: 656.w,
//                 child: FutureBuilder(
//                     //todo 1
//                     future: isVideosDownload(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         vi = snapshot.data ?? [];
//                         //todo 2
//                         if (allDownloaded) return LoginPage();
//                         //???
//                         return /*(widget.dataWasFilled &&
//                           widget.courses.isNotEmpty) ||
//                       !widget.dataWasFilled
//                   ?*/
//                           //VimoeService().listenToNetWork();
//                             ChangeNotifierProvider<VimoeService>(
//                                 create: (_) => VimoeService(),
//                                 builder: (context, child) {
//                                   {
//                                     if (firstTime) {
//                                       context
//                                               .read<VimoeService>()
//                                               .isNetWorkConnection =
//                                           isNetWorkConnection;
//                                       if (/*widget.courses.isNotEmpty ||*/
//                                           vi.isEmpty || checkDateExpired()) {
//                                         context.read<VimoeService>().courses =
//                                             courses;
//                                         context.read<VimoeService>().start();
//                                       } else {
//                                         context
//                                             .read<VimoeService>()
//                                             .isarVideoList = vi;
//                                         context
//                                             .read<VimoeService>()
//                                             .startDownLoading();
//                                         context
//                                             .read<VimoeService>()
//                                             .finishConnectToVimoe = true;
//                                       }
//                                       firstTime = false;
//                                     }
//
//                                     return Consumer<VimoeService>(
//                                         builder: (context, vimoeResult, child) {
//                                       debugPrint(
//                                           'downloadStatus ${vimoeResult.downloadStatus}');
//                                       //Navigator.pop(context);
//                                       switch (vimoeResult.downloadStatus) {
//                                         // case DownloadStatus.downloading:
//                                         //   Navigator.pop(context);
//                                         //   Future.delayed(Duration.zero,
//                                         //       () async {
//                                         //     showSyncDialog(context, controller);
//                                         //   });
//                                         //   // showSyncDialog(context,controller);
//                                         //   break;
//                                         case DownloadStatus.blockError:
//                                           // return displayLoadingDialog(
//                                           //     true, context, true, false);
//                                           Navigator.pop(context);
//                                           Future.delayed(Duration.zero,
//                                               () async {
//                                             showOfflineSyncDialog(context);
//                                           });
//                                           break;
//                                         case DownloadStatus.error:
//                                           // return displayLoadingDialog(
//                                           //     true, context, false, false);
//                                           Navigator.pop(context);
//                                           Future.delayed(Duration.zero,
//                                               () async {
//                                             showOfflineSyncDialog(context);
//                                           });
//                                           break;
//                                         case DownloadStatus.downloaded:
//                                           // Navigator.pop(context);
//                                           // Future.delayed(Duration.zero,
//                                           //     () async {
//                                           //   showSyncEndDialog(
//                                           //       context, () => null);
//                                           // });
//                                           context
//                                               .read<VimoeService>()
//                                               .dispose();
//                                           break;
//                                         case DownloadStatus.netWorkError:
//                                           Navigator.pop(context);
//
//                                           Future.delayed(Duration.zero,
//                                               () async {
//                                             showOfflineSyncDialog(context);
//                                           });
//                                           break;
//                                       }
//                                       return Container();
//                                     });
//                                   }
//                                 });
//                       }
//                       return const Center(
//                         child: Scaffold(
//                             backgroundColor: Colors.white,
//                             body: Center(child: CircularProgressIndicator())),
//                       );
//                     })),
//           ),
//         );
//       },
//     );
//   }
//
//   void showSyncEndDialog(BuildContext context, Function() onSuccess) {
//     //ApiService().getCourseData(id: /*105912*/24042, onSuccess: (){}, onError: (){});
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: AlertDialog(
//             content: Container(
//               height: 640.h,
//               width: 656.w,
//               child: Column(
//                 children: [
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: TextButton(
//                       child: Image.asset('assets/images/X.jpg', height: 18.h),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         /*top: 44.h,*/
//                         right: 70.w,
//                         left: 70.w),
//                     child: Column(
//                       children: [
//                         Image.asset('assets/images/sync_done.jpg',
//                             height: 153.h),
//                         SizedBox(
//                           height: 40.h,
//                         ),
//                         Text(
//                           'מצוין! המערכת סיימה לסנכרן את נתוני הלמידה',
//                           style: TextStyle(
//                               fontSize: 36.sp, fontWeight: FontWeight.w600),
//                           textDirection: TextDirection.rtl,
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(
//                           height: 45.h,
//                         ),
//                         Text(
//                             'במידה והשלמתם קורס התעודה מחכה לכם באזור האישי\n'
//                             ' ותוכלו לקבל בחזרה את דמי הפיקדון או להשתמש\n בהם כדי להוריד קורס נוסף',
//                             style: TextStyle(fontSize: 18.sp),
//                             textDirection: TextDirection.rtl,
//                             textAlign: TextAlign.center),
//                         SizedBox(
//                           height: 35.h,
//                         ),
//                         Text(
//                           'כל הכבוד על ההתמדה והלמידה!',
//                           style: TextStyle(fontSize: 18.sp),
//                           textDirection: TextDirection.rtl,
//                         ),
//                         SizedBox(
//                           height: 63.h,
//                         ),
//                         Container(
//                           height: 40.h,
//                           width: 171.w,
//                           decoration: BoxDecoration(
//                               color: Color(0xFF2D2828),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(30))),
//                           child: TextButton(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.arrow_back,
//                                   color: Colors.white,
//                                   size: 15.sp,
//                                 ),
//                                 Text(
//                                   ' להמשך למידה ',
//                                   style: TextStyle(
//                                       fontSize: 18.sp,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white),
//                                 ),
//                               ],
//                             ),
//                             onPressed: () {
//                               MainPage.of(context)?.mainWidget = HomePage(
//                                   user: IsarService().getCurrentUser());
//                               Navigator.pop(context);
//                             },
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void showOfflineSyncDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: AlertDialog(
//             content: Container(
//               height: 640.h,
//               width: 656.w,
//               child: Column(
//                 children: [
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: TextButton(
//                       child: Image.asset('assets/images/X.jpg', height: 18.h),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         /*top: 45.h,*/
//                         right: 70.w,
//                         left: 70.w),
//                     child: Column(
//                       children: [
//                         Image.asset('assets/images/offline.jpg', height: 153.h),
//                         SizedBox(
//                           height: 70.h,
//                         ),
//                         Text(
//                           'המערכת במצב לא מקוון',
//                           style: TextStyle(
//                               fontSize: 36.sp, fontWeight: FontWeight.w600),
//                           textDirection: TextDirection.rtl,
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(
//                           height: 45.h,
//                         ),
//                         Text(
//                             'כדי לסנכרן את נתוני הלמידה באתר\n יש לעבוד במצב מקוון.',
//                             style: TextStyle(fontSize: 18.sp),
//                             textDirection: TextDirection.rtl,
//                             textAlign: TextAlign.center),
//                         SizedBox(
//                           height: 35.h,
//                         ),
//                         Text(
//                           'ניתן גם לסנכרן נתונים ממחשב אחר שמחובר לרשת\n באמצעות הדיסק און קי אליו הורדת את התוכנה\n (אם הדיסק און קי מחובר למחשב עליו מותקנת התוכנה).',
//                           style: TextStyle(fontSize: 18.sp),
//                           textAlign: TextAlign.center,
//                           textDirection: TextDirection.rtl,
//                         ),
//                         SizedBox(
//                           height: 40.h,
//                         ),
//                         Container(
//                           height: 40.h,
//                           width: 171.w,
//                           decoration: BoxDecoration(
//                               color: Color(0xFF2D2828),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(30))),
//                           child: TextButton(
//                             child: Text(
//                               ' הבנתי, תודה! ',
//                               style: TextStyle(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white),
//                             ),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
