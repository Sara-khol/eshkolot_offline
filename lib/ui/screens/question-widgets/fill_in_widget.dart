import 'package:eshkolot_offline/utils/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../custom_widgets/html_data_widget.dart';
import '../course_main/questionnaire_tab.dart';

class FillIn extends StatefulWidget {
  final Question question;
  final QuestionController questionController;

  const FillIn(this.question, {super.key, required this.questionController});

  @override
  State<FillIn> createState() => _FillInState();
}

class _FillInState extends State<FillIn> {
  List<TextEditingController> myControllers = [];
  List<int> pointsList = [];
  List<List<String>> correctAnswers = [];
  Map<String, TextEditingController> textControllers = {};
  List<FocusNode> focusNodes = [];
  String correctHtml = '';
  late double maxTextFieldWidth;

  @override
  void initState() {
    widget.questionController.isCorrect = isCorrect;
    widget.questionController.isFilled = isFilled;
    // debugPrint(replaceCurlyBracesWithTextFields(widget.question.ans!.first.ans));
    correctHtml = '';
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FillIn oldWidget) {
    widget.questionController.isCorrect = isCorrect;
    widget.questionController.isFilled = isFilled;

    if(oldWidget.question!=widget.question) {
      correctAnswers.clear();
      myControllers.clear();
      pointsList.clear();
      focusNodes.clear();
      correctHtml = '';
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    for (var controller in myControllers) {
      controller.dispose();
    }

    for (final controller in textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    int j = 0;

    return Padding(
      padding: EdgeInsets.only(top: 25.h),
      child: /* FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child:*/
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
            HtmlDataWidget(
              widget.question.question,
              quizId: widget.question
                  .quizId, /*style: const TextStyle(fontSize: 30, color: Colors.cyan)*/
            ),
            SizedBox(
              height: 35.h,
            ),
            Center(
                child: HtmlDataWidget(
                    correctHtml.isEmpty
                        ? replaceCurlyBracesWithTextFields(
                            widget.question.ans!.first.ans)
                        : correctHtml,
                    quizId: widget.question.quizId,
                    onInputWidgetRequested: (s) {
              // var textEditingController = TextEditingController(text: correctAnswers[i++].first );
              // myControllers.add(textEditingController);
              return createTextField(
                  myControllers[i++], focusNodes[j++], i - 1);
            })),
          ]),
    );
  }

