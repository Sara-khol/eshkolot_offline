import 'dart:async';
import 'dart:io';

import 'package:eshkolot_offline/models/knowledge.dart';
import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/models/lesson.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:eshkolot_offline/models/subject.dart';
import 'package:eshkolot_offline/services/installationDataHelper.dart';
import 'package:eshkolot_offline/ui/screens/course_main/main_page_child.dart';
import 'package:eshkolot_offline/ui/screens/main_page/main_page.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../models/course.dart';
import '../../models/user.dart';
import '../../services/isar_service.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<Knowledge, List<Course>> knowledgeCourses = {};
  List<LearnPath> pathList = [];
  bool showMorePath = false;
  bool showMoreKnowledge = false;
  bool enAbleScrollKnowledge = false, enableScrollPath = false;
  final pathScrollController = ScrollController();
  final knowledgeScrollController = ScrollController();
  bool reversed = false;
  late var dir;
  late StreamSubscription stream;

  late int currentColor;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  bool buildCalledYet = false;
  int lastOuterItem = 0;
  int lastInnerItem = 0;

  Widget get positionsView => ValueListenableBuilder<Iterable<ItemPosition>>(
        valueListenable: itemPositionsListener.itemPositions,
        builder: (context, positions, child) {
          int? min;
          int? max;
          if (positions.isNotEmpty) {
            // Determine the first visible item by finding the item with the
            // smallest trailing edge that is greater than 0.  i.e. the first
            // item whose trailing edge in visible in the viewport.
            min = positions
                .where((ItemPosition position) => position.itemTrailingEdge > 0)
                .reduce((ItemPosition min, ItemPosition position) =>
                    position.itemTrailingEdge < min.itemTrailingEdge
                        ? position
                        : min)
                .index;
            // Determine the last visible item by finding the item with the
            // greatest leading edge that is less than 1.  i.e. the last
            // item whose leading edge in visible in the viewport.
            max = positions
                .where((ItemPosition position) => position.itemLeadingEdge < 1)
                .reduce((ItemPosition max, ItemPosition position) =>
                    position.itemLeadingEdge > max.itemLeadingEdge
                        ? position
                        : max)
                .index;
          }
          return Row(
            children: <Widget>[
              Expanded(child: Text('First Item: ${min ?? ''}')),
              Expanded(child: Text('Last Item: ${max ?? ''}')),
              const Text('Reversed: '),
              Checkbox(
                  value: reversed,
                  onChanged: (bool? value) => setState(() {
                        reversed = value!;
                      }))
            ],
          );
        },
      );

  late Future myFuture;

  @override
  initState() {
    debugPrint('initState listen');

    knowledgeCourses = widget.user.knowledgeCoursesMap;
    pathList = widget.user.pathList;
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    VisibilityDetectorController.instance.notifyNow();
    // MainPage
    //     .of(context)
    //     ?.syncUpdate = (){
    //   setState(() {
    //     debugPrint('hhhjjjkkk');
    //   });
    // };
    myFuture=initDirectory();
    stream =
        InstallationDataHelper().eventBusHomePage.on().listen((event) async {
      debugPrint('event listen');
      User user = IsarService().getCurrentUser();
      knowledgeCourses = user.knowledgeCoursesMap;
      if (mounted) {
     //   await initDirectory();
        setState(() {});
      }
    });
    // initDirectory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!buildCalledYet) {
      buildCalledYet = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          showMoreKnowledge =
              knowledgeScrollController.position.maxScrollExtent > 0;
          showMorePath =
              pathScrollController.position.maxScrollExtent > 0;
        });
      });
    }
    return FutureBuilder(
        future: myFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                  padding: EdgeInsets.only(
                      top: 78
                          .h /*, bottom: 160.h*/ /*,right: 132.w,left: 132.w*/),
                  child: Column(
                    children: [
                      Center(
                          child: Text('שלום ${widget.user.name}',
                              style: TextStyle(
                                  color: colors.blackColorApp,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 32.sp))),
                      SizedBox(height: 26.h),
                      Container(
                          height: 51.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: colors.blackColorApp, width: 1.h),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                topInformation(
                                    Icons.check,
                                    'הושלם',
                                    widget.user.courses
                                        .where((c) =>
                                            c.status == Status.synchronized)
                                        .length),
                                Container(
                                    height: 27.h,
                                    width: 1.w,
                                    color: colors.blackColorApp),
                                topInformation(
                                    Icons.refresh,
                                    'ממתין לסינכרון',
                                    widget.user.courses
                                        .where((c) => c.status == Status.finish)
                                        .length),
                                Container(
                                    height: 27.h,
                                    width: 1.w,
                                    color: colors.blackColorApp),
                                topInformation(
                                    Icons.star_outlined,
                                    'תעודות',
                                    widget.user.courses
                                        .where((c) =>
                                            c.status == Status.synchronized)
                                        .length),
                              ])),
                      SizedBox(height: 35.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // children: [myCoursesWidget(),SizedBox(width: 35.w)/*,myCoursesWidget()*/])
                          children: [
                            myCoursesWidget(false),
                            SizedBox(width: 36.w),
                            myCoursesWidget(true)
                          ])
                    ],
                  ),
                ));
          }
          return const CircularProgressIndicator();
        });
  }

  topInformation(IconData iconData, String s, int num) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          width: 14.h,
          height: 14.h,
          margin: EdgeInsets.only(right: 20.w, left: 15.w),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: colors.lightGrey1ColorApp),
          child: Center(child: Icon(iconData, size: 12.sp))),
      Text('$s $num',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
      SizedBox(width: 25.w)
    ]);
  }

  myCoursesWidget(bool isPath) {
    if (knowledgeCourses.isNotEmpty) {
      return Container(
        width: 690.w,
        height: 610.h,
        padding:
            EdgeInsets.only(top: 30.h, right: 42.w, left: 42.w, bottom: 30.h),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffE4E6E9)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isPath ? 'מסלולי למידה' : 'הקורסים שלי',
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: colors.blackColorApp),
            ),
            SizedBox(height: 40.h),
            // positionsView,
            Expanded(
                child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars:
                      isPath ? enableScrollPath : enAbleScrollKnowledge),
              child: (isPath && enableScrollPath) ||
                      (!isPath && enAbleScrollKnowledge)
                  ? Scrollbar(
                      // thickness:  isPath ? (enableScrollPath?8:0) : enAbleScrollKnowledge?8:0,
                      controller: isPath
                          ? pathScrollController
                          : knowledgeScrollController,
                      thumbVisibility: (isPath && enableScrollPath) ||
                          (!isPath && enAbleScrollKnowledge),

                      // child: ScrollConfiguration(
                      //     behavior: ScrollConfiguration.of(context).copyWith(
                      //         scrollbars:
                      //             isPath ? enableScrollPath : enAbleScrollKnowledge),
                      child: mainList(isPath)
                      //  ]),
                      // ),
                      )
                  : mainList(isPath),
            )),
            SizedBox(height: 28.h),
            Visibility(
                visible: isPath
                    ? !enableScrollPath && showMorePath
                    : !enAbleScrollKnowledge && showMoreKnowledge,
                child: GestureDetector(
                  onTap: () => setState(() {
                    //isPath?showMorePath=false:showMoreKnowledge=false;
                    isPath
                        ? enableScrollPath = true
                        : enAbleScrollKnowledge = true;
                  }),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('הצג עוד',
                          style: TextStyle(
                              fontSize: 15.sp, color: Color(0xff6E7072)))),
                ))
          ],
        ),
      );
    }
    return Container();
  }

  mainList(bool isPath) {
    return ListView.builder(
        controller: isPath ? pathScrollController : knowledgeScrollController,
        //   shrinkWrap: true,
        physics: (isPath ? enableScrollPath : enAbleScrollKnowledge)
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),

        /*crossAxisAlignment: CrossAxisAlignment.start, */
        // children: [
        //   ListView.builder(
        shrinkWrap: true,
        itemCount: isPath ? pathList.length : knowledgeCourses.length,
        itemBuilder: (context, index) {
          return VisibilityDetector(
              key: Key(index.toString()),
              onVisibilityChanged: (VisibilityInfo info) {
                if (info.visibleFraction == 1) {
                  setState(() {
                    if (index > lastOuterItem) {
                      lastOuterItem = index;
                      debugPrint('lastOuterItem $lastOuterItem');
                    }
                  });
                }
              },
              child: isPath
                  ? pathItem(pathList[index])
                  : knowledgeItem(
                      knowledgeCourses.keys.elementAt(index), index));
        });
  }

  knowledgeItem(Knowledge knowledge, int kIndex) {
    String path = removeHiddenCharsFromPath(
        '${dir.path}/icons/${knowledge.icon.nameIcon}');
    return Column(
      children: [
        Row(
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
              child: Center(
                  child: SvgPicture.file(
                // File('${dir.path}/icons/${knowledge.icon.nameIcon}'),
                File(path),
                width: 12.w,
                height: 12.h,
              )),

              // child: Center(child: HtmlWidget(knowledge.iconPath)),
            ),
            SizedBox(width: 9.w),
            Text(knowledge.title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: colors.blackColorApp)),
          ],
        ),
        SizedBox(height: 2.h),

        // ScrollablePositionedList.builder(
        //   shrinkWrap: true,
        // itemCount: knowledge.courses.length,
        // itemBuilder: (context, index) => courseItem(knowledge.courses.elementAt(index),
        // knowledge.color, knowledge.iconPath, index),
        // itemScrollController: itemScrollController,
        // itemPositionsListener: itemPositionsListener,
        // ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: knowledgeCourses.values.elementAt(kIndex).length,
            itemBuilder: (context, index) {
              // return VisibilityDetector(
              //     key: Key(index.toString()),
              //     onVisibilityChanged: (VisibilityInfo info) {
              //       if (mounted) {
              //         setState(() {
              //           knowledge.courses.elementAt(index).isFullyDisplayed =
              //               info.visibleFraction == 1;
              //         });
              //       }
              //       // var visiblePercentage = info.visibleFraction * 100;
              //       // debugPrint(
              //       //     'Widget ${info.key} is ${visiblePercentage}% visible');
              //       // if (info.visibleFraction == 1) {
              //       //   setState(() {
              //       //     if (index > lastInnerItem) {
              //       //       lastInnerItem = index;
              //       //       print('lastInnerItem $lastInnerItem');
              //       //       print('kIndex $kIndex');
              //       //     }
              //       //   });
              //       // }
              //     },
              //     child:
              //     // Visibility(
              //     //     visible: enAbleScrollKnowledge ||
              //     //         knowledge.courses.elementAt(index).isFullyDisplayed,
              //     //     child:
              currentColor = knowledge.icon.color != ''
                  ? int.parse(knowledge.icon.color)
                  : -1;
              return courseItem(
                  knowledgeCourses.values.elementAt(kIndex)[index],
                  currentColor,
                  knowledge.icon.nameIcon,
                  index);
            }),
        SizedBox(height: 24.h),
      ],
    );
  }

  String removeHiddenCharsFromPath(String path) {
    // Replace all whitespace characters with empty strings
    path = path.replaceAll(RegExp(r'\s+'), '');

    // You can add more specific replacements here for other hidden characters if needed.
    return path;
  }

  initDirectory() async {
    dir = await getApplicationSupportDirectory();
    return dir;
  }

  pathItem(LearnPath path) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
                height: 9.h,
                width: 9.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffFFDA6C),
                )),
            SizedBox(width: 11.w),
            Text(path.title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: colors.blackColorApp)),
          ],
        ),
        SizedBox(height: 2.h),
        ListView.builder(
            shrinkWrap: true,
            itemCount: path.courses.length,
            itemBuilder: (context, index) {
              Knowledge courseKnowledge = knowledgeCourses.keys.firstWhere(
                  (k) => k.id == path.courses.elementAt(index).knowledgeId);

              currentColor = courseKnowledge.icon.color != ''
                  ? int.parse(courseKnowledge.icon.color)
                  : -1;
              return courseItem(
                  path.courses.elementAt(index),
                  currentColor,
                  courseKnowledge.icon.nameIcon,
                  /*path.color.isNotEmpty ? int.parse(path.color) : -1*/
                  index);
            }),
        SizedBox(height: 24.h),
      ],
    );
  }

  courseItem(Course course, int color, String icon, int i) {
    String path = removeHiddenCharsFromPath('${dir.path}/icons/${icon}');
    UserCourse? userCourse = IsarService().getUserCourseData(course.id);

    return Container(
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h /*,left: 10*/),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.lightGrey1ColorApp)),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          debugPrint('1212');
          MainPage.of(context)?.mainWidget = MainPageChild(
            course: course,
            knowledgeColor: color,
          );
          if (MainPage.of(context)?.updateSideMenu != null) {
            MainPage.of(context)?.updateSideMenu!(course.id);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  getIconByStatus(userCourse!.status),
                  // SizedBox(width: 12.w),

                  Positioned(
                      right: 32.w,
                      child: Text('${course.title}',
                          style: TextStyle(
                              fontSize: 18.sp, color: colors.blackColorApp))),
                  //  SizedBox(width: 63.w),
                  Positioned(
                      right: 200.w,
                      child: Container(
                          decoration: BoxDecoration(
                              color: color != -1 ? Color(color) : Colors.indigo,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          padding: EdgeInsets.only(
                              top: 5.h, bottom: 5.h, left: 9.w, right: 9.w),
                          // width: 35.w,
                          // height: 17.h,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // icon.isNotEmpty? HtmlWidget(icon):Container(),
                                if (icon != '')
                                  Center(
                                      child: SvgPicture.file(
                                    File(path),
                                    width: 9.w,
                                    height: 9.h,
                                  )),
                                SizedBox(width: 15.w),
                                Text(
                                  '${course.knowledgeNum}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp,
                                      color: Colors.white),
                                )
                              ])))
                ]),
            displayActionByStatus(userCourse.status, course,color)
          ],
        ),
      ),
    );
  }

  getIconByStatus(Status status) {
    switch (status) {
      case Status.start:
        return Container(
            width: 15.h,
            height: 15.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: colors.lightGrey1ColorApp, width: 3.sp)));
      //return Icon(Icons.circle_outlined,color: colors.lightGrey1ColorApp,size: 20.sp,);
      case Status.middle:
        return Image.asset('assets/images/procces_circle.png');
      default:
        return Icon(Icons.check_circle,
            color: colors.lightGreen1ColorApp, size: 22.sp);
      /*Container(
          width: 15.h,
          height: 15.h,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xff62FFB8)),
          child: Center(
              child: Icon(Icons.check, color: Colors.white, size: 12.sp)),
        )*/
    }
  }

  displayActionByStatus(Status status, Course course,int color) {
    switch (status) {
      case Status.start:
        return statusWidget('', 'התחל ללמוד', course,color);

      case Status.middle:
        return FutureBuilder<String>(
            future: getLastPositionInCourse(course),
            builder: (c, s) {
              if (s.hasData) {
                if (s.data!.isNotEmpty) {
                  return statusWidget(
                      'המשך מהמקום שעצרת', s.data ?? '', course,color, true);
                }
                return statusWidget('', 'המשך', course,color, false);

              }
              return const CircularProgressIndicator();
            });

      case Status.finish:
        return statusWidget('הקורס הושלם בהצלחה!', 'סינכרון נתונים', course,color);
      case Status.synchronized:
        return statusWidget('נתוני הקורס סונכרנו!', 'להורת התעודה', course,color);
    }
  }

  statusWidget(String text, String buttonText, Course course,int color,
      [bool isContinue = false]) {
    return Row(children: [
      if (text != '')
        Text(text, style: TextStyle(fontSize: 14.sp, color: Color(0xff6E7072))),
      if (text != '') SizedBox(width: 7.w),
      GestureDetector(
        child: Container(
          constraints: BoxConstraints(maxWidth: 130.w), // Set your maximum width
          decoration: BoxDecoration(
              color: colors.lightGrey1ColorApp,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          padding:
              EdgeInsets.only(right: 11.w, left: 11.w, top: 5.h, bottom: 5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    buttonText,
                   overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.sp, color: colors.blackColorApp),
                  ),
                ),
              ),
             // SizedBox(width: 3.w),
              Icon(Icons.arrow_forward, size: 14.sp),
            ],
          ),
        ),
        onTap: () {
          if (MainPage.of(context)?.updateSideMenu != null) {
            MainPage.of(context)?.updateSideMenu!(course.id);
          }
          if (isContinue && course.userCourse != null) {
            if (!course.userCourse!.isQuestionnaire) {
              MainPage.of(context)?.mainWidget = MainPageChild(
                course: course,
                knowledgeColor: currentColor,
                lessonPickedIndex: course.userCourse!.lessonIndex,
                subjectPickedIndex: course.userCourse!.subjectIndex,
                isContinue: 1,
              );
            } else {
              MainPage.of(context)?.mainWidget = MainPageChild(
                course: course,
                knowledgeColor: currentColor,
                lessonPickedIndex: course.userCourse!.lessonIndex,
                subjectPickedIndex: course.userCourse!.subjectIndex,
                questionPickedIndex: course.userCourse!.questionIndex,
                isContinue: 2,
              );

            }
          }
          else{
            MainPage.of(context)?.mainWidget = MainPageChild(
              course: course,
              knowledgeColor: color,
            );
          }
        },
      )
    ]);
  }

  Future<String> getLastPositionInCourse(Course course,
      {bool refresh = true}) async {
    // debugPrint('getLastPositionInCourse');
    UserCourse? data = IsarService().getUserCourseData(course.id);
    Subject? lastSubject;
    Quiz? lastQuestionnaire;
    Lesson? lastLesson;
    String lastTextButton = '';
    if (data != null &&
        (data.subjectStopId != 0 ||
            data.lessonStopId != 0 ||
            data.questionnaireStopId != 0)) {
      if (data.subjectStopId != 0) {
        for (int i = 0; i < course.subjects.length; i++) {
          if (course.subjects.elementAt(i).subjectId == data.subjectStopId) {
            lastSubject = course.subjects.elementAt(i);
            data.subjectIndex = i;
            break;
          }
        }
      } else {
        lastSubject = null;
      }

      // lastSubject =
      // data!.subjectStopId != 0 ? widget.course.subjects.firstWhere((s) =>
      // s.id == data!.subjectStopId) : null;
      if (data.lessonStopId != 0) {
        for (int i = 0; i < lastSubject!.lessons.length; i++) {
          if (lastSubject.lessons.elementAt(i).lessonId == data.lessonStopId) {
            lastLesson = lastSubject.lessons.elementAt(i);
            data.lessonIndex = i;
            break;
          }
        }
      } else {
        lastLesson = null;
      }

      if (!data.isQuestionnaire) {
        lastTextButton = lastLesson!.name;
      } else {
        if (data.subjectStopId == 0) {
          //questionnaire of course
          //lastQuestionnaire = widget.course.questionnaires.firstWhere((q) => q.id==data!.questionnaireStopId);

          for (int i = 0; i < course.questionnaires.length; i++) {
            if (course.questionnaires.elementAt(i).id ==
                data.questionnaireStopId) {
              lastQuestionnaire = course.questionnaires.elementAt(i);
              data.questionIndex = i;
              break;
            }
          }
        } else if (data.lessonStopId == 0) {
          //questionnaire of subject
          // lastQuestionnaire = lastSubject!.questionnaire.firstWhere((q) => q.id==data!.questionnaireStopId);

          for (int i = 0; i < lastSubject!.questionnaire.length; i++) {
            if (lastSubject.questionnaire.elementAt(i).id ==
                data.questionnaireStopId) {
              lastQuestionnaire = lastSubject.questionnaire.elementAt(i);
              data.questionIndex = i;
              break;
            }
          }
        } else {
          //questionnaire of lesson
          // lastQuestionnaire = lastLesson!.questionnaire.firstWhere((q) => q.id==data!.questionnaireStopId);

          for (int i = 0; i < lastLesson!.questionnaire.length; i++) {
            if (lastLesson.questionnaire.elementAt(i).id ==
                data.questionnaireStopId) {
              lastQuestionnaire = lastLesson.questionnaire.elementAt(i);
              data.questionIndex = i;
              break;
            }
          }
        }
        lastTextButton = lastQuestionnaire!.title;
      }
    }
    // }

    course.userCourse = data;
    course.lastLesson = lastLesson;
    course.lastSubject = lastSubject;
    course.lastQuestionnaire = lastQuestionnaire;

    return lastTextButton;
  }

  @override
  void dispose() {
    pathScrollController.dispose();
    knowledgeScrollController.dispose();
    stream.cancel();
    super.dispose();
  }
}
