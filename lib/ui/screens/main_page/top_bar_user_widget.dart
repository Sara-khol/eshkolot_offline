import 'package:eshkolot_offline/ui/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBarUserWidget extends StatefulWidget {
  @override
  State<TopBarUserWidget> createState() => _TopBarUserWidgetState();
}

class _TopBarUserWidgetState extends State<TopBarUserWidget> {
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Expanded(
                          child: Column(
                        children: [
                          SizedBox(height: 44.h,),
                          Text(
                            'אנחנו מסנכרנים את התקדמות הלמידה שלכם',
                            style: TextStyle(
                                fontSize: 36.sp, fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                          // AlertDialog(
                          //   title: Text('Welcome'),
                          //   content: Text('GeeksforGeeks'),
                          //   actions: [
                          //     TextButton(
                          //     //  textColor: Colors.black,
                          //       onPressed: () {},
                          //       child: Text('CANCEL'),
                          //     ),
                          //     TextButton(
                          //       // textColor: Colors.black,
                          //       onPressed: () {},
                          //       child: Text('ACCEPT'),
                          //     ),
                          //   ],
                          // ),
                          );
                    },
                  );
                },
                child: Container(
                  height: 40.h,
                  width: 154.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'סנכרון נתונים',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 10.w),
                      Icon(
                        Icons.sync,
                        size: 18.h,
                      )
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
                  width: 154.w,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: Center(
                    child: Text(
                      'החלפת משתמש',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
