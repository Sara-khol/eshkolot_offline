import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/ui/screens/course_main/main_page_child.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/course.dart';
import '../../../models/knowledge.dart';
import '../../../models/learn_path.dart';
import '../home_page.dart';
import 'main_page.dart';

class SideMenuWidget extends StatefulWidget {
  final User myUser;

  SideMenuWidget({super.key, required this.myUser});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int sIndex = 0;
  Course? lastCourseSelected;

  late List<LearnPath> pathList;
  late List<Knowledge> knowledgeList;

  @override
  void initState() {
    super.initState();
    knowledgeList = widget.myUser.knowledgeList;
    pathList = widget.myUser.pathList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.w,
      height: double.infinity,
      padding: EdgeInsets.only(top: 27.h),
      color: const Color(0xff2D2828),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('אשכולות',
                    style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                Icon(Icons.menu_open_sharp, color: Colors.white),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Container(
              height: 30.h,
              color: sIndex == 1 ? Color(0xFF6E7072) : Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    MainPage.of(context)?.mainWidget =
                        HomePage(user: widget.myUser);
                    sIndex = 1;
                  });
                },
                child: Row(
                  children: [
                    SizedBox(width: 21.w),
                    Image.asset(
                      'assets/images/home.png',
                      height: 17.h,
                    ),
                    SizedBox(width: 10.5.w),
                    Text('בית',
                        style: TextStyle(color: Colors.white, fontSize: 18.sp))
                  ],
                ),
              )),
          SizedBox(
            height: 8.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                sIndex = 2;
              });
            },
            child: Container(
                height: 30.h,
                color: sIndex == 2 ? Color(0xFF6E7072) : Colors.transparent,
                child: Row(
                  children: [
                    SizedBox(width: 21.w),
                    Image.asset('assets/images/learn.png', height: 17.h),
                    SizedBox(width: 10.5.w),
                    Text('איך לומדים כאן',
                        style: TextStyle(color: Colors.white, fontSize: 18.sp))
                  ],
                )),
          ),
          SizedBox(height: 34.h),
          Divider(height: 1.h, color: Color(0xff6E7072)),
          SizedBox(height: 17.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        right: 21.w,
                        bottom: 23.h,
                      ),
                      child: Text(
                        'הקורסים שלי',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: knowledgeList.length,
                      itemBuilder: (context, index) {
                        return knowledgeItem(knowledgeList[index]);
                      }),
                  SizedBox(height: 31.h),
                  Divider(height: 1.h, color: Color(0xff6E7072)),
                  if (pathList.isNotEmpty) ...[
                    Padding(
                        padding: EdgeInsets.only(
                            right: 21.w, bottom: 30.h, top: 21.h),
                        child: Text(
                          'מסלולי למידה',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: pathList.length,
                        itemBuilder: (context, index) {
                          return pathItem(pathList[index], index);
                        }),
                  ],
                  //  Spacer(),
                ],
              ),
            ),
          ),
          Divider(height: 1.h, color: Color(0xff6E7072)),
          SizedBox(
            height: 70.h,
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 24.w),
                    child: Icon(Icons.question_mark, color: Color(0xffC8C9CE))),
                Text(
                  'צריך עזרה ?',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp,
                      color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  knowledgeItem(Knowledge knowledge) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              knowledge.isOpen = !knowledge.isOpen;
              if (knowledge.isOpen) {
                //make first course chosen
                MainPage.of(context)?.mainWidget =
                    MainPageChild(course: knowledge.courses.first);
                knowledge.courses.first.isSelected = true;
                sIndex = 0;
                //for first time
                if (lastCourseSelected != null &&
                    lastCourseSelected != knowledge.courses.first) {
                  lastCourseSelected!.isSelected = false;
                }
                lastCourseSelected = knowledge.courses.first;
              }
            });
          },
          child: Padding(
            padding: EdgeInsets.only(right: 21.w, left: 19.w),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                SizedBox(width: 12.w),
                Text('${knowledge.title} (${knowledge.courses.length})',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                const Spacer(),
                // Icon(Icons.keyboard_arrow_up,color: Colors.white,size: 10.h,),
                SizedBox(
                    width: 6.w,
                    height: 6.5.h,
                    child: Image.asset(
                        knowledge.isOpen
                            ? 'assets/images/arrow_up.png'
                            : 'assets/images/arrow_down.png',
                        fit: BoxFit.contain)),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Visibility(
          visible: knowledge.isOpen,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: knowledge.courses.length,
              itemBuilder: (context, index) {
                return courseItem(knowledge.courses.elementAt(index),
                    knowledge.color, knowledge.iconPath, index);
              }),
        ),
        SizedBox(height: 24.h)
      ],
    );
  }

  courseItem(Course course, int color, String icon, int cIndex) {
    return Container(
      margin: EdgeInsets.only(top: 6.h, bottom: 6.h),
      padding: EdgeInsets.only(top: 4.h, bottom: 4.h, right: 21.w, left: 19.w),
      // padding: EdgeInsets.only(right: 21.w, left: 19.w),

      // color:selectedIndex=='$topIndex,$cIndex'? Color(0xFF6E7072):Colors.transparent ,
      color: course.isSelected && sIndex == 0
          ? Color(0xFF6E7072)
          : Colors.transparent,
      // width: 150.w,
      // height:100,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // clipBehavior: Clip.none,
          // alignment: Alignment.center,
          children: [
            Flexible(
              flex: 2,
              child: GestureDetector(
                onTap: () => setState(() {
                  MainPage.of(context)?.mainWidget = MainPageChild(course: course);
                  course.isSelected = true;
                  sIndex = 0;
                  //for first time
                  if (lastCourseSelected != null &&
                      lastCourseSelected != course) {
                    lastCourseSelected!.isSelected = false;
                  }
                  lastCourseSelected = course;
                }),
                child: Text(course.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16.sp, color: Colors.white)),
              ),
            ),
            // SizedBox(
            //   width: 15.w,
            // ),
            Flexible(
              flex: 1,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(color),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  // margin: EdgeInsets.only(left: 15.w),
                  padding: EdgeInsets.only(
                      top: 5.h, bottom: 5.h, left: 9.w, right: 9.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/$icon.png'),
                        SizedBox(width: 10.w),
                        Text(
                          (cIndex + 1).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Colors.white),
                        )
                      ])),
            )
            // )
          ]),
    );
  }

  pathItem(LearnPath path, int pIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => setState(() {
            path.isOpen = !path.isOpen;
            if (path.isOpen) {
             MainPage.of(context)?.mainWidget= MainPageChild(course: path.courses.first);
              path.courses.first.isSelected = true;
              sIndex = 0;
              //for first time
              if (lastCourseSelected != null &&
                  lastCourseSelected != path.courses.first) {
                lastCourseSelected!.isSelected = false;
              }
              lastCourseSelected = path.courses.first;
            }
          }),
          child: Padding(
            padding: EdgeInsets.only(right: 22.w, left: 19.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(path.title,
                    style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                SizedBox(
                    width: 6.w,
                    height: 6.5.h,
                    child: Image.asset(
                        path.isOpen
                            ? 'assets/images/arrow_up.png'
                            : 'assets/images/arrow_down.png',
                        fit: BoxFit.contain)),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Visibility(
          visible: path.isOpen,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: path.courses.length,
              itemBuilder: (context, index) {
                return courseItem(path.courses.elementAt(index), path.color,
                    path.iconPath, index);
              }),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
