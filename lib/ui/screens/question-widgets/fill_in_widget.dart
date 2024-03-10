import 'package:eshkolot_offline/utils/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/quiz.dart';
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
 // List textfocus = [];
  List<List<String>> correctAnswers = [];
  Map<String, TextEditingController> textControllers = {};
  final FocusNode _firstFocus = FocusNode();
  final FocusNode _secondFocus = FocusNode();


  @override
  void initState() {
    widget.questionController.isCorrect = isCorrect;
    widget.questionController.isFilled = isFilled;
    // debugPrint(replaceCurlyBracesWithTextFields(widget.question.ans!.first.ans));

    super.initState();
  }

  @override
  void didUpdateWidget(covariant FillIn oldWidget) {
    // if(oldWidget.question!=widget.question)
    // {
    widget.questionController.isCorrect = isCorrect;
    widget.questionController.isFilled = isFilled;
    correctAnswers.clear();
    myControllers.clear();
   // textfocus.clear();
    // }
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
    int i=0;
    return Padding(
        padding: EdgeInsets.only(top: 25.h),
        child:/* FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child:*/ Column(
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
                        replaceCurlyBracesWithTextFields(
                            widget.question.ans!.first.ans),
                        quizId: widget.question.quizId,
                        onInputWidgetRequested: (s) {
                  // var textEditingController = TextEditingController(text: correctAnswers[i++].first );
                  // myControllers.add(textEditingController);
                  return createTextField(myControllers[i++]/*,textfocus[i++]*/);
                }
                        )),
                /*Center(
                  child: HtmlWidget(
                      replaceCurlyBracesWithTextFields(
                          widget.question.ans!.first.ans),
                      textStyle: TextStyle(
                        fontSize: 27.sp,
                      ), customWidgetBuilder: (element) {
                    if (element.localName == 'input') {
                      String? value = element.attributes['value'];

                      var textEditingController =
                          TextEditingController(text: value ?? '');
                      myControllers.add(textEditingController);
                      return InlineCustomWidget(
                          child: createTextField(textEditingController));
                    }
                   }),
                )*/
      // FocusTraversalGroup(
      //     policy: ReadingOrderTraversalPolicy(),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         TextField(
      //           focusNode: _firstFocus,
      //           decoration: InputDecoration(labelText: 'First Input'),
      //       onEditingComplete: () =>
      //           FocusScope.of(context).requestFocus(_secondFocus),
      //
      //     ),
      //         SizedBox(height: 20),
      //         TextField(
      //           focusNode: _secondFocus,
      //
      //           decoration: InputDecoration(labelText: 'Second Input'),
      //           onEditingComplete: () =>
      //               FocusScope.of(context).requestFocus(_firstFocus),
      //         ),
      //       ],
      //     ),
      // )
              ]),
       // )
        );
  }

  buildWithAnswers() {
    bool isOk = isCorrect();
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

  Widget createTextField(TextEditingController controller/*,FocusNode focusNode*/) {
    return InlineCustomWidget(
      child: Container(
          height: 40.h,
          width: 200.w,
          padding: EdgeInsets.only(right: 5.w, left: 5.w),
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
          child:
          //Focus(
           // focusNode: focusNode,
           // child:
        TextFormField(
                obscureText: false,
                textAlignVertical: TextAlignVertical.center,
                controller: controller,
             // focusNode: focusNode,
                textAlign: TextAlign.center,
                cursorColor: Colors.black,
                //   maxLines: null, // Allow multiple lines to handle long text without spaces
                style: TextStyle(
                  fontSize: 22.sp,
                ),
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
              // onEditingComplete: () =>
              //     FocusScope.of(context).requestFocus(focusNode),
            ),
         // )
    ),
    );
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
    return htmlContent.replaceAllMapped(regex, (match) {
      final initialValue = match.group(1) ?? '';
      if (!displayAnswer) {
        List<String> aa = extractStrings(initialValue.contains('|')
            ? initialValue.substring(0, initialValue.indexOf('|'))
            : initialValue);
        debugPrint('==== correctAnswers $aa');
        correctAnswers.add(aa);
        var textEditingController = TextEditingController();
        myControllers.add(textEditingController);
       // textfocus.add(FocusNode());
      }
      if (displayAnswer) {
        debugPrint(
            'initialValue $initialValue answer ${myControllers[i].text}');
        return '<input type="text" value="$initialValue" dirname="${myControllers[i++].text}"  />';
      } else {
        return '<input type="text" value="$initialValue" />';
      }
    });
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

  bool isCorrect() {
    int i = 0;
    for (List<String> s in correctAnswers) {
      if (s.isNotEmpty) {
        if (!s.contains(myControllers[i].text)) return false;
      }
      i++;
    }
    return true;
  }
}

