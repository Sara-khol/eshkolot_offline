import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../models/quiz.dart';
import '../course_main/questionnaire_tab.dart';



class OrderSelectionWidget extends StatefulWidget {
  final  Question question;
  final QuestionController questionController;


  const OrderSelectionWidget(
      this.question, {
        super.key, required this.questionController,
      });

  @override
  State<OrderSelectionWidget> createState() => _OrderSelectionWidgetState();
}

class _OrderSelectionWidgetState extends State<OrderSelectionWidget> {

  List<String> randomList = [];
  bool didChange=false;



  //Questionnaire question;

  @override
  void initState() {
    widget.questionController.isFilled = isFilled;
    widget.questionController.isCorrect = isCorrect;
   for(Answer answer in widget.question.ans!)
     {
       randomList.add(answer.ans);
     }
   randomList.shuffle();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OrderSelectionWidget oldWidget) {
    widget.questionController.isFilled = isFilled;
    widget.questionController.isCorrect = isCorrect;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(height: 25.h),
        HtmlWidget(widget.question.question),
        SizedBox(height: 30.h),
        ReorderableListView(
          proxyDecorator: proxyDecorator,

            buildDefaultDragHandles: false,
            shrinkWrap: true,
            children: _listOfItems(),
            onReorder: (int oldIndex, int newIndex) {
            if(!didChange) didChange=true;
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final String item = randomList.removeAt(oldIndex);
          randomList.insert(newIndex, item);
        });
            },

          ),
      ],
    );
  }

  _listOfItems() {
    return [
      for (int i = 0; i < randomList.length; i++) ...[
        ReorderableDragStartListener(
          key: Key(widget.question.ans![i].ans),
          index: i,
          child: Container(
            height: 60.h,
            padding: EdgeInsets.only(right: 15.w, left: 15.w),
            margin: EdgeInsets.only(right: 2.w, left: 2.w,bottom: 12.h),
            decoration: ShapeDecoration(
              color: const Color(0xFFFCFCFF),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.w,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: const Color(0xFFE5E4F6),
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(randomList[i]),
            ],
          ),
          ),
        ),
      ]
    ];
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Material(
          elevation: 0,
          color: Colors.transparent,
          child: child,
        );
      },
      child: Directionality(textDirection: TextDirection.rtl,
          child: child),
    );
  }




  bool isFilled() {
    return didChange;
  }

  bool isCorrect() {
    debugPrint('list answer ${randomList}');
    if(listEquals(randomList,widget.question.ans!.map((e) => e.ans).toList())) {
      return true;
    }
    return false;
  }
}
