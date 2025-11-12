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
import '../../../services/sync_manger.dart';
import '../dialogs/sync_dialogs.dart';
import 'main_page.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;


class TopBarUserWidget extends StatefulWidget {

  const TopBarUserWidget({super.key});

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
      //height: 65.h,
      decoration:  const BoxDecoration(
      //  color: colors.blackColorApp,
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
                  await SyncManager.sync(context);
                },
                child: Container(
                  height: 40.h,
                  width: 154.w,
                  decoration: BoxDecoration(
                    color: colors.blackColorApp,
                      border: Border.all(color: Colors.white),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                      Text(
                        '  סינכרון נתונים  ',
                        style: TextStyle(
                            color: Colors.white,
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
                  decoration:  const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 20.sp,
                        color:colors.blackColorApp,
                      ),
                      Text(
                        ' החלפת משתמש  ',
                        style: TextStyle(
                            color: colors.blackColorApp,
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
