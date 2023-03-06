import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:eshkolot_offline/ui/screens/course_main/questionnaire_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class QuestionnaireWidget extends StatefulWidget {
  final IsarLinks<Questionnaire> questionnaires;
  final String title;
  const QuestionnaireWidget({super.key, required this.questionnaires, required this.title});

  @override
  State<QuestionnaireWidget> createState() => _QuestionnaireWidgetState();
}

class _QuestionnaireWidgetState extends State<QuestionnaireWidget> with TickerProviderStateMixin {

  late Widget displayWidget;
  late TabController _tabController1;
  ScrollController scrollController= ScrollController();

  @override
  void initState() {
    displayWidget=initialDisplay();
    _tabController1 = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant QuestionnaireWidget oldWidget) {
    displayWidget=initialDisplay();
    scrollController.jumpTo(scrollController.position.minScrollExtent);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _tabController1.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.only(/*top: 100.h,right: 210.w,*/left: 360.w,bottom: 60.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: Row(
                children: [
                  Icon(Icons.create,size: 30.w),
                  Padding(padding: EdgeInsets.only(left: 11.w,right: 14.w),
                    child: Text(widget.title, style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, fontSize: 36.w)),
                  ),
                  Icon(Icons.access_time_outlined,size: 22.w,),
                  const Text('30min')
                ],
              ),
            ),

            TabBar(
              labelColor: const Color.fromARGB(255,45, 40, 40),
              unselectedLabelColor: const Color.fromARGB(255,172, 174, 175),
              indicatorColor: const Color.fromARGB(255,45, 40, 40),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3.0,
              indicatorPadding: EdgeInsets.only(bottom: 2.h),
              labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              controller: _tabController1,
              tabs: [
                Tab(
                  child: Row(
                    children:  [
                      const FaIcon(FontAwesomeIcons.file),
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: const Text('שאלון'),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      const Icon(Icons.folder_outlined),
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: const Text('חומרי למידה'),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                controller: _tabController1,
                children: <Widget>[
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 27.h, bottom: 50),
                        child: Row(
                          children: [
                            const FaIcon(FontAwesomeIcons.handPointLeft),
                            Text('בשאלון זה מומלץ להעזר בלשונית "חומרי למידה"',style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 18.w))
                          ],
                        ),
                      ),
                      displayWidget
                    ],
                  ),
                  Text('חומרי למידה'),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

  initialDisplay()
  {
    return Column(
        children: [
          SizedBox(height: 40.h,width: 176.w,),
          widget.questionnaires.isNotEmpty?    Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black)
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  alignment: Alignment.center,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.only(left: 45.w,right: 45.w,top: 20.h,bottom: 22.h),
                  textStyle: TextStyle(fontSize: 22.h,fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  setState(() {
                    displayWidget=QuestionnaireTab(questionnaire: widget.questionnaires);
                  });
                },
                child: Text('התחל שאלון', style: TextStyle(fontSize: 22.w)),
              ),
            ),
          ):Text('לא נמצאו שאלונים',  style: TextStyle(fontSize: 22.h,fontWeight: FontWeight.w400)),
        ]);
  }
}


