import 'package:eshkolot_offline/models/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../course_main/questionnaire_tab.dart';


class OrderSelectionMatrixWidget extends StatefulWidget {
  final Question question;
  final QuestionController questionController;

  OrderSelectionMatrixWidget(this.question,
      {super.key, required this.questionController});

  @override
  State<OrderSelectionMatrixWidget> createState() =>
      _OrderSelectionMatrixWidgetState();
}

class _OrderSelectionMatrixWidgetState
    extends State<OrderSelectionMatrixWidget> {
 // List<int> maxSimultaneousDrags = [];
  List<String> randomList = [];
  List<String> matrixMatchList = [];
  List<String> correctAnswersList = [];
   List<String> ans=[];

  bool isDragging=false;


  @override
  void initState() {
    widget.questionController.isFilled = isFilled;
    widget.questionController.isCorrect = isCorrect;
    matrixMatchList=widget.question.ans!.map((e) => e.matrixMatch ?? '').toList();
    correctAnswersList = widget.question.ans!.map((e) => e.ans).toList();
    ans=List<String>.generate(correctAnswersList.length, (index) => '');
    // dragQ = DragQ(widget.question.ans!.map((e) => e.matrixMatch ?? '').toList(),
    //     widget.question.ans!.map((e) => e.ans).toList(), {});
    randomList = List.from(correctAnswersList);
    randomList.shuffle();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant OrderSelectionMatrixWidget oldWidget) {
    widget.questionController.isFilled = isFilled;
    widget.questionController.isCorrect = isCorrect;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 25.h),
        HtmlWidget(widget.question.question),
        SizedBox(height: 20.h),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Wrap(
              direction: Axis.horizontal,
              spacing: 10.w,
              runSpacing: 10.w,
              children: List.generate(matrixMatchList.length, (i) {
                return Draggable<String>(
                  // maxSimultaneousDrags: maxSimultaneousDrags[i],
                  // Data is the value this Draggable stores.
                  data: matrixMatchList[i],
                  feedback: Material(
                    child: dragWidget(i),
                  ),
                  childWhenDragging: dragWidget(i, changeBackground: true),
                  // onDragCompleted: () {
                  //   debugPrint('onDragCompleted');
                  // //  maxSimultaneousDrags[i] = maxSimultaneousDrags[i] - 1;
                  //   setState(() {
                  //     isDragging=false;
                  //   });
                  // },
                  // onDragStarted: (){
                  //   setState(() {
                  //     isDragging=true;
                  //   });
                  // },
                  // onDraggableCanceled: (v,o){
                  //   setState(() {
                  //     isDragging=false;
                  //   });
                  // },
                  child: dragWidget(i),
                );
              })),
        ),
        SizedBox(height: 24.h),
        for (int i = 0; i < randomList.length; i++) ...[
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Container(
              height: 60.h,
              margin: EdgeInsets.only(right: 2.w, left: 2.w),
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
              ),
              child: Row(
                children: [
                  Container(
                    width: 120.w,
                    padding: EdgeInsets.all(10.h),
                    child: Text(
                      randomList[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.blackColorApp,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        // height: 22,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 60.h,
                      padding: EdgeInsets.only(top: 7.h,bottom: 7.h,right: 10.h,left:10.h),
                      decoration: BoxDecoration(
                        // color: isDragging?Colors.yellowAccent:  const Color(0xFFFCFCFF),
                          border: Border(
                        right:BorderSide(
                          width: 1.w,
                          color: const Color(0xFFE5E4F6),
                        ),
                      )),
                      child: DragTarget<String>(
                        builder: (BuildContext context, List<dynamic> accepted,
                            List<dynamic> rejected) {
                          return  ans[i] != ''?dragWidget(i,isAnswer: true):Container();
                        },
                        onAccept: (data) {
                          debugPrint(data);
                          setState(() {
                            ans[i] = data;
                          });
                          debugPrint('=====$i=======');
                          debugPrint('data $data ');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]
      ],
    );
  }

  Widget dragWidget(int i, {bool changeBackground = false, bool isAnswer=false}) {
    return Container(
      // height: 40.h,
      // width: 80.w,
      padding:
          EdgeInsets.only(bottom: 11.h, top: 11.h, right: 24.h, left: 24.h),
      decoration: BoxDecoration(
          color: changeBackground ? colors.grey2ColorApp : Color(0xffe5e4f6),
          borderRadius: BorderRadius.circular(3)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.menu),
          Text(
          isAnswer?ans[i]:  matrixMatchList[i],
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: colors.blackColorApp),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String removeEmptyLines(String text) {
    debugPrint('text $text');
    // Define the regular expression pattern to match empty lines
    RegExp emptyLinesPattern = RegExp(r'^[\s\t]*$\r?\n', multiLine: true);
    // Remove empty lines using replaceAll() method
    String result = text.replaceAll(emptyLinesPattern, '');
    debugPrint('result $result');

    return result;
  }

  bool isFilled() {
    return ans.every((item) => item.isNotEmpty);
  }

  bool isCorrect() {
    debugPrint('ans ${ans}');

    for (int i = 0; i < ans.length; i++) {
      Answer? answer = widget.question.ans
          ?.firstWhere((answer) => answer.matrixMatch == ans[i]);
      debugPrint('answer.ans ${answer != null ? answer.ans : 'null'}');
      debugPrint('randomList ${randomList[i]}');

      if (answer != null && answer.ans != randomList[i]) {
        return false;
      }
    }
    return true;
  }
}
