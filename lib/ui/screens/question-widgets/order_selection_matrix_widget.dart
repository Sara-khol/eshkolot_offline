import 'package:eshkolot_offline/models/quiz.dart';
import 'package:eshkolot_offline/ui/custom_widgets/html_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eshkolot_offline/utils/my_colors.dart' as colors;

import '../course_main/questionnaire_tab.dart';

class OrderSelectionMatrixWidget extends StatefulWidget {
  final Question question;
  final QuestionController questionController;

  const OrderSelectionMatrixWidget(this.question,
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
  // List<String> correctAnswersList = [];
  List<String> ans = [];
  List<bool> isCorrectList = [];
  List<int> numPointsList = [];
  bool isDragging = false;
  late bool isHtml;

  @override
  void initState() {
    initData();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant OrderSelectionMatrixWidget oldWidget) {
    initData();
    super.didUpdateWidget(oldWidget);
  }

  initData() {
    isHtml = widget.question.ans!.first.html;
    widget.questionController.isFilled = isFilled;
    widget.questionController.isCorrect = isCorrect;
    matrixMatchList =
        widget.question.ans!.map((e) => e.matrixMatch ?? '').toList();
    numPointsList =
        widget.question.ans!.map((e) => e.points ?? 0).toList();
    List<String> correctAnswersList = widget.question.ans!
        .map((e) => e.ans)
        .toList();
    ans = List<String>.generate(correctAnswersList.length, (index) => '');
    isCorrectList =
    List<bool>.generate(correctAnswersList.length, (index) => false);
    // dragQ = DragQ(widget.question.ans!.map((e) => e.matrixMatch ?? '').toList(),
    //     widget.question.ans!.map((e) => e.ans).toList(), {});
    randomList.clear();
    randomList = List.from(correctAnswersList);
    randomList = randomList.map((str) => str.replaceAll('\n', '')).toList();
    randomList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 25.h),
        HtmlDataWidget(
          widget.question.question,
          quizId: widget.question.quizId,
        ),
        SizedBox(height: 20.h),
        SizedBox(
          width: MediaQuery
              .sizeOf(context)
              .width,
          child: Wrap(
              direction: Axis.horizontal,
              spacing: 10.w,
              runSpacing: 10.w,
              children: List.generate(matrixMatchList.length, (i) {
                return IgnorePointer(
                  ignoring: ans.contains(matrixMatchList[i]),
                  child: Draggable<String>(
                    // Data is the value this Draggable stores.
                    data: matrixMatchList[i],
                    feedback: Material(
                      child: dragWidget(i),
                    ),
                    childWhenDragging: dragWidget(i, changeBackground: true),
                    child: dragWidget(i),
                  ),
                );
              })),
        ),
        SizedBox(height: 24.h),
        for (int i = 0; i < randomList.length; i++) ...[
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Container(
              // height:isHtml?110.h: 75.h,
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
                    width: 140.w,
                    padding: EdgeInsets.all(10.h),
                    child: Center(
                      child: isHtml
                          ? HtmlDataWidget(randomList[i],
                          quizId: widget.question.quizId)
                          : Text(
                        randomList[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors.blackColorApp,
                          fontSize: 27.sp,
                          fontWeight: FontWeight.w400,
                          // height: 22,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: isHtml ? 95.h : 60.h,
                      padding: EdgeInsets.only(
                          top: 7.h, bottom: 7.h, right: 10.h, left: 10.h),
                      decoration: BoxDecoration(
                        // color: isDragging?Colors.yellowAccent:  const Color(0xFFFCFCFF),
                          border: Border(
                            right: BorderSide(
                              width: 1.w,
                              color: const Color(0xFFE5E4F6),
                            ),
                          )),
                      child: DragTarget<String>(
                        builder: (BuildContext context, List<dynamic> accepted,
                            List<dynamic> rejected) {
                          return
                            // ans[i] != ''
                            //   ? dragWidget(i, isAnswer: true)
                            //   : Container();

                            Draggable<String>(
                              // maxSimultaneousDrags: maxSimultaneousDrags[i],
                              // Data is the value this Draggable stores.
                              data: ans[i],
                              feedback: Material(
                                child: dragWidget(i, isAnswer: true),
                              ),
                              childWhenDragging: dragWidget(
                                  i, changeBackground: true, isAnswer: true),
                              child: /* dragWidget(i)*/
                              ans[i] != ''
                                  ? dragWidget(i, isAnswer: true)
                                  : Container(),
                            );
                        },
                        onAccept: (data) {
                          debugPrint(data);
                          // ans.remove(data);

                          setState(() {
                            if (ans.contains(data)) {
                              ans [ans.indexOf(data)] = '';
                            }
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

  Widget dragWidget(int i,
      {bool changeBackground = false, bool isAnswer = false, displayAnswer = false}) {
    return Container(
      // height: 40.h,
      // width: 80.w,
      padding:
      EdgeInsets.only(bottom: 11.h, top: 11.h, right: 24.h, left: 24.h),
      decoration: BoxDecoration(
          color:
          !displayAnswer ? changeBackground ||
              (ans.contains(matrixMatchList[i]) && !isAnswer) ? colors
              .grey2ColorApp : const Color(0xffe5e4f6) :
          isCorrectList[i] ? Colors.green : const Color(0xffe5e4f6),
          borderRadius: BorderRadius.circular(3)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu,
              color: !displayAnswer ? colors.blackColorApp : isCorrectList[i]
                  ? Colors.white
                  : Colors.red),
          Text(
            isAnswer ? ans[i] : matrixMatchList[i],
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: !displayAnswer ? colors.blackColorApp : isCorrectList[i]
                    ? Colors.white
                    : Colors.red),
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
    if (ans.every((item) => item.isNotEmpty)) {
      widget.questionController.displayWithAnswers = displayWithAnswers();
    }
    return ans.every((item) => item.isNotEmpty);
  }

  int isCorrect() {
    if (widget.question.points > 1) {
      int numPoints = 0;
      for (int i = 0; i < isCorrectList.length; i++) {
        if (isCorrectList[i]) {
          numPoints += numPointsList[i];
        }
      }
      return numPoints;
    }
    else {
      if (isCorrectList.every((element) => element == true)) {
        return widget.question.points;//always 1
      }
      return 0;
    }
  }

    displayWithAnswers() {
      for (int i = 0; i < randomList.length; i++) {
        Answer? answer = widget.question.ans
            ?.firstWhere((answer) => answer.matrixMatch == ans[i]);
        isCorrectList[i] = answer != null && answer.ans == randomList[i];
      }
      return Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25.h),
              HtmlDataWidget(
                widget.question.question,
                quizId: widget.question.quizId,
              ),
              SizedBox(height: 24.h),
              for (int i = 0; i < randomList.length; i++) ...[
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Container(
                    // height:isHtml?110.h: 75.h,
                    margin: EdgeInsets.only(right: 2.w, left: 2.w),
                    decoration: ShapeDecoration(
                      // color: isCorrectList[i]?Colors.greenAccent:const Color(0xFFFCFCFF),
                      color: const Color(0xFFFCFCFF),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.w,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: isCorrectList[i] ? Colors.green : Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          // color: isCorrectList[i]?Colors.greenAccent:null,
                          width: 140.w,
                          padding: EdgeInsets.all(10.h),
                          child: Center(
                            child: isHtml
                                ? HtmlDataWidget(randomList[i],
                                quizId: widget.question.quizId)
                                : Text(
                              randomList[i],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colors.blackColorApp,
                                fontSize: 27.sp,
                                fontWeight: FontWeight.w400,
                                // height: 22,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: isHtml ? 95.h : 60.h,
                            padding: EdgeInsets.only(
                                top: 7.h, bottom: 7.h, right: 10.h, left: 10.h),
                            decoration: BoxDecoration(
                              // color: isCorrectList[i]?Colors.greenAccent:null,
                              // color: isDragging?Colors.yellowAccent:  const Color(0xFFFCFCFF),
                                border: Border(
                                  right: BorderSide(
                                    width: 1.w,
                                    color: const Color(0xFFE5E4F6),
                                  ),
                                )),
                            child: dragWidget(
                                i, isAnswer: true, displayAnswer: true),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              Container(
                height: 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: isCorrectList.every((element) => element == true)
                        ? Colors.greenAccent.withOpacity(0.5)
                        : Colors.redAccent.withOpacity(0.5)),
                child: Center(
                    child: Text(
                      isCorrectList.every((element) => element == true)
                          ? 'תשובה נכונה!'
                          : 'אחת או יותר מהתשובות לא נכונות',
                      style: TextStyle(fontSize: 20.sp),
                    )),
              ),
            ],
          ));
    }
  }
