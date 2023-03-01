import 'package:eshkolot_offline/ui/screens/main_page/main_page.dart';
import 'package:eshkolot_offline/ui/screens/main_page/title_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/user.dart';
import '../../services/isar_service.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color myColor = const Color(0xff2D2828);

  TextEditingController controller = TextEditingController();

  bool isError=false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(children: [
          TitleBarWidget(),
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            SizedBox(height: 248.h),
            Text('ברוך הבא לאשכולות אופליין',
                style: TextStyle(
                    color: myColor,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 88.h),
            Text('הזן ת"ז להתחברות',
                textAlign: TextAlign.end,
                style: TextStyle(color: myColor, fontSize: 18.sp)),
            SizedBox(height: 23.h),
            Container(
              height: 50.h,
              width: 389.w,
              child: TextField(
                keyboardType:TextInputType.number ,
                  // maxLength: 9,
                  controller: controller,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(9),
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered,max 9 digits
                  // autofocus: true,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                  decoration: InputDecoration(

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff5956DA))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff5956DA))),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                    hintStyle: TextStyle(
                        fontSize: 18.sp, color: Color(0xff6E7072)),

                    hintText: 'תעודת זהות',
                  )),
            ),
           // Row(children: [Text('לא מצליחים להכנס?',style: TextStyle(fontSize: 15.sp),)],),
                SizedBox(height: 42.h),
          ]),
          InkWell(
            onTap: () async {
              User? user = await IsarService.instance.getUserByTz(controller.text);
              if (user != null) {
                if(mounted) {
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainPage(user: user)));
                }
              }
              else {
            setState(() {
              isError=true;
            });
              }
            },
            child: Container(
              height: 50.h,
              width: 207.w,
              decoration: BoxDecoration(
                  color: myColor,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              child: Center(
                child: Text(
                  'התחברות',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Visibility(visible:isError ,
              child: Text('התעודת זהות שהזנת שגויה',style: TextStyle(fontSize: 20.sp,color: Colors.red)))
        ]),
          floatingActionButton: FloatingActionButton(
              onPressed: () => IsarService.instance.cleanDb())
      ),
    );
  }
}
