import 'package:eshkolot_offline/ui/screens/login/forgot_password_dialog.dart';
import 'package:eshkolot_offline/ui/screens/main_page/main_page.dart';
import 'package:eshkolot_offline/ui/screens/main_page/title_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/user.dart';
import '../../../services/isar_service.dart';
import '../../../utils/my_colors.dart';

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
            body: ListView(shrinkWrap: true, children: [
              const TitleBarWidget(),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 110.h),
                    Container(
                      margin: EdgeInsets.only(right: 55.w),
                      child: Image.asset(
                        'assets/images/eshkolot_big_icon.png',
                        height: 53.h,
                      ),
                    ),
                    SizedBox(height: 52.h),
                    SizedBox(
                      height: 736.h,
                      child: Stack(
                      alignment: Alignment.topCenter, // Aligns children relative to the top-left corner.                      // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/login_background1.png',
                            fit: BoxFit.cover,
                            width: 1542.w,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 55.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                  Text('ברוך הבא לאשכולות אופליין',
                                      style: TextStyle(
                                          color: myColor,
                                          fontSize: 36.sp,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(height: 27.h),
                                  Text(
                                      'אשכולות אופליין מאפשרת למידה גם בצב לא מקוון. הורידו את\nהתוכנה, התחברו לחשבון שלכם באינטרנט, ותוכלו גם בבית\nלהנות מחווית למידה שמורה לכל המשפחה.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: myColor, fontSize: 20.sp,height: 1.2
                                      )),
                                  //  SizedBox(height: 27.h)
                                ]),
                                Container(
                                  width: 690.w,
                                  height:(isError || isErrorNoCourses) ?342.h:331.h,
                                  margin: EdgeInsets.only(bottom: 36.h),
                                  decoration: BoxDecoration(  color: Colors.white,border: Border.all(color: grey2ColorApp)),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 69.h),
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
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(9),
                                              FilteringTextInputFormatter.digitsOnly
                                            ],
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
                                                  borderSide:
                                                  const BorderSide(color: Color(0xffF4F4F3))),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(30),
                                                  borderSide:
                                                  const BorderSide(color: Color(0xffF4F4F3))),
                                              //contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                                              hintStyle: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: const Color(0xff6E7072)),
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
                                      Align(
                                        alignment: Alignment.center,
                                        child: InkWell(
                                          onTap: () async {
                                            // if (controller.text.isNotEmpty) {
                                            User? user =
                                            await IsarService().getUserByTz(controller.text);
                                            if (user != null && user.knowledgeCoursesMap.isNotEmpty) {
                                              if (mounted) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => MainPage(user: user)));
                                              }
                                            } else {
                                              setState(() {
                                                user == null ? isError = true : isErrorNoCourses = true;
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
                                                borderRadius:
                                                const BorderRadius.all(Radius.circular(30))),
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
                                                    : isError
                                                    ? 'התעודת זהות שהזנת שגויה'
                                                    : 'למשתמש אין קורסים שרשום אליהם',
                                                style: TextStyle(fontSize: 20.sp, color: Colors.red)),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment.bottomCenter,
                          //   // child: Positioned(
                          //   //   top: 193.h,
                          //   //   right: 400.w,
                          //   //   left:219.w ,
                          //     child: Container(
                          //       width: 690.w,
                          //       height: 331.h,
                          //       margin: EdgeInsets.only(bottom: 22.h),
                          //       decoration: BoxDecoration(  color: Colors.white,border: Border.all(color: grey2ColorApp)),
                          //       child: Column(
                          //         children: [
                          //           SizedBox(height: 69.h),
                          //           Text('יש להזין ת.ז. לצורך התחברות',
                          //               textAlign: TextAlign.center,
                          //               style: TextStyle(color: myColor, fontSize: 18.sp)),
                          //           SizedBox(height: 23.h),
                          //           Container(
                          //             height: 50.h,
                          //             width: 389.w,
                          //             decoration: const BoxDecoration(
                          //                 color: Color(0xFFF4F4F3),
                          //                 borderRadius: BorderRadius.all(Radius.circular(30))),
                          //             child: TextField(
                          //               // onChanged: (text)
                          //               //   {
                          //               //     if(text.isEmpty) {
                          //               //       isError=true;
                          //               //       setState(() {});
                          //               //     }
                          //               //   },
                          //               //   keyboardType: TextInputType.number,
                          //                 controller: controller,
                          //                 inputFormatters: <TextInputFormatter>[
                          //                   LengthLimitingTextInputFormatter(9),
                          //                   FilteringTextInputFormatter.digitsOnly
                          //                 ],
                          //                 // Only numbers can be entered,max 9 digits
                          //                 // autofocus: true,
                          //                 textAlign: TextAlign.right,
                          //                 cursorColor: Colors.black,
                          //                 style: TextStyle(
                          //                   fontSize: 18.sp,
                          //                 ),
                          //                 decoration: InputDecoration(
                          //                   focusedBorder: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(30),
                          //                       borderSide:
                          //                       const BorderSide(color: Color(0xffF4F4F3))),
                          //                   enabledBorder: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(30),
                          //                       borderSide:
                          //                       const BorderSide(color: Color(0xffF4F4F3))),
                          //                   //contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                          //                   hintStyle: TextStyle(
                          //                       fontSize: 18.sp,
                          //                       color: const Color(0xff6E7072)),
                          //                   hintText: 'תעודת זהות',
                          //                 )),
                          //           ),
                          //           SizedBox(height: 23.h),
                          //           GestureDetector(
                          //             onTap: () {
                          //               showDialog(
                          //                 context: context,
                          //                 builder: (BuildContext context) =>
                          //                 const ForgotPasswordDialog(),
                          //               );
                          //             },
                          //             child: Row(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Text('לא מצליחים להכנס? ',
                          //                     style: TextStyle(fontSize: 15.sp)),
                          //                 Text('שחזור סיסמא',
                          //                     style: TextStyle(
                          //                       fontSize: 15.sp,
                          //                       color: const Color(0xff5956DA),
                          //                       decoration: TextDecoration.underline,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(height: 30.h),
                          //           Align(
                          //             alignment: Alignment.center,
                          //             child: InkWell(
                          //               onTap: () async {
                          //                 // if (controller.text.isNotEmpty) {
                          //                 User? user =
                          //                 await IsarService().getUserByTz(controller.text);
                          //                 if (user != null && user.knowledgeCoursesMap.isNotEmpty) {
                          //                   if (mounted) {
                          //                     Navigator.pushReplacement(
                          //                         context,
                          //                         MaterialPageRoute(
                          //                             builder: (context) => MainPage(user: user)));
                          //                   }
                          //                 } else {
                          //                   setState(() {
                          //                     user == null ? isError = true : isErrorNoCourses = true;
                          //                   });
                          //                 }
                          //                 // } else {
                          //                 //   setState(() {
                          //                 //     isError = true;
                          //                 //   });
                          //                 // }
                          //               },
                          //               child: Container(
                          //                 height: 40.h,
                          //                 width: 171.w,
                          //                 decoration: BoxDecoration(
                          //                     color: myColor,
                          //                     borderRadius:
                          //                     const BorderRadius.all(Radius.circular(30))),
                          //                 child: Center(
                          //                   child: Row(
                          //                     crossAxisAlignment: CrossAxisAlignment.center,
                          //                     mainAxisAlignment: MainAxisAlignment.center,
                          //                     children: [
                          //                       Text(
                          //                         'התחברות ',
                          //                         style: TextStyle(
                          //                             fontSize: 18.sp,
                          //                             fontWeight: FontWeight.w600,
                          //                             color: Colors.white),
                          //                       ),
                          //                       Icon(
                          //                         Icons.arrow_forward,
                          //                         size: 15.sp,
                          //                         color: Colors.white,
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //           SizedBox(height: 20.h),
                          //           Visibility(
                          //               visible: isError || isErrorNoCourses,
                          //               child: Center(
                          //                 child: Text(
                          //                     controller.text.isEmpty
                          //                         ? 'נא להזין תעודת זהות'
                          //                         : isError
                          //                         ? 'התעודת זהות שהזנת שגויה'
                          //                         : 'למשתמש אין קורסים שרשום אליהם',
                          //                     style: TextStyle(fontSize: 20.sp, color: Colors.red)),
                          //               ))
                          //         ],
                          //       ),
                          //     ),
                          //  // ),
                          // ),
                          // Positioned(
                          //     top: 244.h,
                          //     left: 539.w,
                          //     child: Image.asset(
                          //       'assets/images/learn_icon.png',
                          //       height: 86.h,
                          //     )),
                        ],
                      )
                    ),
                    Image.asset(
                      'assets/images/logo_other.png',
                      height: 53.h,
                    ),
                  ])]),
            floatingActionButton: kDebugMode
                ? FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: () async {
                  IsarService().cleanDb();
                })
                : null));
  }
}
