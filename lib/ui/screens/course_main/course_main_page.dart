import 'dart:ffi';

import 'package:eshkolot_offline/ui/screens/course_main/lesson_widget.dart';
import 'package:eshkolot_offline/ui/screens/course_main/subject_main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/course.dart';
import '../../../services/isar_service.dart';


class CourseMainPage extends StatefulWidget {
  const CourseMainPage({super.key});

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {

  late Widget displayWidget;

  void initState(){

    displayWidget=FutureBuilder<Course?>(
        future: getFirstEnglishCourse(),
          builder: (context, snapshot) {
          if (snapshot.hasData) {
          Course? course = snapshot.data;
          if (course!=null){
            return Column(
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
                        Text(course.title,style: TextStyle(
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
                                        setState(() {
                                          displayWidget=SubjectMainPage(course: course);
                                        });
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

                                      setState(() {
                                        displayWidget=SubjectMainPage(course: course);
                                      });
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
            );}
    }
        return Center(child: const CircularProgressIndicator());
          }

    );
  }


  @override
  Widget build(BuildContext context) {
    return displayWidget;
  }


  Future<Course?> getFirstEnglishCourse() async {
    return await IsarService.instance.getFirstCourse();
  }
}
