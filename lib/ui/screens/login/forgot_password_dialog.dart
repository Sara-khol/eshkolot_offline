
import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/services/api_service.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:eshkolot_offline/services/network_check.dart';
import 'package:eshkolot_offline/utils/common_funcs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;


class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final TextEditingController controller = TextEditingController();
  bool isError = false;
  bool isLoading=false;
  int selectedUserId = 1;
  late List<User> users;
  late Future myFuture;

  @override
  void initState() {
    myFuture=getAllUsers();
     super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // return AlertDialog(
    //   title: Text('My Dialog'),
    //   content: Text('This is a stateful widget displayed as a dialog.'),
    //   actions: [
    //     TextButton(
    //       child: Text('Close'),
    //       onPressed: () => Navigator.of(context).pop(),
    //     ),
    //   ],
    // );

    return FutureBuilder(
        future: myFuture,
      builder: (context,s) {
          if(s.hasData) {
            return Center(
          child: AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            elevation: 0,
            content: Wrap(
              children: [
                SizedBox(
                 // height: 640.h,
                  width: 656.w,
                  child: Column(
                    children: [
                      SizedBox(height: 19.h),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          child: Image.asset('assets/images/X.jpg', height: 18.h),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            /*top: 44.h,*/
                            right: 70.w,
                            left: 70.w),
                        child: Column(
                          children: [
                            Image.asset('assets/images/forgot_password.png',
                                height: 153.h),
                            SizedBox(
                              height: 40.h,
                            ),
                            Text(
                              '?שכחת סיסמא',
                              style: TextStyle(
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colors.blackColorApp),
                              // textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Text('לאיפוס סיסמא עליך להיות מחובר לרשת',
                                style: TextStyle(
                                    fontSize: 15.sp, color: colors.grey1ColorApp)),
                            SizedBox(height: 63.h),
                            Text('בחר את המשתמש הרצוי ונשלח אליך מייל לאיפוס סיסמא',
                                style: TextStyle(
                                    fontSize: 18.sp, color: colors.blackColorApp),
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: 22.h,
                            ),
                           userDropDown(users),
                            SizedBox(
                              height: 62.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 171.w,
                                  decoration: BoxDecoration(
                                      color: colors.blackColorApp,
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(30))),
                                  child: TextButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 15.sp,
                                        ),
                                        Text(
                                          ' לאיפוס סיסמא ',
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {
                                      // if (controller.text.isNotEmpty) {
                                      //   if (isEmail(controller.text)) {
                                      if(await NetworkConnectivity.instance.checkConnectivity()) {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        ApiService().sendPasswordRecoveryMail(
                                            id: selectedUserId,
                                            onSuccess: () async {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              CommonFuncs().showMyToast(
                                                  'מייל לאיפוס סיסמא נשלח אליך בהצלחה');
                                              Navigator.pop(context);
                                            },
                                            onError: () {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              CommonFuncs().showMyToast(
                                                  'ישנה בעיה, נסה שנית');
                                            });
                                        //   } else {
                                        //     setState(() {
                                        //       isError = true;
                                        //     });
                                        //   }
                                        // } else {
                                        //   setState(() {
                                        //     isError = true;
                                        //   });
                                        // }
                                      }
                                      else
                                        {
                                          CommonFuncs().showMyToast(
                                              'אינך מחובר לרשת האינטרנט');
                                        }
                                    },
                                  ),
                                ),
                                if(isLoading)
                                SizedBox(width: 10.w),
                                if(isLoading)
                                  CircularProgressIndicator(color: colors.grey1ColorApp),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            // Visibility(
                            //     visible: isError,
                            //     child: Text(
                            //         controller.text.isEmpty
                            //             ? 'נא להזין כתובת אימייל'
                            //             : 'האימייל שהוזן שגוי',
                            //         style:
                            //             TextStyle(fontSize: 20.sp, color: Colors.red))),


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
          }
          return const CircularProgressIndicator();
      }
    );
  }

  getAllUsers() async
  {
    users= await IsarService().getAllUsers();
    selectedUserId=users.first.id;
    debugPrint('selectedUserId $selectedUserId');
    return users;
  }

  userDropDown(List<User>users)
  {
    return DropdownButtonHideUnderline(
      child: DropdownButton<int>(
        value: selectedUserId,
        items: users.map((User user) {
          return DropdownMenuItem<int>(
            value: user.id,
            child: Padding(padding: EdgeInsets.only(left: 5.w),
                child: Text(user.name)),
          );
        }).toList(),
        onChanged: (int? newValue) {
          setState(() {
            selectedUserId = newValue!;
          });
        },
      ),
    );
  }

  mailTextField()
  {
    return Container(
      height: 50.h,
      width: 389.w,
      decoration: BoxDecoration(
          color: colors.lightGrey1ColorApp,
          borderRadius:
          const BorderRadius.all(Radius.circular(30))),
      child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
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
                fontSize: 18.sp, color: colors.grey1ColorApp),
            hintText: 'כתובת אימייל',
          )),
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}


