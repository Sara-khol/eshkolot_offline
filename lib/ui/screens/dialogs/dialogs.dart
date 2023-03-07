import 'package:eshkolot_offline/models/course.dart';
import 'package:eshkolot_offline/ui/screens/home_page.dart';
import 'package:eshkolot_offline/ui/screens/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/user.dart';
import '../../../services/isar_service.dart';

void SyncDialog(BuildContext context,AnimationController controller){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: AlertDialog(
          content: Container(
            height: 484.h,
            width: 656.w,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  /*child: CloseButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),*/
                  /*child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset('assets/images/X.jpg',height: 16.h),),*/
                  child: TextButton(
                    child: Image.asset('assets/images/X.jpg',height: 18.h),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 45.h,right: 70.w,left: 70.w),
                  child: Column(
                    children: [
                      Text('אנחנו מסנכרנים את התקדמות הלמידה שלכם',
                        style: TextStyle(
                            fontSize: 32.sp, fontWeight: FontWeight.w600),
                        textDirection: TextDirection.rtl,
                        textAlign:TextAlign.center,
                      ),
                      SizedBox(height: 45.h,),
                      Text('כדי שהאתר באונליין יהיה מעודכן בהתקדמות הלמידה שלכם וכדי שתוכלו לקבל תעודה והחזר על דמי הפיקדון חשוב לנו לסנכרן את נתוני הלמידה',
                          style: TextStyle(
                              fontSize: 18.sp
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign:TextAlign.center),
                      SizedBox(height: 36.h,),
                      Text('השאר את הלשונית פתוחה',
                        style: TextStyle(
                            fontSize: 18.sp
                        ),),
                      Text('ישלח אליך אימייל עידכון כשיסתיים הסינכרון',
                        style: TextStyle(
                            fontSize: 18.sp
                        ),),
                      SizedBox(height: 40.h,),
                      LinearProgressIndicator(
                        color: Color(0xFFB9FFDD),
                        backgroundColor: Color(0xFFE4E6E9),
                        minHeight: 9.h,
                        value: controller.value+0.3,
                      ),
                      SizedBox(height: 12.sp,),
                      Text("סונכרנו %${controller.value.toInt()}   |  זמן משוער שנותר 7 דק'",textDirection: TextDirection.rtl,style: TextStyle(
                        fontSize: 9.sp,
                      ),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


void SyncEndDialog(BuildContext context,User? user){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: AlertDialog(
          content: Container(
            height: 484.h,
            width: 656.w,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                    /*child: CloseButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),*/
                  /*child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset('assets/images/X.jpg',height: 16.h),),*/
                  child: TextButton(
                    child: Image.asset('assets/images/X.jpg',height: 18.h),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                        //child: Image.asset('assets/images/X.jpg',height: 16.h))),
                Padding(
                  padding: EdgeInsets.only(top: 44.h,right: 70.w,left: 70.w),
                  child: Column(
                    children: [
                      Text('מצוין! המערכת סיימה לסנכרן את נתוני הלמידה',
                        style: TextStyle(
                            fontSize: 32.sp, fontWeight: FontWeight.w600),
                        textDirection: TextDirection.rtl,
                        textAlign:TextAlign.center,
                      ),
                      SizedBox(height: 45.h,),
                      Text('במידה והשלמתם קורס התעודה מחכה לכם באזור האישי ותקבלו בחזרה את דמי הפיקדון',
                          style: TextStyle(
                              fontSize: 18.sp
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign:TextAlign.center),
                      SizedBox(height: 35.h,),
                      Text('כל הכבוד על ההתמדה והלמידה!',
                        style: TextStyle(
                            fontSize: 18.sp
                        ),
                        textDirection: TextDirection.rtl,),
                      SizedBox(height: 70.h,),
                      Container(
                        color: Color(0xFF2D2828),
                        height: 50.h,width: 193.w,
                        child: TextButton(
                          child: Text(' להמשך למידה ',style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                          ),),
                          onPressed: () {
                            MainPage.of(context)?.mainWidget= HomePage(user: user!);
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


void OfflineSyncDialog(BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: AlertDialog(
          content: Container(
            height: 484.h,
            width: 656.w,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  /*child: CloseButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),*/
                  /*child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset('assets/images/X.jpg',height: 16.h),),*/
                  child: TextButton(
                    child: Image.asset('assets/images/X.jpg',height: 18.h),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 45.h, right: 70.w,left: 70.w),
                  child: Column(
                    children: [
                      Text('הנך במצב לא מקוון',
                        style: TextStyle(
                            fontSize: 32.sp, fontWeight: FontWeight.w600),
                        textDirection: TextDirection.rtl,
                        textAlign:TextAlign.center,
                      ),
                      SizedBox(height: 45.h,),
                      Text('כדי לסנכרן את נתוני הלמידה באתר עליך להיות במצב מקוון.',
                          style: TextStyle(
                              fontSize: 18.sp
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign:TextAlign.center),
                      SizedBox(height: 35.h,),
                      Text('תוכל גם לסנכרן נתונים ממחשב אחר שהוא מחובר לרשת באמצעות האונקי אליו הורדת את התוכנה (אם האונקי מחובר למחשב עליו התקנת את התוכנה).',
                        style: TextStyle(
                            fontSize: 18.sp
                        ),
                        textAlign:TextAlign.center,
                        textDirection: TextDirection.rtl,),
                      SizedBox(height: 40.h,),
                      Container(
                        color: Color(0xFF2D2828),
                        height: 50.h,width: 360.w,
                        child: TextButton(
                          child: Text(' הבנתי תודה ',style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          ),),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


void CourseCompleteDialog(BuildContext context,User? user,/*Course course,*/AnimationController controller){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: AlertDialog(
          content: Container(
            height: 484.h,
            width: 656.w,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    child: Image.asset('assets/images/X.jpg',height: 18.h),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                //child: Image.asset('assets/images/X.jpg',height: 16.h))),
                Padding(
                  padding: EdgeInsets.only(top: 44.h,right: 70.w,left: 70.w),
                  child: Column(
                    children: [
                      Text('כל הכבוד!',
                        style: TextStyle(
                            fontSize: 32.sp, fontWeight: FontWeight.w600),
                        textDirection: TextDirection.rtl,
                        textAlign:TextAlign.center,
                      ),
                      Text('סיימת קורס ${user!.name/*course.title*/} !',
                        style: TextStyle(
                            fontSize: 32.sp, fontWeight: FontWeight.w600),
                        textDirection: TextDirection.rtl,
                        textAlign:TextAlign.center,
                      ),
                      SizedBox(height: 45.h,),
                      Text('עכשיו הזמן לסנכרן את נתוני הלמידה באתר אשכולות כדי לקבל את התעודה המחכה לכם באזור האישי וכן את דמי הפיקדון ששילמתם',
                          style: TextStyle(
                              fontSize: 18.sp
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign:TextAlign.center),
                      SizedBox(height: 35.h,),
                      Text('כל הכבוד על ההתמדה והלמידה!',
                        style: TextStyle(
                            fontSize: 18.sp
                        ),
                        textDirection: TextDirection.rtl,),
                      SizedBox(height: 56.h,),
                      Row(
                        children: [
                          Container(
                            color: Color(0xFF2D2828),
                            height: 50.h,width: 193.w,
                            child: TextButton(
                              child: Text(' לסנכרון נתונים ',style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                              ),),
                              onPressed: () {
                                //MainPage.of(context)?.mainWidget= HomePage(user: user!);
                                SyncDialog(context, controller);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(width: 53.w,),
                          Container(
                            color: Color(0xFF2D2828),
                            height: 50.h,width: 193.w,
                            child: TextButton(
                              child: Text(' להמשך למידה ',style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                              ),),
                              onPressed: () {
                                MainPage.of(context)?.mainWidget= HomePage(user: user!);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


