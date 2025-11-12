import 'package:eshkolot_offline/ui/screens/main_page/top_bar_user_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/installationDataHelper.dart';
import '../../../services/network_check.dart';
import '../../../services/sync_manger.dart';
import '../home_page.dart';
import '../main_page/main_page.dart';

class EndCourseDialog extends StatelessWidget {

  final String courseName;

  const EndCourseDialog({super.key, required this.courseName});


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
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
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 19.h,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          child: Image.asset(
                              'assets/images/X.jpg', height: 22.h),
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
                            Image.asset('assets/images/end_course.png'),
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              'כל הכבוד!',
                              style: TextStyle(
                                  fontSize: 36.sp, fontWeight: FontWeight.w600),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'סיימת קורס $courseName !',
                              style: TextStyle(
                                  fontSize: 36.sp, fontWeight: FontWeight.w600),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            // Text(
                            //     'עכשיו הזמן לסנכרן את נתוני הלמידה באתר אשכולות\nכדי לקבל את התעודה המחכה לכם באזור האישי\n'
                            //         'וכן את דמי הפיקדון ששילמתם.',
                            //     style: TextStyle(fontSize: 18.sp),
                            //     textDirection: TextDirection.rtl,
                            //     textAlign: TextAlign.center),

                            Text.rich(
                              TextSpan(
                                text: 'עכשיו הזמן לסנכרן את נתוני הלמידה באתר אשכולות\nכדי לקבל את התעודה המחכה לכם ',
                                style: TextStyle(fontSize: 18.sp),
                                children: [
                                  TextSpan(
                                    text: 'באזור האישי',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final url = Uri.parse('https://eshkolot.net/%d7%94%d7%9c%d7%9e%d7%99%d7%93%d7%94-%d7%a9%d7%9c%d7%99/');
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url, mode: LaunchMode.externalApplication);
                                        }
                                      },
                                  ),
                                  TextSpan(text:'\n'),
                                  TextSpan(
                                    text: 'וכן את דמי הפיקדון ששילמתם.',
                                    style: TextStyle(fontSize: 18.sp),

                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              'כל הכבוד על ההתמדה והלמידה!',
                              style: TextStyle(fontSize: 18.sp),
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(
                              height: 27.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 175.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      border: Border.all(
                                          color: const Color(0xFF2D2828))),
                                  child: TextButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Icon(
                                          Icons.refresh,
                                          size: 20.sp,
                                          color: const Color(0xFF2D2828),
                                        ),
                                        Text(
                                          '  סינכרון נתונים  ',
                                          style: TextStyle(
                                              color: const Color(0xFF2D2828),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    onPressed: ()async {
                                      final appContext = Navigator.of(context, rootNavigator: true).context; // stable
                                      Navigator.pop(context); // close the "EndCourseDialog"
                                      await Future.microtask(() => SyncManager.sync(appContext)); // trigger shared sync flow
                                    },
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Container(
                                  height: 40.h,
                                  width: 171.w,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF2D2828),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: TextButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          ' להמשך למידה ',
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                          size: 15.sp,
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 50.h),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }


}