import 'package:eshkolot_offline/models/quiz.dart';
import 'package:eshkolot_offline/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../custom_widgets/html_data_widget.dart';
import '../course_main/questionnaire_tab.dart';

class UpgradedEditorWidget extends StatefulWidget {
  const UpgradedEditorWidget(this.question,
      {super.key, required this.questionController});

  final Question question;
  final QuestionController questionController;

  @override
  State<UpgradedEditorWidget> createState() => _UpgradedEditorWidgetState();
}

class _UpgradedEditorWidgetState extends State<UpgradedEditorWidget> {
  double increaseSize = 1.5;
  late MoreData customData;
  List<Widget> positionedItems = [];

  late List<String> ans = [];
  List<TextEditingController> myControllers = [];
  List<int> pointsList = [];

  List<FocusNode> focusNodes = [];
  late double myWidth=700;
  late double myHeight=700;
  // final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    customData = widget.question.moreData!;
    setPositionItems();
    widget.questionController.isCorrect = isCorrect;
    widget.questionController.isFilled = isFilled;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _getContainerConstraints();
    // });
    super.initState();
  }

  // void _getContainerConstraints() {
  //   final RenderBox renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox;
  //   final Size size = renderBox.size;
  //   setState(() {
  //     // You can now use the size to update your widget's state
  //     setPositionItems(size.width);
  //     print('Width: ${size.width}, Height: ${size.height}');
  //   });
  // }

  @override
  void didUpdateWidget(covariant UpgradedEditorWidget oldWidget) {
    ans.clear();
    myControllers.clear();
    focusNodes.clear();
    pointsList.clear();
    customData = widget.question.moreData!;
   setPositionItems();
    widget.questionController.isCorrect = isCorrect;
    widget.questionController.isFilled = isFilled;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _getContainerConstraints();
    // });
    super.didUpdateWidget(oldWidget);
  }

  setPositionItems(/*double width*/) {
    positionedItems.clear();
    Widget myTextField = Container();
    if (double.parse(customData.customQuizQuestionsWidth) < 300) {
      increaseSize = 3;
    }
    debugPrint('increaseSize $increaseSize');
    myWidth =
        double.parse(customData.customQuizQuestionsWidth) * increaseSize.w;
    myHeight =
        double.parse(customData.customQuizQuestionsHeight) * increaseSize.h;
    for (var field in customData.quizFields) {
      if (field.name.isNotEmpty &&
          field.xPosition.isNotEmpty &&
          field.yPosition.isNotEmpty) {
        double xPosition = double.parse(field.xPosition) * increaseSize;
        double yPosition = double.parse(field.yPosition) * increaseSize;
        double itemWidth =
            field.width != '' ? double.parse(field.width) * increaseSize : 0;
        double itemHeight =
            field.height != '' ? double.parse(field.height) * increaseSize : 0;

        if (field.editable.isNotEmpty) {
          ans.add(field.correctAnswer);
          var textEditingController = TextEditingController();
          var focusNode = FocusNode();
          myControllers.add(textEditingController);
          focusNodes.add(focusNode);
          pointsList.add(field.points.isNotEmpty ? int.parse(field.points) : 0);
          myTextField = Container(
              width: field.maxWidth != ''
                  ? double.parse(field.maxWidth) * increaseSize.w
                  : null,
              // height: 35.h,
              color: field.background != ''
                  ? Color(int.parse(field.background))
                  : null,
              child: TextField(
                controller: textEditingController,
                focusNode: focusNode,
                buildCounter: null,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: field.defaultValue),
                cursorColor:
                    field.color != '' ? Color(int.parse(field.color)) : null,
                textAlign: TextAlign.center,
                maxLines: 1,
                textDirection: field.direction == 'rtl'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: TextStyle(
                  fontWeight: field.bold.isNotEmpty
                      ? FontWeight.bold
                      : FontWeight.normal,
                  height: 1,
                  color:
                      field.color != '' ? Color(int.parse(field.color)) : null,
                  fontSize: double.parse(field.fontSize) * increaseSize.sp,
                  //   decoration: question.txtbox[i].txtdeco,

                  //  color: question.txtbox[i].color,
                  //backgroundColor: question.txtbox[i].backgroundColor,
                  // fontWeight: question.txtbox[i].bold
                  //? FontWeight.bold
                  //: FontWeight.normal
                ),
                onEditingComplete: () {
                  int index = focusNodes.indexOf(focusNode);
                  if (index < myControllers.length - 1) {
                    FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                  } else {
                    FocusScope.of(context).requestFocus(focusNodes[0]);
                  }
                },
              ));
        }

        if (field.type == 'image') {
          debugPrint('image=== ${field.defaultValue}');
        }

        positionedItems.add(Positioned(
            left: xPosition.w,
            top: yPosition.h,
            child: field.type == 'image'
                //image
                ? field.defaultValue.isNotEmpty
                    ?  /*  (itemWidth.w > width) ?Container(
                      width: width,
                        height: itemHeight.h,
                        child: HtmlDataWidget(
                            '<img  src="${field.defaultValue.substring(field.defaultValue.lastIndexOf('/'), field.defaultValue.length)}" alt=""  />',
                            quizId: widget.question.quizId),
                      ):*/
            Container(
                width: itemWidth.w,
                height: itemHeight.h,
                child: HtmlDataWidget(
                    '<img  src="${field.defaultValue.substring(field.defaultValue.lastIndexOf('/'), field.defaultValue.length)}" alt=""  />',
                    quizId: widget.question.quizId),)

                /*SizedBox(
                        width: itemWidth.w,
                        height: itemHeight.h,
                        child: Image.network(
                          field.defaultValue,
                        ))*/
                    : SizedBox()
                : field.editable.isEmpty
                    ?
                    //text
                    SizedBox(
                        width: field.maxWidth != ''
                            ? double.parse(field.maxWidth) * increaseSize.w
                            : null,
                        //goes on top of image and see some white
                        // color:  field.background != ''
                        //     ? Color(int.parse(field.background))
                        //     : null,
                        child: Text(field.defaultValue,
                            style: TextStyle(
                                fontWeight: field.bold.isNotEmpty
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: double.parse(field.fontSize) *
                                    increaseSize.sp,
                                color: field.color != ''
                                    ? Color(int.parse(field.color))
                                    : null),
                            textDirection: field.direction == 'rtl'
                                ? TextDirection.rtl
                                : TextDirection.ltr),
                      )
                    : myTextField));
      }
    }
  }

  //List<String> ans=[];
  @override
  Widget build(BuildContext context) {
    return Padding(
        //padding: const EdgeInsets.all(100),
        padding: EdgeInsets.only(top: 25.h),
        child: Column(children: [
          HtmlDataWidget(widget.question.question,
              quizId: widget.question.quizId),
          SizedBox(
            height: 35.h,
          ),
          SizedBox(
              width: myWidth,
              height: myHeight,
              child: LayoutBuilder(
                builder:  (context, constraints) {
                  if (myWidth > constraints.maxWidth)
                  debugPrint('fffff');
                  return Stack(
                    // children: displayAnswers?positionedItemsAnswers:positionedItems,
                    children: positionedItems,
                  );
                }
              ))
        ]));

    // floatingActionButton: FloatingActionButton(
    //   onPressed: () {
    //     debugPrint('${question.anss} ${question.ans}');
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         if (listEquals(question.anss, question.ans)) {
    //           return const AlertDialog(content: Text('Correct'));
    //         } else {
    //           return const AlertDialog(content: Text('Incorrect'));
    //         }
    //       },
    //     );
    //   },
    //   child: const Icon(Icons.check),
    // ),
  }

  Widget buildQAnswers() {
    bool isOk = isCorrect() == widget.question.points;
    return Padding(
        //padding: const EdgeInsets.all(100),
        padding: EdgeInsets.only(top: 25.h),
        child: Column(children: [
          HtmlDataWidget(widget.question.question,
              quizId: widget.question.quizId),
          SizedBox(
            height: 35.h,
          ),
          SizedBox(
              width: myWidth,
              height: myHeight,
              child: Stack(
                children: setPositionItemsAnswer(),
              )),
          Container(
            height: 80.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: isOk
                    ? Colors.greenAccent.withOpacity(0.5)
                    : Colors.redAccent.withOpacity(0.5)),
            child: Center(
                child: Text(
              isOk ? 'תשובה נכונה!' : 'אחת או יותר מהתשובות לא נכונות',
              style: TextStyle(fontSize: 20.sp),
            )),
          )
        ]));
  }

  List<Widget> setPositionItemsAnswer() {
    List<Widget> positionedItemsAnswers = [];
    Widget myTextField = Container();
    if (double.parse(customData.customQuizQuestionsWidth) < 300) {
      increaseSize = 3;
    }
    debugPrint('increaseSize $increaseSize');
    myWidth =
        double.parse(customData.customQuizQuestionsWidth) * increaseSize.w;
    myHeight =
        double.parse(customData.customQuizQuestionsHeight) * increaseSize.h;
    int i = 0;
    for (var field in customData.quizFields) {
      if (field.name.isNotEmpty &&
          field.xPosition.isNotEmpty &&
          field.yPosition.isNotEmpty) {
        double xPosition = double.parse(field.xPosition) * increaseSize;
        double yPosition = double.parse(field.yPosition) * increaseSize;
        double itemWidth =
            field.width != '' ? double.parse(field.width) * increaseSize : 0;
        double itemHeight =
            field.height != '' ? double.parse(field.height) * increaseSize : 0;

        if (field.editable.isNotEmpty) {
          bool isCorrect = myControllers[i].text == ans[i];

          myTextField = Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: field.maxWidth != ''
                      ? double.parse(field.maxWidth) * increaseSize.w
                      : null,
                  // height: 35.h,
                  decoration: BoxDecoration(
                      color: isCorrect
                          ? Colors.greenAccent
                          : Colors.redAccent.withOpacity(0.5),
                      border: Border.all(
                          color: isCorrect ? Colors.green : Colors.red)),
                  child: Text(
                    textAlign: TextAlign.center,
                    myControllers[i].text,
                    style: TextStyle(
                        fontWeight: field.bold.isNotEmpty
                            ? FontWeight.bold
                            : FontWeight.normal,
                        height: 1,
                        color: field.color != ''
                            ? Color(int.parse(field.color))
                            : null,
                        fontSize:
                            double.parse(field.fontSize) * increaseSize.sp),
                  )),
              if (!isCorrect) /* SizedBox(
                  width: field.maxWidth != ''
                      ? double.parse(field.maxWidth) * increaseSize.w
                      : null,
                  child:*/
                Text(
                  '(${ans[i]})',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: field.bold.isNotEmpty
                          ? FontWeight.bold
                          : FontWeight.normal,
                      height: 1,
                      color: blackColorApp,
                      fontSize: double.parse(field.fontSize) * increaseSize.sp),
                )
              //)
            ],
          );
          i++;
        }

        positionedItemsAnswers.add(Positioned(
            left: xPosition.w,
            top: yPosition.h,
            child: field.type == 'image'
                //image
                ? field.defaultValue.isNotEmpty
                    ? SizedBox(
                        width: itemWidth.w,
                        height: itemHeight.h,
                        child: Image.network(
                          field.defaultValue,
                        ))
                    : const SizedBox()
                : field.editable.isEmpty
                    ?
                    //text
                    SizedBox(
                        width: field.maxWidth != ''
                            ? double.parse(field.maxWidth) * increaseSize.w
                            : null,
                        //goes on top of image and see some white
                        // color:  field.background != ''
                        //     ? Color(int.parse(field.background))
                        //     : null,
                        child: Text(field.defaultValue,
                            style: TextStyle(
                                fontWeight: field.bold.isNotEmpty
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: double.parse(field.fontSize) *
                                    increaseSize.sp,
                                color: field.color != ''
                                    ? Color(int.parse(field.color))
                                    : null),
                            textDirection: field.direction == 'rtl'
                                ? TextDirection.rtl
                                : TextDirection.ltr),
                      )
                    : myTextField));
      }
    }
    return positionedItemsAnswers;
  }

  bool isFilled() {
    for (var controller in myControllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    // setPositionItemsAnswer();
    widget.questionController.displayWithAnswers = buildQAnswers();
    return true;
  }

  int isCorrect() {
    debugPrint('list points $pointsList');
    calculateTotalPoints();
    if (widget.question.points < 2) {
      int i = 0;
      for (String s in ans) {
        if (s.isNotEmpty) {
          if (s != myControllers[i].text) return 0;
        }
        i++;
      }
      return 1;
    } else {
      int numPoints = 0;
      int i = 0;
      for (String s in ans) {
        if (s.isNotEmpty) {
          if (s == myControllers[i].text) {
            numPoints += pointsList[i];
            i++;
          }
        }
      }
      return numPoints;
    }
  }

  calculateTotalPoints() {
    int totalPoints = 0;
    for (int i in pointsList) {
      totalPoints += i;
    }
    debugPrint(
        'totalPoints original: ${widget.question.points} calculate: $totalPoints');
    widget.question.points = totalPoints;
  }

  @override
  void dispose() {
    super.dispose();
    // Clean up the controller when the widget is disposed.
    for (var controller in myControllers) {
      controller.dispose();
    }
  }
}
