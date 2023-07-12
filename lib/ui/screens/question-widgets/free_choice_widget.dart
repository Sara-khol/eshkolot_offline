import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../course_main/questionnaire_tab.dart';


class FreeChoice extends StatefulWidget {
 final Question question;
 final QuestionController questionController;

 const FreeChoice(this.question,{super.key, required this.questionController,});

  @override
  State<FreeChoice> createState() => _FreeChoiceState();

}

class _FreeChoiceState extends State<FreeChoice> {

  final myController = TextEditingController();

  @override
  void initState() {
    widget.questionController.isFilled=isFilled;
    widget.questionController.isCorrect=isCorrect;
    super.initState();
  }

 @override
  void didUpdateWidget(covariant FreeChoice oldWidget) {
    if(oldWidget.question!=widget.question)
      {
        myController.text='';
      }
   widget.questionController.isFilled=isFilled;
   widget.questionController.isCorrect=isCorrect;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HtmlWidget(widget.question.question),
        createTextField(myController)
      ],
    );
  }

  Widget createTextField(TextEditingController controller) {
    return Container(
        padding: EdgeInsets.only(right: 5, left: 5),
        //   margin: EdgeInsets.only(top: 15.h,bottom: 15.h),
        width: 80,
        height: 50.h,
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

  bool isFilled() {
    return myController.text.isNotEmpty;
  }

  bool isCorrect() {
    return myController.text.compareTo(widget.question.ans!.first.ans) == 0;
  }
}
