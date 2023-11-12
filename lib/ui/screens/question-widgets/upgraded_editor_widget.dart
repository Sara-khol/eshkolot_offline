import 'package:eshkolot_offline/models/quiz.dart';
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
  late double myWidth;
  late double myHeight;

  @override
  void initState() {
    customData = widget.question.moreData!;
    setPositionItems();
    widget.questionController.isCorrect = isCorrect;
    widget.questionController.isFilled = isFilled;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant UpgradedEditorWidget oldWidget) {
    ans.clear();
    myControllers.clear();
    customData = widget.question.moreData!;
    setPositionItems();
    widget.questionController.isCorrect = isCorrect;
    widget.questionController.isFilled = isFilled;

    super.didUpdateWidget(oldWidget);
  }

  setPositionItems() {
    positionedItems.clear();
    Widget myTextField = Container();
    if(double.parse(customData.customQuizQuestionsWidth)<300) {
      increaseSize=3;
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
          myControllers.add(textEditingController);

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
                    color: field.color != ''
                        ? Color(int.parse(field.color))
                        : null,
                    fontSize: double.parse(field.fontSize) * increaseSize.sp,
                    //   decoration: question.txtbox[i].txtdeco,

                    //  color: question.txtbox[i].color,
                    //backgroundColor: question.txtbox[i].backgroundColor,
                    // fontWeight: question.txtbox[i].bold
                    //? FontWeight.bold
                    //: FontWeight.normal
                  ),
                  onChanged: (txt) {
                    // debugPrint('fontSIze ${field.fontSize}');
                    //question.anss[i] = txt;
                  }));
        }

        positionedItems.add(Positioned(
            left: xPosition.w,
            top: yPosition.h,
            child: field.type == 'image'
                //image
                ? SizedBox(
                    width: itemWidth.w,
                    height: itemHeight.h,
                    child: Image.network(
                      field.defaultValue,
                    ))
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
    // for (int i = 0; i < question.txtbox.length; i++) {
    //   ans[i] = question.txtbox[i].correctAns;
    // }
    // debugPrint('${question.anss}  ${question.ans}');
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
                children: positionedItems,
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

  bool isFilled() {
    for (var controller in myControllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  bool isCorrect() {
    int i = 0;
    for (String s in ans) {
      if (s.isNotEmpty) {
        if (s != myControllers[i].text) return false;
      }
      i++;
    }
    return true;
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
