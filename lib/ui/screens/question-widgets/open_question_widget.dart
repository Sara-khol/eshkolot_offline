import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../custom_widgets/html_data_widget.dart';
import '../course_main/questionnaire_tab.dart';


class OpenQuestion extends StatefulWidget {
  final Question question;
  final QuestionController questionController;

  const OpenQuestion(this.question,{super.key, required this.questionController,});
  
  @override
  State<OpenQuestion> createState() => _OpenQuestionState();

}

class _OpenQuestionState extends State<OpenQuestion> {
  
  final myController = TextEditingController();
  String ans='';

  @override
  void initState() {
    widget.questionController.isFilled=isFilled;
    widget.questionController.isCorrect=isCorrect;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OpenQuestion oldWidget) {
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
      children:[
        HtmlDataWidget(widget.question.question,quizId: widget.question.quizId),
        SizedBox(height: 20.h),
        createTextField(myController),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget createTextField(TextEditingController controller) {
    return Container(
        padding: const EdgeInsets.only(right: 5, left: 5),
        //   margin: EdgeInsets.only(top: 15.h,bottom: 15.h),
        width: 800.w,
        height: 400.h,
        child: TextField(

            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,
            controller: controller,
            cursorColor:  Colors.black,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            style: TextStyle(fontSize: 20.sp),
            decoration: InputDecoration(
              hintText: 'נא הזן את תשובתך',
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h ),
              isDense: true,
            )));
  }

  bool isFilled() {
    return myController.text.isNotEmpty;
  }

  bool isCorrect() {
    return true;
  }
}