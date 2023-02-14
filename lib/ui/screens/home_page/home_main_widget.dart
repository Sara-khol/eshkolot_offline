import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';

import '../../../models/course.dart';
import '../../../models/user.dart';

class HomeMainWidget extends StatefulWidget {
  const HomeMainWidget({super.key});

  @override
  State<HomeMainWidget> createState() => _HomeMainWidgetState();
}

class _HomeMainWidgetState extends State<HomeMainWidget> {
  // List<Knowledge>? knowledgeList = [];
  IsarLinks<Knowledge>? knowledgeList;


  // List<KnowledgeLd> knowledgeList = [];

  @override
  void initState() {
    //aa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: IsarService.instance.getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User? user = snapshot.data;
              knowledgeList = user?.knowledgeList;
              return Padding(
                padding: EdgeInsets.only(
                    top: 78.h, bottom: 160.h /*,right: 132.w,left: 132.w*/),
                child: Column(
                  children: [
                    Center(
                        child: Text('שלום ${user!.name}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 32.sp))),
                    SizedBox(height: 26.h),
                    Container(
                        height: 51.h,
                        decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(50))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              topInformation(Icons.check_circle, 'הושלם 2'),
                              Container(
                                  height: 27.h,
                                  width: 1.w,
                                  color: Color(0xFF2D2828)),
                              topInformation(Icons.update, 'ממתין לסינכרון 1'),
                              Container(
                                  height: 27.h,
                                  width: 1.w,
                                  color: Color(0xFF2D2828)),
                              topInformation(Icons.offline_pin, ' תעודות 1'),
                            ])),
                    SizedBox(height: 35.h),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // children: [myCoursesWidget(),SizedBox(width: 35.w)/*,myCoursesWidget()*/])
                        children: [myCoursesWidget(false),SizedBox(width: 36.w),myCoursesWidget(true)])
                  ],
                ),
              );
            } else
              return CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => IsarService.instance.cleanDb())
    );
  }

  topInformation(IconData iconData, String s) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Padding(
          padding: EdgeInsets.only(right: 20.w, left: 15.w),
          child: Icon(iconData)),
      Text(s, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400)),
      SizedBox(width: 25.w),
    ]);
  }

  myCoursesWidget(bool isPath) {
    if (knowledgeList != null && knowledgeList!.isNotEmpty) {
      return Container(
        width: 690.w,
        height: 610.h,
        padding:
        EdgeInsets.only(top: 30.h, right: 42.w, left: 42.w, bottom: 30.h),
        decoration: BoxDecoration(border: Border.all(color: Color(0xffE4E6E9))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
           isPath? 'מסלולי למידה':'הקורסים שלי',
            style: TextStyle(fontSize: 32.sp),
          ),
          SizedBox(height: 40.h),
          ListView.builder(
              shrinkWrap: true,
              itemCount: knowledgeList!.length,
              itemBuilder: (context, index) {
                return knowledgeItem(knowledgeList!.elementAt(index));
              })
        ]),
      );
    }
  }

  knowledgeItem(Knowledge knowledge) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 31.h,
              width: 31.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(knowledge.color),
              ),
              child: Image.asset('assets/images/${knowledge.iconPath}.png'),
            ),
            SizedBox(width: 9.w),
            Text(knowledge.title,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18.sp)),
          ],
        ),
        SizedBox(height: 2.h),
        ListView.builder(
            shrinkWrap: true,
            itemCount: knowledge.courses.length,
            itemBuilder: (context, index) {
              return courseItem(knowledge.courses.elementAt(index),
                  knowledge.color, knowledge.iconPath, index);
            }),
        SizedBox(height: 24.h),
      ],
    );
  }

  courseItem(Course course, int color, String icon, int i) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(clipBehavior: Clip.none, alignment: Alignment.center,
              children: [
                Icon(getIconByStatus(course.status), size: 16.w),


                // SizedBox(width: 11.w),

                Positioned(
                    right: 27.w,
                    child: Text(
                        course.title, style: TextStyle(fontSize: 18.sp))),
                //  SizedBox(width: 63.w),
                Positioned(
                    right: 200.w,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(color),
                            borderRadius: BorderRadius.all(
                                Radius.circular(30))),
                        padding: EdgeInsets.only(
                            top: 5.h, bottom: 5.h, left: 9.w, right: 9.w),
                        // width: 35.w,
                        // height: 17.h,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/$icon.png'),
                              SizedBox(width: 15.w),
                              Text(
                                (i + 1).toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: Colors.white),
                              )
                            ])))
              ]),
          displayActionByStatus(course.status)
        ],
      ),);
  }

  getIconByStatus(Status status) {
    switch (status) {
      case Status.start:
        return Icons.circle_outlined;
      case Status.middle:
        return Icons.circle_rounded;
      default:
        return Icons.check_circle_outline;
    }
  }

  displayActionByStatus(Status status) {
    switch (status) {
      case Status.start:
        return statusWidget('','התחל ללמוד');

      case Status.middle:
        return statusWidget('המשך מהמקום שעצרת', 'מילות יחס');
      case Status.finish:
        return statusWidget('הקורס הושלם בהצלחה!', 'סינכרון נתונים');
      case Status.synchronized:
        return statusWidget('נתוני הקורס סונכרנו!', 'להורת התעודה');
    }
  }

  statusWidget(String text, String buttonText) {
    return Row(
        children: [
          if(text != '')Text(text,
              style: TextStyle(fontSize: 13.sp, color: Color(0xff6E7072))),
          if(text != '') SizedBox(width: 7.w),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffACAEAF)),
            ),
            padding: EdgeInsets.only(
                right: 11.w, left: 11.w, top: 5.h, bottom: 5.h),
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 13.sp),
            ),
          )
        ]);
  }

//   aa()async
//   {
// List<User> list=  await IsarService.instance.getUser();
//  print('=======');
//  print(list[0].courses.elementAt(0).title);
//  print(list[0].courses.elementAt(0).knowledge.value?.title??'problem');
//   }
}
