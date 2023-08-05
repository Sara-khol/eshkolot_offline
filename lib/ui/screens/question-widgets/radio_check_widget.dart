import 'package:eshkolot_offline/ui/custom_widgets/html_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/checkbox_widget.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../course_main/questionnaire_tab.dart';

class RadioCheck extends StatefulWidget {
  const RadioCheck(this.question, {super.key, required this.questionController});

 final Question question;
 final QuestionController questionController;

  @override
  State<RadioCheck> createState() => _RadioCheckState();
}

class _RadioCheckState extends State<RadioCheck> {

  String _character='';

   List<bool> _isSelected=[];


  @override
  void initState(){
  super.initState();
  widget.questionController.isFilled=isFilled;
  widget.questionController.isCorrect=verifyCheck;

  _isSelected= List<bool>.filled(widget.question.ans!.length, false);
  }


  @override
  void didUpdateWidget(covariant RadioCheck oldWidget) {
    if(oldWidget.question!=widget.question)
      {
       _isSelected= List<bool>.filled(widget.question.ans!.length, false);
        _character='';
     }
    widget.questionController.isFilled=isFilled;
    widget.questionController.isCorrect=verifyCheck;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
           widget.question.type == QType.checkbox
              ? getCheckBoxWidget(widget.question)
              : getRadioWidget(widget.question),
        ]));
  }

  Widget getRadioWidget(Question item) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
              alignment: Alignment.centerRight,
              child: HtmlDataWidget(item.question, quizId: item.quizId)),
          SizedBox(height: 30.h,),
          for(var ans in item.ans!)...[
            RadioListTile<String?>(
              title: Text(ans.ans,style: TextStyle(fontSize: 27.sp),),

              value: ans.ans,
              groupValue: _character,
              onChanged: (value) {
                setState(() {
                  _character = value!;
                });
              },
            ),
          ]
        ]);
  }

  Widget getCheckBoxWidget(Question item) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: HtmlDataWidget(
              item.question,
              quizId: widget.question.quizId,
            ),
          ),
          for(int i=0;i<item.ans!.length;i++)...[
            CheckBoxWidget(
              label: item.ans![i].ans,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _isSelected[i],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[i] = newValue;
                });
              },
            ),
          ]
        ]);
  }





  bool isFilled()
  {
    if (widget.question.type == QType.radio) {
    return  _character!='';
    }
    else{
     bool? b= _isSelected.firstWhereOrNull((element) => element);
     return b!=null;
    }
    }


  bool verifyCheck() {

    if (widget.question.type == QType.radio) {
      Answer? correctAnswer = widget.question.ans!.firstWhere(
              (ans) => ans.isCorrect == true);
       return  _character == correctAnswer.ans;
      }
    else {
      for (int i = 0; i < widget.question.ans!.length; i++) {
        if (widget.question.ans![i].isCorrect != _isSelected[i]) {
          return false;
        }
      }
      return true;
    }
  }

}
