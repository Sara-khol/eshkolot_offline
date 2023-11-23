import 'package:eshkolot_offline/models/user.dart';
import 'package:eshkolot_offline/ui/screens/main_page/side_menu_widget.dart';
import 'package:eshkolot_offline/ui/screens/main_page/title_bar_widget.dart';
import 'package:eshkolot_offline/ui/screens/main_page/top_bar_user_widget.dart';
import 'package:flutter/material.dart';
import '../../../models/course.dart';
import '../home_page.dart';



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
  //void Function()? updateSync;
  void Function(int)? updateSideMenu;


  set mainWidget(Widget value) => setState(() => _mainWidget = value);

  get getMainWidget {return _mainWidget;}


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
  void initState()  {
    _mainWidget = HomePage(user: widget.user);
 // syncUpdate = (){
 //      setState(() {
 //        debugPrint('hhhfff');
 //      });
 //    };
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
              const TopBarUserWidget(/*updateLastPosition: updateSync!*/),
              Expanded(child: _mainWidget)
            ]))
          ]))
        ]),
      ),
    );
  }

}
