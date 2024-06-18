import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/ui/screens/main_page/side_menu_widget.dart';
import 'package:eshkolot_offline/ui/screens/main_page/title_bar_widget.dart';
import 'package:eshkolot_offline/ui/screens/main_page/top_bar_user_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/course.dart';
import '../home_page.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.user});

  final User user;

  @override
  State<MainPage> createState() => _MainPageState();

  static _MainPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainPageState>();
}

class _MainPageState extends State<MainPage> {
  late Widget _mainWidget;
  late List<Widget> menuWidgets;
  Course? lastCourseSelected;
  int coursesIndex = 0;
  void Function()? updateLastPosition;
  bool isOpenMenu = true;

  //void Function()? updateSync;
  void Function(int)? updateSideMenu;

  set mainWidget(Widget value) => setState(() => _mainWidget = value);

  get getMainWidget {
    return _mainWidget;
  }

  set setUpdate(Function()? value) {
    Future.delayed(Duration.zero, () async {
      setState(() {
        updateLastPosition = value;
      });
    });
  }

  // set syncUpdate(Function()? value) {
  //   Future.delayed(Duration.zero, () async {
  //     setState(() {
  //       updateSync = value;
  //     });
  //   });
  // }

  @override
  void initState() {
    _mainWidget = HomePage(user: widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colors.blackColorApp,//to remove a little line on top of menu
        body: Column(children: [
          TitleBarWidget(updateLastPosition: updateLastPosition),
          Container(
            height: 65.h,
            color: colors.blackColorApp,
            child: Row(
              children: [
                Container(
                  width: 240.w,
                  height: double.infinity,
                  padding: EdgeInsets.only(right: 20.w, left: 20.w),
                  decoration:   BoxDecoration(
                     color: colors.blackColorApp,
                    border: Border(bottom: BorderSide( color:isOpenMenu?colors.blackColorApp: Color(0xffDCDDE1))),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/images/eshkolot_menu_icon.png',
                          height: 24.h),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isOpenMenu = !isOpenMenu;
                            });
                          },
                          child: Image.asset('assets/images/menu_icon.png')),
                    ],
                  ),
                ),
                const Expanded(child: TopBarUserWidget()),
              ],
            ),
          ),
          Expanded(
              child: Row(children: [
            Visibility(
              visible: isOpenMenu,
              maintainState: true,
              child: SideMenuWidget(myUser: widget.user),
            ),
            Expanded(child: /*Column(children: [Expanded(child:*/ _mainWidget/*)])*/)
          ]))
        ]),
      ),
    );
  }
}
