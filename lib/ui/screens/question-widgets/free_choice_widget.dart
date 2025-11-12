import 'package:eshkolot_offline/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../custom_widgets/html_data_widget.dart';
import '../course_main/questionnaire_tab.dart';


class FreeChoice extends StatefulWidget {
 final Question question;
 final QuestionController questionController;

 const FreeChoice(this.question,{super.key, required this.questionController});

  @override
  State<FreeChoice> createState() => _FreeChoiceState();

}

class _FreeChoiceState extends State<FreeChoice> {

  TextEditingController myController = TextEditingController();
  late List<String> ansList;

  @override
  void initState() {
    widget.questionController.isFilled=isFilled;
    widget.questionController.isCorrect=isCorrect;
    debugPrint(widget.question.ans!.first.ans);
    widget.question.ans!.first.ans=  widget.question.ans!.first.ans.replaceAll('\$\$', '\$');
    ansList = widget.question.ans!.first.ans.split('\$');
    myController = TextEditingController();
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
    widget.question.ans!.first.ans=  widget.question.ans!.first.ans.replaceAll('\$\$', '\$');
    ansList = widget.question.ans!.first.ans.split('\$');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HtmlDataWidget(widget.question.question,quizId: widget.question.quizId,),
        SizedBox(height: 10.h,),
        createTextField(myController)
      ],
    );
  }

  Widget createTextField(TextEditingController controller) {

    final textStyle = TextStyle(fontSize: 22.sp, height: 1);

    final double textFieldWidth = calculateMaxWidth(ansList, textStyle);
    return Container(
        padding: const EdgeInsets.only(right: 5, left: 5),
          // margin: EdgeInsets.only(bottom: 5),
        width: textFieldWidth,
        height: 50.h,
        child: TextField(
            controller: controller,
            obscureText: false,
            textAlignVertical: TextAlignVertical.center,
            cursorColor:  Colors.black,
            textAlign:isHebrew(ansList.first)?TextAlign.right: TextAlign.left,
            style: textStyle,
            decoration: InputDecoration(
              border:  OutlineInputBorder(
                  borderSide: BorderSide(color: blackColorApp)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: blackColorApp)),
              contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 15 ),
              isDense: true,
            )));
  }

  // פונקציה שבודקת אם יש עברית במחרוזת
  bool isHebrew(String text) {
    final hebrewRegex = RegExp(r'[\u0590-\u05FF]');
    return hebrewRegex.hasMatch(text);
  }

  buildWithAnswers()
  {
    return Padding(
      padding: EdgeInsets.only(top: 25.h),
      child: Column(
        children: [
          HtmlDataWidget(widget.question.question,quizId: widget.question.quizId,),
          createItemAnswer(myController.text)
        ],
      ),
    );
  }

  createItemAnswer(String ans)
  {
   bool isOk=isCorrect()==widget.question.points;
   debugPrint('isOk $isOk');
   return Column(
     children: [
       Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 7.h,bottom: 7.h),
          decoration: BoxDecoration(border:Border.all(color: isOk?Colors.green:Colors.redAccent )),
          child: Center(
            child: Text(ans ,style: TextStyle(fontSize: 22.sp))
          ),
        ),
       SizedBox(height: 10.h),
       Container(
         height: 80.h,
         width: double.infinity,
         decoration: BoxDecoration(
             color: isOk
                 ? Colors.greenAccent.withOpacity(0.5)
                 : Colors.redAccent.withOpacity(0.5)),
         child: Center(
             child: Text(
               isOk ? 'תשובה נכונה!' : 'תשובה לא נכונה',
               style: TextStyle(fontSize: 20.sp),
             )),
       ),
     ],
   );
  }

  bool isFilled() {
    if(myController.text.isNotEmpty)
      {
        widget.questionController.displayWithAnswers=buildWithAnswers();
      }
    return myController.text.isNotEmpty;
  }

  int isCorrect() {
   return ansList.any((item) => item.trim() == myController.text)?
   widget.question.points:0;
  }
}
