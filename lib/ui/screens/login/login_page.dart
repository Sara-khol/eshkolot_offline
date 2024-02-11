import 'package:eshkolot_offline/ui/screens/login/forgot_password_dialog.dart';
import 'package:eshkolot_offline/ui/screens/main_page/main_page.dart';
import 'package:eshkolot_offline/ui/screens/main_page/title_bar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/user.dart';
import '../../../services/isar_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color myColor = const Color(0xff2D2828);

  //todo remove text
  TextEditingController controller = TextEditingController();

  bool isError = false;
  bool isErrorNoCourses = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(shrinkWrap: true,
              children: [
            const TitleBarWidget(),
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 235.h),
                  Image.asset(
                    'assets/images/login.jpg',
                    height: 190.h,
                  ),
                  SizedBox(height: 62.h),
                  Text('ברוכים הבאים לאשכולות אופליין',
                      style: TextStyle(
                          color: myColor,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 30.h),
                  Text('יש להזין ת.ז. לצורך התחברות',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: myColor, fontSize: 18.sp)),
                  SizedBox(height: 23.h),
                  Container(
                    height: 50.h,
                    width: 389.w,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF4F4F3),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: TextField(
                        // onChanged: (text)
                        //   {
                        //     if(text.isEmpty) {
                        //       isError=true;
                        //       setState(() {});
                        //     }
                        //   },
                     //   keyboardType: TextInputType.number,
                        controller: controller,
                        // inputFormatters: <TextInputFormatter>[
                        //   LengthLimitingTextInputFormatter(9),
                        //   FilteringTextInputFormatter.digitsOnly
                        // ],
                        // Only numbers can be entered,max 9 digits
                        // autofocus: true,
                        textAlign: TextAlign.right,
                        cursorColor: Colors.black,
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(color: Color(0xffF4F4F3))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(color: Color(0xffF4F4F3))),
                          //contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                          hintStyle: TextStyle(
                              fontSize: 18.sp, color: const Color(0xff6E7072)),
                          hintText: 'תעודת זהות',
                        )),
                  ),
                  SizedBox(height: 23.h),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            const ForgotPasswordDialog(),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('לא מצליחים להכנס? ',
                            style: TextStyle(fontSize: 15.sp)),
                        Text('שחזור סיסמא',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xff5956DA),
                              decoration: TextDecoration.underline,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ]),
        Align(
          alignment: Alignment.center,
          child:InkWell(
            onTap: () async {
              // if (controller.text.isNotEmpty) {
              User? user = await IsarService().getUserByTz(controller.text);
              if (user != null && user.knowledgeCoursesMap.isNotEmpty) {
                if (mounted) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPage(user: user)));
                }
              } else {
                setState(() {
                  user==null?   isError = true:isErrorNoCourses=true;
                });
              }
              // } else {
              //   setState(() {
              //     isError = true;
              //   });
              // }
            },
            child: Container(
              height: 40.h,
              width: 171.w,
              decoration: BoxDecoration(
                  color: myColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'התחברות ',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 15.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
            SizedBox(height: 20.h),
            Visibility(
                visible: isError || isErrorNoCourses,
                child: Center(
                  child: Text(
                      controller.text.isEmpty
                          ? 'נא להזין תעודת זהות'
                          :isError? 'התעודת זהות שהזנת שגויה':'למשתמש אין קורסים שרשום אליהם',
                      style: TextStyle(fontSize: 20.sp, color: Colors.red)),
                ))
          ]),
          floatingActionButton:kDebugMode? FloatingActionButton(backgroundColor: Colors.blue,
              onPressed: ()
          async {
            IsarService().cleanDb();
          }):null)
    );
  }
}
