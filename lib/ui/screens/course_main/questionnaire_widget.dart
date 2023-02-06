import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/fill_in_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/free_choice_widget.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/open_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../question-widgets/radio_check_widget.dart';

class QuestionnaireWidget extends StatefulWidget {
  final IsarLinks<Questionnaire> questionnaires;

  const QuestionnaireWidget({super.key, required this.questionnaires});

  @override
  State<QuestionnaireWidget> createState() => _QuestionnaireWidgetState();
}

class _QuestionnaireWidgetState extends State<QuestionnaireWidget> with TickerProviderStateMixin {
  CarouselController buttonCarouselController = CarouselController();
  late Widget displayWidget;
   late TabController _tabController1;
   late TabController _tabController2;

  @override
  void initState() {
    displayWidget=Column(
      children: [
        SizedBox(height: 40.h,width: 176.w,),

       
        Align(
          alignment: Alignment.centerRight,
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(4),
            //TODO: align
            child: Stack(
              children: <Widget>[
                Container(
                  //alignment: Alignment.center,
                  //margin: EdgeInsets.only(),
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
                        displayWidget=questionnaire();
                      });
                    },

                    child: Text('התחל שאלון', style: TextStyle(fontSize: 22.w)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    _tabController1 = new TabController(length: 2, vsync: this);
    _tabController2 = new TabController(length: 8, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController1.dispose();
    _tabController2.dispose();
    super.dispose();
  }

  int _currentIndex = 0;

  getQuestionnaireByType(Questionnaire item) {
    switch (item.type) {
      case QType.checkbox:
        return RadioCheck(item);
      case QType.radio:
        return RadioCheck(item);
      case QType.freeChoice:
        return FreeChoice(item);
      case QType.fillIn:
        return FillIn(item);
      case QType.openQ:
        return OpenQuestion(item);
    }
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 100.h,right: 210.h),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.create,size: 30.w),
                Padding(padding: EdgeInsets.only(left: 11.w,right: 14.w),
                  child: Text('תרגול - מבוא ואותיות ניקוד', style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, fontSize: 36.w)),
                ),
                Icon(Icons.access_time_outlined,size: 22.w,),
                const Text('30min')
              ],
            ),

            //TODO: TabBar
            Container(
              child: TabBar(
                unselectedLabelColor: Colors.black54,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                controller: _tabController1,
                tabs: [
                  Tab(
                    child: Row(
                      children: const [
                        FaIcon(FontAwesomeIcons.file),
                        Text('שאלון'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: const [
                        Icon(Icons.folder_outlined),
                        Text('חומרי למידה'),
                      ],
                    ),
                  )
                ],
              ),
            ),

            Container(
              child: TabBarView(
                controller: _tabController1,
                children: <Widget>[
                  Container(
                    child: Column(
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
                  ),
                  Container(
                    child: Text('חומרי למידה'),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

    Widget questionnaire() {
    print('questionnaire');
    final double height = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        children: <Widget>[

          CarouselSlider(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              height: height - 100,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              reverse: false,
              onPageChanged: (index, reason) {
                print('change');
                _currentIndex = index;
                setState(() {});
              },
              // autoPlay: false,
            ),

            items: widget.questionnaires //loadQuestions()
                .map((item) => Center(
              child: getQuestionnaireByType(item),
            ))
                .toList(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Visibility(
                visible:_currentIndex!=0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  child: const Text(
                    "חזרה",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => onBackClick(),
                ),
              ),
              Visibility(
                visible: _currentIndex!=widget.questionnaires.length-1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  child: Text(
                    "הבא",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => onNextClick(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  onNextClick() {
    print('naxt click');
    buttonCarouselController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  onBackClick() {
    buttonCarouselController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }
}


