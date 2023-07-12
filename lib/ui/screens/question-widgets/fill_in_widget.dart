
import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../course_main/questionnaire_tab.dart';


class FillIn extends StatefulWidget {
  final Question question;
  final QuestionController questionController;


   const FillIn(this.question, {super.key,required this.questionController});

  @override
  State<FillIn> createState() => _FillInState();
}

class _FillInState extends State<FillIn> {
  List<TextEditingController> myControllers = [];
  List<String> correctAnswers = [];
  Map<String, TextEditingController> textControllers = {};

  late Map<String, String> fillInQ;

  @override
  void initState() {
    fillInQ=extractKeyValuePairs(widget.question.ans!.first.ans);
    widget.questionController.isCorrect=isCorrect;
    widget.questionController.isFilled=isFilled;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FillIn oldWidget) {
    // if(oldWidget.question!=widget.question)
    // {
      widget.questionController.isCorrect=isCorrect;
      widget.questionController.isFilled=isFilled;

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
    var english = RegExp(r'[a-zA-Z]');
    return  Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            HtmlWidget(widget.question.question,
                /*style: const TextStyle(fontSize: 30, color: Colors.cyan)*/),
            const SizedBox(
              height: 35,
            ),
           HtmlWidget(replaceCurlyBracesWithTextFields(widget.question.ans!.first.ans),

             customWidgetBuilder: (element) {
      if (element.localName == 'input') {
        final text = element.text;
        var textEditingController = TextEditingController();
        myControllers.add(textEditingController);
      //  if (text != null && text.startsWith('{') && text.endsWith('}')) {
          return createTextField(textEditingController);
        }
        // else if (element.localName == 'br') {
        //          return SizedBox(height: 0); // Hide the line break
        //        }
               return null;
             }),
          ],
        ),
      );
  }


  buildDisplay() {
    List<Widget> children = [];
    fillInQ.forEach((key, value) {
      children.add(HtmlWidget(key/*,style: TextStyle(fontSize: 25),*/));
      if (value.isNotEmpty) {
        var textEditingController = new TextEditingController();
        myControllers.add(textEditingController);
        children.add(createTextField(textEditingController));
      }
    });
    return children;
  }

  Widget createTextField(TextEditingController controller) {
    return Container(
        padding: EdgeInsets.only(right: 5, left: 5),
     //   margin: EdgeInsets.only(top: 15.h,bottom: 15.h),
        width: 50,
        height: 30.h,
        child: IntrinsicWidth(
          child: TextField(
              controller: controller,
              cursorColor:  Colors.black,
              textAlign: TextAlign.center,
               style: TextStyle(fontSize: 20.sp),
              decoration:const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 15 ),
                isDense: true,
              )),
        ));
  }


  ///Check answer's correctness
  bool validAnswer() {
    int i = 0;
    for (var ans in fillInQ.values) {
      if (ans.isNotEmpty) {
        if (!ans.contains(myControllers[i].text)) return false;
      }
      i++;
    }
    return true;
  }

  String replaceCurlyBracesWithTextFields(String htmlContent) {
    final regex = RegExp(r'{([^}]+)}');
    return htmlContent.replaceAllMapped(regex, (match) {
      final initialValue = match.group(1) ?? '';
      correctAnswers.add(initialValue);
      return '<input type="text" value="$initialValue" />';
    });
  }


  Map<String, String> extractKeyValuePairs(String html) {
    Map<String, String> keyValueMap = {};

    RegExp regExp = RegExp(r'([^{]+)\s*{([^}]+)}');
    Iterable<RegExpMatch> matches = regExp.allMatches(html);

    for (var match in matches) {
      String? key = match.group(1)?.trim();
      String? value = match.group(2);
      if(key !=null) {
        keyValueMap[key] = value??'';
      }
    }
    // keyValueMap.forEach((key, value) {
    //   print('Key: $key');
    //   print('Value: $value');
    //   print('-------------------------');
    // });
    return keyValueMap;
  }

  bool isFilled()
  {
    for (var controller in myControllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;  }

  bool isCorrect()
  {
    int i = 0;
    for (String s in correctAnswers) {
      if (s.isNotEmpty) {
        if (s!=myControllers[i].text) return false;
      }
      i++;
    }
    return true;
  }
}

// class _CustomWidgetFactory extends WidgetFactory {
//   final WidgetFactory delegate;
//
//   _CustomWidgetFactory(this.delegate);
//
//   @override
//   Widget buildTextWidget(TextData text) {
//     final textContent = text.text;
//     if (textContent != null && textContent.startsWith('{') && textContent.endsWith('}')) {
//       return TextField(
//         decoration: InputDecoration(
//           hintText: 'Enter value',
//         ),
//         onChanged: (value) {
//           // Handle text field changes if necessary
//         },
//       );
//     }
//
//     return delegate.buildTextWidget(text);
//   }
// }
