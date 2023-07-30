import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionnaireEndDialog extends StatelessWidget
{
  const QuestionnaireEndDialog({super.key, required this.correctQNum, required this.qNum});
  final int correctQNum;
  final int qNum;
  @override
  Widget build(BuildContext context) {
    return
           Center(
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
                          SizedBox(height: 15.h,),
                          Container(height: 40.h,child: Text(' הצלחת ${correctQNum} מתוך ${qNum}  שאלות '),)
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
