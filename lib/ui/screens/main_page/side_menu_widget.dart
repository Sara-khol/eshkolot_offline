import 'dart:async';

import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/ui/screens/course_main/main_page_child.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/course.dart';
import '../../../models/knowledge.dart';
import '../../../models/learn_path.dart';
import '../../../services/installationDataHelper.dart';
import '../../../services/isar_service.dart';
import '../home_page.dart';
import '../how_to_learn.dart';
import 'main_page.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;
import 'package:collection/collection.dart';

class SideMenuWidget extends StatefulWidget {
  final User myUser;

  SideMenuWidget({super.key, required this.myUser});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int sIndex = 1;
  Course? lastCourseSelected;
  late StreamSubscription stream;

  late List<LearnPath> pathList;
  late List<Knowledge> knowledgeList;
  Map<Knowledge, List<Course>> knowledgeCourses = {};

  @override
  void initState() {
    super.initState();
    knowledgeCourses = widget.myUser.knowledgeCoursesMap;
    pathList = widget.myUser.pathList;

    stream = InstallationDataHelper().eventBusSideMenu.on().listen((event) async {
      debugPrint('eventBusSideMenu');
      User user = IsarService().getCurrentUser();
      knowledgeCourses = user.knowledgeCoursesMap;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    MainPage.of(context)?.updateSideMenu = updateByOuterEvent;
    super.didChangeDependencies();
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
            padding: EdgeInsets.only(right: 20.w, left: 20.w),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/images/eshkolot_icon.png'),
                SizedBox(width: 6.w),
                Text('אשכולות',
                    style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                const Spacer(),
                Image.asset('assets/images/menu_icon.png'),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          GestureDetector(
            onTap: () {
              setState(() {
                MainPage.of(context)?.mainWidget =
                    HomePage(user: widget.myUser);
                sIndex = 1;
              });
            },
            child: Container(
                height: 30.h,
                margin: EdgeInsets.only(right: 10.w, left: 10.w),
                decoration: BoxDecoration(
                    color: sIndex == 1
                        ? const Color(0xff403C3C)
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(52))),
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
                )),
          ),
          SizedBox(
            height: 8.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                MainPage.of(context)?.mainWidget = const HowToLearn();
                sIndex = 2;
              });
            },
            child: Container(
                height: 30.h,
                margin: EdgeInsets.only(right: 10.w, left: 10.w),
                decoration: BoxDecoration(
                    color: sIndex == 2
                        ? const Color(0xff403C3C)
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(52))),
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
          Divider(height: 1.h, color: colors.grey1ColorApp),
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
                      itemCount: knowledgeCourses.length,
                      itemBuilder: (context, index) {
                        return knowledgeItem(
                            knowledgeCourses.keys.elementAt(index), index);
                      }),
                  SizedBox(height: 31.h),
                  Divider(height: 1.h, color: colors.grey1ColorApp),
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
          Divider(height: 1.h, color: colors.grey1ColorApp),
          SizedBox(
            height: 70.h,
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 24.w),
                    child: const Icon(Icons.question_mark,
                        color: Color(0xffC8C9CE))),
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

  knowledgeItem(Knowledge knowledge, int kIndex) {
    List<Course> courses = knowledgeCourses.values.elementAt(kIndex);
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              knowledge.isOpen = !knowledge.isOpen;
              if (knowledge.isOpen) {
                //make first course chosen
                MainPage.of(context)?.mainWidget = MainPageChild(
                    course: courses.first,
                    knowledgeColor: knowledge.icon.color != ''
                        ? int.parse(knowledge.icon.color)
                        : -1);
                courses.first.isSelected = true;
                sIndex = 0;
                //for first time
                if (lastCourseSelected != null &&
                    lastCourseSelected != courses.first) {
                  lastCourseSelected!.isSelected = false;
                }
                lastCourseSelected = courses.first;
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
                    color: knowledge.icon.color != ''
                        ? Color(int.parse(knowledge.icon.color))
                        : Colors.indigo,
                  ),
                  // child: Image.asset('assets/images/${knowledge.iconPath}.png'),
                  // child: Center(child: HtmlWidget(knowledge.iconPath)),
                  child: Center(
                    child: Image.asset('assets/images/english.png'),
                  ),
                ),
                SizedBox(width: 12.w),
                Text('${knowledge.title} (${courses.length})',
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
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return courseItem(
                    knowledgeCourses.values.elementAt(kIndex)[index],
                    knowledge.icon.color != ''
                        ? int.parse(knowledge.icon.color)
                        : -1,
                    knowledge.iconPath ?? '',
                    index);
              }),
        ),
        SizedBox(height: 24.h)
      ],
    );
  }

  courseItem(Course course, int color, String icon, int cIndex) {
    return Container(
      margin: EdgeInsets.only(top: 6.h, bottom: 6.h, right: 10.w, left: 10.w),
      padding: EdgeInsets.only(top: 7.h, bottom: 7.h, right: 12.w, left: 12.w),
      // padding: EdgeInsets.only(right: 21.w, left: 19.w),

      // color:selectedIndex=='$topIndex,$cIndex'? Color(0xFF6E7072):Colors.transparent ,
      decoration: BoxDecoration(
          color: course.isSelected && sIndex == 0
              ? const Color(0xff403C3C)
              : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(52))),

      child: GestureDetector(
        onTap: () {
          setState(() {
            MainPage.of(context)?.mainWidget =
                MainPageChild(course: course, knowledgeColor: color);
            selectCourse(course);
          });
          //}
        },
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // clipBehavior: Clip.none,
            // alignment: Alignment.center,
            children: [
              SizedBox(
                width: 110.w,
                child: Text(course.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16.sp, color: Colors.white)),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                  // width: 35.w,
                  // height: 17.h,
                  width: 45.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                      color: color != -1 ? Color(color) : Colors.indigo,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  // margin: EdgeInsets.only(left: 15.w),
                  // padding: EdgeInsets.only(
                  //     top: 5.h, bottom: 5.h, left: 9.w, right: 9.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset('assets/images/$icon.png'),
                        // icon.isNotEmpty? HtmlWidget(icon):Container(),
                        Image.asset('assets/images/english.png'),

                        SizedBox(width: 7.w),
                        Text(
                          (cIndex + 1).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Colors.white),
                        )
                      ]))
              // )
            ]),
      ),
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
              MainPage.of(context)?.mainWidget = MainPageChild(
                  course: path.courses.first,
                  knowledgeColor:
                      path.color.isNotEmpty ? int.parse(path.color) : -1);
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 9.h,
                    width: 9.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffFFDA6C),
                      // color:path.color.isNotEmpty? Color(int.parse(path.color)):Colors.indigo,
                    )),
                SizedBox(width: 12.w),
                Text(path.title,
                    style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                const Spacer(),
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
                return courseItem(
                    path.courses.elementAt(index),
                    path.color.isNotEmpty ? int.parse(path.color) : -1,
                    path.iconPath ?? '',
                    index);
              }),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  selectCourse(Course course) {
    course.isSelected = true;
    sIndex = 0;
    //for first time
    if (lastCourseSelected != null && lastCourseSelected != course) {
      lastCourseSelected!.isSelected = false;
    }
    lastCourseSelected = course;
  }

  updateByOuterEvent(int courseId) {
    sIndex = 0;
    debugPrint('courseId $courseId');
    setState(() {
      Course? selectedCourse;
      for (var entry in knowledgeCourses.entries) {
        //  Knowledge knowledge = entry.key;
        List<Course> courses = entry.value;
        selectedCourse =
            courses.firstWhereOrNull((element) => element.id == courseId);
        if (selectedCourse != null) {
          selectCourse(selectedCourse);
          break;
        }
      }
      if (selectedCourse == null) {
        for (LearnPath path in pathList) {
          selectedCourse = path.courses
              .firstWhereOrNull((element) => element.id == courseId);
          if (selectedCourse != null) {
            selectCourse(selectedCourse);
            break;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }
}
