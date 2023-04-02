import 'package:eshkolot_offline/ui/screens/dialogs/dialogs.dart';
import 'package:eshkolot_offline/ui/screens/login_page.dart';
import 'package:eshkolot_offline/ui/screens/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBarUserWidget extends StatefulWidget {
  @override
  State<TopBarUserWidget> createState() => _TopBarUserWidgetState();
}

class _TopBarUserWidgetState extends State<TopBarUserWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(

      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )
      ..addListener(() {
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
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffF4F4F3)),
                child: Icon(Icons.search),
              ),
              SizedBox(width: 12.w),
              InkWell(
                onTap: () {
                  SyncEndDialog(context,MainPage.of(context)?.widget.user);
                  SyncDialog(context,controller);
                  //OfflineSyncDialog(context);
                  //CourseCompleteDialog(context, MainPage.of(context)?.widget.user, /*course,*/ controller);
                },
                child: Container(
                  height: 40.h,
                  width: 154.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
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
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Container(
                  height: 40.h,
                  width: 175.w,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline,size: 20.sp,color: Colors.white,),
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





}