  buildWithAnswers() {
    bool isOk = isCorrect() == widget.question.points;
    return Padding(
        padding: EdgeInsets.only(top: 25.h),
        child: Column(children: [
          HtmlDataWidget(
            widget.question.question,
            quizId: widget.question
                .quizId, /*style: const TextStyle(fontSize: 30, color: Colors.cyan)*/
          ),
          SizedBox(
            height: 35.h,
          ),
          HtmlDataWidget(
            replaceCurlyBracesWithTextFields(
                widget.question.ans!.first.ans, true),
            quizId: widget.question.quizId,
            onInputWidgetRequested: (s) {
              String? value = s[0];
              List<String> aa = extractStrings(value!.contains('|')
                  ? value.substring(0, value.indexOf('|'))
                  : value);
              String? userInput = s[1];
              return InlineCustomWidget(
                child: displayItemAnswer(aa, userInput!),
              );
            },
          ),

          // HtmlWidget(
          //     replaceCurlyBracesWithTextFields(
          //         widget.question.ans!.first.ans, true),
          //     textStyle: TextStyle(fontSize: 27.sp),
          //     customWidgetBuilder: (element) {
          //   if (element.localName == 'input') {
          //     String? value = element.attributes['value'];
          //     List<String> aa = extractStrings(value!.contains('|')
          //         ? value.substring(0, value.indexOf('|'))
          //         : value);
          //     debugPrint('displayAnswers correctAnswers $aa');
          //
          //     String? userInput = element.attributes['dirname'];
          //     debugPrint('displayAnswers userInput $userInput');
          //     return InlineCustomWidget(child: displayItemAnswer(aa, userInput!));
          //   }
          //   return null;
          // }),
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

  Widget createTextField(
      TextEditingController controller, FocusNode focusNode, int index) {
    TextStyle textStyle= TextStyle(
      fontSize: 22.sp,
    );
    final double textFieldWidth = calculateMaxWidth(correctAnswers[index], textStyle);
    debugPrint('textFieldWidth $textFieldWidth');
    // maxTextFieldWidth=textFieldWidth>maxTextFieldWidth?textFieldWidth:maxTextFieldWidth;
    return InlineCustomWidget(
      child: Container(
              height: 40.h,
              width: textFieldWidth,
              padding: EdgeInsets.only(right: 5.w, left: 5.w),
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                obscureText: false,
                textAlignVertical: TextAlignVertical.center,
                controller: controller,
                focusNode: focusNode,
                textAlign: TextAlign.center,
                cursorColor: Colors.black,
                //   maxLines: null, // Allow multiple lines to handle long text without spaces
                style:textStyle,
                decoration: InputDecoration(
                  // isCollapsed: true,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  contentPadding:
                      EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
                  // isDense: true,
                ),
                onEditingComplete: () {
                  if (index < myControllers.length - 1) {
                    FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                  } else {
                    FocusScope.of(context).requestFocus(focusNodes[0]);
                  }
                },
              )),
    );
  }

  double calculateMaxWidth(List<String> ansList, TextStyle style) {
    double maxWidth = 0;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (final text in ansList) {
      textPainter.text = TextSpan(text: text, style: style);
      textPainter.layout();
      maxWidth = maxWidth < textPainter.width ? textPainter.width : maxWidth;
    }

    return maxWidth + 180.w; // add padding/margin
  }


  Widget displayItemAnswer(
      List<String> correctAnswer, String displayUserAnswer) {
    String s = '';
    if (!correctAnswer.contains(displayUserAnswer)) {
      for (String a in correctAnswer) {
        if (s.isEmpty) {
          s = a;
        } else {
          s += ', $a';
        }
      }
    }
    return Container(
        width: 200.w,
        padding: EdgeInsets.all(7.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: grey2ColorApp),
            borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (!correctAnswer.contains(displayUserAnswer))
            Container(
                padding: EdgeInsets.only(right: 12.w, left: 12.w),

                /// width: double.infinity,
                color: Colors.redAccent.withOpacity(0.7),
                child: Text(displayUserAnswer,
                    style: TextStyle(color: blackColorApp))),
          Container(
              padding: EdgeInsets.only(right: 12.w, left: 12.w),
              color: correctAnswer.contains(displayUserAnswer)
                  ? Colors.greenAccent.withOpacity(0.7)
                  : null,
              child: Text(
                  correctAnswer.contains(displayUserAnswer)
                      ? displayUserAnswer
                      : '($s)',
                  style: TextStyle(color: blackColorApp)))
        ]));
  }

  String replaceCurlyBracesWithTextFields(String htmlContent,
      [displayAnswer = false]) {
    int i = 0;
    final regex = RegExp(r'{([^}]+)}');
    correctHtml = htmlContent.replaceAllMapped(regex, (match) {
      final initialValue = match.group(1) ?? '';
      if (!displayAnswer) {
        List<String> aa = extractStrings(initialValue.contains('|')
            ? initialValue.substring(0, initialValue.indexOf('|'))
            : initialValue);
        debugPrint('==== correctAnswers $aa');
        correctAnswers.add(aa);
        pointsList.add(initialValue.contains('|')
            ? int.parse(initialValue.split('|')[1])
            : 0);
        var textEditingController = TextEditingController();
        myControllers.add(textEditingController);
        focusNodes.add(FocusNode());
      }
      if (displayAnswer) {
        debugPrint(
            'initialValue $initialValue answer ${myControllers[i].text}');
        return '<input type="text" value="$initialValue" dirname="${myControllers[i++].text}"  />';
      } else {
        return '<input type="text" value="$initialValue" />';
      }
    });
    //debugPrint('correctHtml $correctHtml');
    return correctHtml;
  }

  List<String> extractStrings(String input) {
    RegExp regExp = RegExp(r'\[([^\[\]]*)\]');

    // Extract substrings within square brackets
    List<String> matches =
        regExp.allMatches(input).map((match) => match.group(1)!).toList();

    // If no matches found, add the entire string as the first item
    if (matches.isEmpty) {
      matches.add(input);
    }
    return matches;
  }

  bool isFilled() {
    for (var controller in myControllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    widget.questionController.displayWithAnswers = buildWithAnswers();
    return true;
  }

  int isCorrect() {
    if (widget.question.points == 1) {
      int i = 0;
      for (List<String> s in correctAnswers) {
        if (s.isNotEmpty) {
          if (!s.contains(myControllers[i].text)) return 0;
        }
        i++;
      }
      return widget.question.points; //always 1
    } else {
      int i = 0;
      int numPoints = 0;
      for (List<String> s in correctAnswers) {
        if (s.isNotEmpty) {
          if (s.contains(myControllers[i].text)) {
            if (pointsList.length == 1 && pointsList[0] == 0) {
              numPoints += widget.question.points;
            } else {
              numPoints += pointsList[i];
            }
          }
        }
        i++;
      }
      return numPoints;
    }
  }
}
