
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class CommonFuncs
{
  void showMyToast(String message, { int duration = 3}) {
    Widget widget = /*Container(
        margin: EdgeInsets.only(bottom: 80.h),
        padding: EdgeInsets.only(right: 30.w, left: 30.w),
        child:*/ ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Container(
            padding: EdgeInsets.all(20.w),
            color: Colors.black87,
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
              textAlign: TextAlign.center,
            ),
          ),
       // )
    );

    showToastWidget(
      widget,
      duration: Duration(seconds: duration),
      onDismiss: () {},

      position: ToastPosition.bottom,
    );
  }
}