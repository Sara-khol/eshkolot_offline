
import 'package:eshkolot_offline/ui/screens/course_main/subject_main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/course.dart';
import 'main_page_child.dart';


class CourseMainPage extends StatefulWidget {
 final Course course;
  const CourseMainPage({super.key, required this.course});

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {



  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return     Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:31),
              child: Image.asset('assets/images/img.jpg',height: 176.h),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.course.title,style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w400
                ),textAlign: TextAlign.right),
                Padding(
                  padding: const EdgeInsets.only(top:15,bottom: 26),
                  child: Text("התחל מכאן ללמוד ולתרגל את בסיס השפה האנגלית",style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400
                  ),textAlign: TextAlign.right),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF6E7072))
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Row(
                          children: [
                            Icon(Icons.access_time,size: 20.sp,),
                            Text('21 שעות',style: TextStyle(fontSize: 20.sp),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.bookOpen,size: 20.sp,),
                            Text('33 שיעורים',style: TextStyle(fontSize: 20.sp),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Row(
                          children: [
                            Icon(Icons.create,size: 20.sp,),
                            Text('35 שאלונים',style: TextStyle(fontSize: 20.sp),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.w, left: 20),
                        child: Row(
                          children: [
                            Icon(Icons.assignment_turned_in,size: 20.sp,),
                            Text('1 שאלונים מסכמים',style: TextStyle(fontSize: 20.sp),)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top:75.h),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 32.w),
                child: Column(
                  children: [
                    ClipRRect(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.black)
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                alignment: Alignment.center,
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.only(left: 45.w,right: 45.w),
                                textStyle: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w400),
                              ),
                              onPressed: () {
                                //todo change to place where stopped
                                  MainPageChild.of(context)?.bodyWidget=SubjectMainPage(
                                  subject:widget.course.subjects.first);
                                  MainPageChild.of(context)?.subjectPickedIndex=0;

                              },
                              child: Text('המשך מהמקום בו עצרת', style: TextStyle(fontSize: 20.sp)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ClipRRect(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.black)
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              alignment: Alignment.center,
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.only(left: 45.w,right: 45.w,),
                              textStyle: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w400),
                            ),
                            onPressed: () {
                                MainPageChild.of(context)?.bodyWidget=SubjectMainPage(
                                    subject:widget.course.subjects.first);
                                MainPageChild.of(context)?.subjectPickedIndex=0;

                            },
                            child: Text('עבור אל הנושא הראשון', style: TextStyle(fontSize: 20.sp)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

}
