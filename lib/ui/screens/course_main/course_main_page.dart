import 'package:eshkolot_offline/ui/screens/course_main/subject_main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 624.h,
          width: 950.w,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE4E6E9)),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 90.h,),
              Image.asset('assets/images/logo_english.jpg',height: 147.h),
              SizedBox(height: 23.h,),
              Text(widget.course.title,style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600
              )),
              SizedBox(height: 15.h,),

              Text("התחל מכאן ללמוד ולתרגל את בסיס השפה האנגלית",style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400
              )),
              SizedBox(height: 30.h,),
              Container(
                height: 50.h,
                width: 551.w,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF6E7072)),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 19.w),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time,size: 15.sp,),
                          Text('21 שעות',style: TextStyle(fontSize: 18.sp),)
                        ],
                      ),
                      VerticalDivider(color: Colors.black,indent: 11.h,endIndent: 11.h,),

                      Row(
                        children: [
                         Icon(Icons.videocam_outlined,size: 15.sp,),
                          Text('33 שיעורים',style: TextStyle(fontSize: 18.sp),)
                        ],
                      ),
                      VerticalDivider(color: Colors.black,indent: 11.h,endIndent: 11.h,),
                      Row(
                        children: [
                          Icon(Icons.create,size: 15.sp,),
                          Text('35 שאלונים',style: TextStyle(fontSize: 18.sp),)
                        ],
                      ),
                      VerticalDivider(color: Colors.black,indent: 11.h,endIndent: 11.h,),
                      Row(
                        children: [
                          Icon(Icons.star_outline,size: 15.sp,),
                          Text('1 שאלון מסכם',style: TextStyle(fontSize: 18.sp),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 75.h,),
              ClipRRect(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 40.h,
                      //width: 441.w,

                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          alignment: Alignment.center,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.only(left: 50.w,right: 50.w),
                          textStyle: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          //todo change to place where stopped
                            MainPageChild.of(context)?.bodyWidget=SubjectMainPage(
                            subject:widget.course.subjects.first);
                            MainPageChild.of(context)?.subjectPickedIndex=0;

                        },
                        child: Text('המשך מהמקום שעצרת ${widget.course.subjects.isNotEmpty?widget.course.subjects.elementAt(0).lessons.elementAt(widget.course.lessonStopId).name:''}',
                            style: TextStyle(fontSize: 18.sp,fontFamily: 'RAG-Sans'),),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 145.h,),
        Padding(
          padding: EdgeInsets.only(left: 242.w),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 40.h,
              width: 175.w,
              decoration: BoxDecoration(
                  color: Color(0xFF32D489),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    alignment: Alignment.center,
                    foregroundColor: Colors.white,
                    //padding: EdgeInsets.only(left: 45.w,right: 45.w,),
                    textStyle: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    MainPageChild.of(context)?.bodyWidget=SubjectMainPage(
                        subject:widget.course.subjects.first);
                    MainPageChild.of(context)?.subjectPickedIndex=0;

                  },
                  child: Row(
                    children: [
                      Text(' לנושא הראשון', style: TextStyle(fontSize: 18.sp,fontFamily: 'RAG-Sans')),
                      Icon(Icons.arrow_forward,size: 15.sp,color: Colors.white,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
