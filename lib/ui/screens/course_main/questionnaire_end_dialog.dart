import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionnaireEndDialog extends StatelessWidget
{
  const QuestionnaireEndDialog({super.key, required this.correctQNum, required this.qNum, required this.grade1, required this.grade2});
  final int correctQNum;
  final int qNum;
  final int grade1;
  final int grade2;
  @override
  Widget build(BuildContext context) {
    num grade=correctQNum==0?0:((correctQNum/qNum)*100).round();
   int statusGrade= grade<grade1?1:grade>grade2?3:2;

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
                          Text('תוצאות השאלון',
                            style: TextStyle(
                                fontSize: 36.sp, fontWeight: FontWeight.w600),
                            textDirection: TextDirection.rtl,
                            textAlign:TextAlign.center,
                          ),
                          SizedBox(height: 55.h,),
                          Text(' הצלחת ${correctQNum} מתוך ${qNum}  שאלות '),
                          SizedBox(height: 35.h,),
                          Text('%$grade הציון שלך הוא ',style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.w600)),
                          SizedBox(height: 40.h,),
                          Image.asset('assets/images/grade_$statusGrade.png',height: 253.h)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
    }
  }
