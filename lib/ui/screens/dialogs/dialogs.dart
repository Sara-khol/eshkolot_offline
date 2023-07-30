
import 'package:eshkolot_offline/services/api_service.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/ui/screens/home_page.dart';
import 'package:eshkolot_offline/ui/screens/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/user.dart';

void SyncDialog(BuildContext context,AnimationController controller){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: AlertDialog(
          content: SizedBox(
            height: 640.h,
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
                Padding(
                  padding: EdgeInsets.only(/*top: 45.h,*/right: 70.w,left: 70.w),
                  child: Column(
                    children: [
                      Image.asset('assets/images/sync.jpg',height: 153.h),
                      SizedBox(height: 40.h,),
                      Text('אנחנו מסנכרנים את התקדמות הלמידה שלכם',
                        style: TextStyle(
                            fontSize: 36.sp, fontWeight: FontWeight.w600),
                        textDirection: TextDirection.rtl,
                        textAlign:TextAlign.center,
                      ),
                      SizedBox(height: 45.h,),
                      Text('כדי שהאתר באונליין יהיה מעודכן בהתקדמות הלמידה שלכם\n וכדי שתוכלו לקבל תעודה והחזר על דמי הפיקדון\n חשוב לנו לסנכרן את נתוני הלמידה.',
                          style: TextStyle(
                              fontSize: 18.sp
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign:TextAlign.center),
                      SizedBox(height: 36.h,),
                      Text('יש להשאיר את הלשונית פתוחה',
                        style: TextStyle(
                            fontSize: 18.sp
                        ),),
                      Text('אימייל עדכון ישלח בסיום תהליך הסנכרון',
                        style: TextStyle(
                            fontSize: 18.sp
                        ),),
                      SizedBox(height: 30.h,),
                      LinearProgressIndicator(
                        color: Color(0xFFFFDA6C),
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

  User user=IsarService().getCurrentUser();

List<int> courseCompleted = user.courses.where((course) => course.status==Status.finish)
      .map((course) => course.courseId)
      .toList();

  Map<String, dynamic> map =
  {'id_user':user.tz,'lessonCompleted': user.lessonCompleted, 'questionCompleted': user.questionCompleted,
    'subjectCompleted':user.subjectCompleted, 'coursesCompleted': courseCompleted};


  ApiService().syncData( onSuccess: (){}, onError: (){}, jsonMap: map);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: AlertDialog(
          content: Container(
            height: 640.h,
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
                Padding(
                  padding: EdgeInsets.only(/*top: 44.h,*/right: 70.w,left: 70.w),
                  child: Column(
                    children: [
                      Image.asset('assets/images/sync_done.jpg',height: 153.h),
                      SizedBox(height: 40.h,),
                      Text('מצוין! המערכת סיימה לסנכרן את נתוני הלמידה',
                        style: TextStyle(
                            fontSize: 36.sp, fontWeight: FontWeight.w600),
                        textDirection: TextDirection.rtl,
                        textAlign:TextAlign.center,
                      ),
                      SizedBox(height: 45.h,),
                      Text('במידה והשלמתם קורס התעודה מחכה לכם באזור האישי\n'
                          ' ותוכלו לקבל בחזרה את דמי הפיקדון או להשתמש\n בהם כדי להוריד קורס נוסף',
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
                      SizedBox(height: 63.h,),
                      Container(
                        
                        height: 40.h,width: 171.w,
                        decoration: BoxDecoration(
                          color: Color(0xFF2D2828),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back,color: Colors.white,size: 15.sp,),
                              Text(' להמשך למידה ',style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),),

                            ],
                          ),
                          onPressed: () {
                            MainPage.of(context)?.mainWidget= HomePage(user: user);
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
            height: 640.h,
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
                Padding(
                  padding: EdgeInsets.only(/*top: 45.h,*/ right: 70.w,left: 70.w),
                  child: Column(
                    children: [
                      Image.asset('assets/images/offline.jpg',height: 153.h),
                      SizedBox(height: 70.h,),
                      Text('המערכת במצב לא מקוון',
                        style: TextStyle(
                            fontSize: 36.sp, fontWeight: FontWeight.w600),
                        textDirection: TextDirection.rtl,
                        textAlign:TextAlign.center,
                      ),
                      SizedBox(height: 45.h,),
                      Text('כדי לסנכרן את נתוני הלמידה באתר\n יש לעבוד במצב מקוון.',
                          style: TextStyle(
                              fontSize: 18.sp
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign:TextAlign.center),
                      SizedBox(height: 35.h,),
                      Text('ניתן גם לסנכרן נתונים ממחשב אחר שמחובר לרשת\n באמצעות הדיסק און קי אליו הורדת את התוכנה\n (אם הדיסק און קי מחובר למחשב עליו מותקנת התוכנה).',
                        style: TextStyle(
                            fontSize: 18.sp
                        ),
                        textAlign:TextAlign.center,
                        textDirection: TextDirection.rtl,),
                      SizedBox(height: 40.h,),
                      Container(
                        height: 40.h,width: 171.w,
                        decoration: BoxDecoration(
                            color: Color(0xFF2D2828),
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: TextButton(
                          child: Text(' הבנתי, תודה! ',style: TextStyle(
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



