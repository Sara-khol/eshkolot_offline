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
      child: Container(
        width: 950.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Color(0xFFE4E6E9))
        ),
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.create,size: 30.w),
                  SizedBox(width: 23.w,),
                  Text(widget.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 36.sp)),
                  SizedBox(width: 30.w,),
                  Icon(Icons.access_time_outlined,size: 15.sp,),
                  Text("  30 דק' ",style: TextStyle(fontSize: 16.sp)),
                  Spacer(),
                  Container(
                    height: 20.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        color: Color(0xFF62FFB8),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: TextButton(
                      onPressed: () async {
                        /*if (!lesson.isCompleted) {
                          lesson.isCompleted = true;
                          print('pressed id ${lesson.id}');
                          await IsarService.instance.updateLesson(lesson.id);
                          setState(() {
                          });
                        }*/
                      },
                      child: Text(
                        '  הושלם  ',
                        style: TextStyle(fontSize: 13.sp, color: Colors.white),
                      ),
                    ),

                  ),
                ],
              ),
              SizedBox(height: 17.h,),
              Row(
                children: [
                  Image.asset('assets/images/hand.jpg'),
                  Text("  בשאלון זה מומלץ להעזר בלשונית 'חומרי למידה'",style: TextStyle(fontSize: 18.sp))
                ],
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
                        Icon(Icons.create_outlined, size: 22.sp,),
                        Text('  שאלון ',style: TextStyle(fontSize: 22.sp))
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(Icons.folder_outlined ,size: 22.sp,),
                        Text('  חומרי למידה',style: TextStyle(fontSize: 22.sp))
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
      ),
    );

  }

  initialDisplay()
  {
    return Column(
        children: [
          SizedBox(height: 43.h),
          widget.questionnaires.isNotEmpty?    Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 40.h,
              width: 171.w,
              decoration: BoxDecoration(
                  color: Color(0xFFF4F4F3),
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  alignment: Alignment.center,
                  foregroundColor: Colors.black,
                  //padding: EdgeInsets.only(left: 45.w,right: 45.w,top: 20.h,bottom: 22.h),
                  textStyle: TextStyle(fontSize: 20.sp),
                ),
                onPressed: () {
                  setState(() {
                    displayWidget=QuestionnaireTab(questionnaire: widget.questionnaires);
                  });
                },
                child: Row(
                  children: [
                    Text(' התחל שאלון ', style: TextStyle(fontSize: 20.sp,color: Color(0xFF2D2828),fontFamily: 'RAG-Sans')),
                    Icon(Icons.arrow_forward,size: 15.sp,color: Color(0xFF2D2828),)
                  ],
                ),
              ),
            ),
          ):Text('לא נמצאו שאלונים',  style: TextStyle(fontSize: 22.h)),
        ]);
  }
}


