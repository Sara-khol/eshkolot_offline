import 'package:eshkolot_offline/models/learn_path.dart';
import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/ui/screens/main_page/side_menu_widget.dart';
import 'package:eshkolot_offline/ui/screens/main_page/title_bar_widget.dart';
import 'package:eshkolot_offline/ui/screens/main_page/top_bar_user_widget.dart';
import 'package:flutter/material.dart';
import '../../../models/course.dart';
import '../../../models/knowledge.dart';
import '../home_page.dart';

typedef void changeMainWidget(Widget mainWidget);

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.user});

  final User user;

  @override
  State<MainPage> createState() => _MainPageState();

  static _MainPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainPageState>();
}

class _MainPageState extends State<MainPage> {
  late List<Knowledge> knowledgeList = [];
  late List<LearnPath> pathList = [];

  late Widget _mainWidget;
  late List<Widget> menuWidgets;
  Course? lastCourseSelected;
  int coursesIndex = 0;
  void Function()? updateLastPosition;
  void Function(int)? updateSideMenu;


  set mainWidget(Widget value) => setState(() => _mainWidget = value);

  set setUpdate(Function()? value) {
    Future.delayed(Duration.zero, () async {
      setState(() {
        updateLastPosition = value;
      });
    });
  }


  @override
  void initState() {
    knowledgeList = widget.user.knowledgeList;
    pathList = widget.user.pathList;
    _mainWidget = HomePage(user: widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          TitleBarWidget(updateLastPosition: updateLastPosition),
          Expanded(
              child: Row(children: [
            SideMenuWidget(myUser: widget.user),
            Expanded(
                child: Column(children: [
              TopBarUserWidget(),
              Expanded(child: _mainWidget)
            ]))
          ]))
        ]),
      ),
    );
  }

}
