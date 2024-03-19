import 'package:eshkolot_offline/ui/custom_widgets/html_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/checkbox_widget.dart';
import 'package:eshkolot_offline/models/quiz.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../course_main/questionnaire_tab.dart';

class RadioCheck extends StatefulWidget {
  const RadioCheck(this.question,
      {super.key, required this.questionController});

  final Question question;
  final QuestionController questionController;

  @override
  State<RadioCheck> createState() => _RadioCheckState();
}

class _RadioCheckState extends State<RadioCheck> {
  String _character = '';

  List<bool> _isSelected = [];

  @override
  void initState() {
    super.initState();
    widget.questionController.isFilled = isFilled;
    widget.questionController.isCorrect = verifyCheck;

    _isSelected = List<bool>.filled(widget.question.ans!.length, false);


    if (widget.question.type == QType.checkbox) {
      _isSelected = List<bool>.filled(widget.question.ans!.length, false);

      int i = 0;
      for (Answer answer in widget.question.ans!) {
        _isSelected[i] = answer.isSelected;
        i++;
      }
    }
    // _character = '';
    //_character= widget.question.ans!.firstWhereOrNull((element) => element.isSelected).ans??'';
    else {
      _character = widget.question.ans!
          .firstWhereOrNull((element) => element.isSelected)
          ?.ans ??
          '';
    }
  }

  @override
  void didUpdateWidget(covariant RadioCheck oldWidget) {
    if (oldWidget.question != widget.question) {
     if (widget.question.type == QType.checkbox) {
       _isSelected = List<bool>.filled(widget.question.ans!.length, false);

       int i = 0;
        for (Answer answer in widget.question.ans!) {
          _isSelected[i] = answer.isSelected;
          i++;
        }
      }
      // _character = '';
      //_character= widget.question.ans!.firstWhereOrNull((element) => element.isSelected).ans??'';
     else {
        _character = widget.question.ans!
                .firstWhereOrNull((element) => element.isSelected)
                ?.ans ??
            '';
    }
    }
    widget.questionController.isFilled = isFilled;
    widget.questionController.isCorrect = verifyCheck;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Column(children: <Widget>[
          widget.question.type == QType.checkbox
              ? getCheckBoxWidget(widget.question)
              : getRadioWidget(widget.question),
        ]));
  }

  Widget getRadioWidget(Question item, [bool displayAnswer = false]) {
    bool isCorrect = false;
    isCorrect = verifyCheck()==widget.question.points;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
              alignment: Alignment.centerRight,
              child: HtmlDataWidget(item.question, quizId: item.quizId)),
          SizedBox(height: 30.h),
          for (var ans in item.ans!) ...[
            Container(
              margin: EdgeInsets.only(bottom: displayAnswer ? 10.h : 0),
              decoration: displayAnswer
                  ? BoxDecoration(
                      border: Border.all(
                          color: ans.isCorrect
                              ? Colors.green
                              : ans.isSelected
                                  ? Colors.blue
                                  : Colors.transparent))
                  : null,
              child: RadioListTile<String?>(
                // title: Text(ans.ans,style: TextStyle(fontSize: 27.sp),),
                title: HtmlDataWidget(
                  ans.ans,
                  quizId: item.quizId,
                ),

                value: ans.ans,
                groupValue: _character,
                onChanged: displayAnswer
                    ? null
                    : (value) {
                        setState(() {
                          _character = value!;
                          item.ans!
                              .firstWhereOrNull((element) => element.isSelected)
                              ?.isSelected = false;
                          ans.isSelected = true;
                        });
                      },
              ),
            ),
          ],
          if (displayAnswer)
            Container(
              height: 80.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: isCorrect
                      ? Colors.greenAccent.withOpacity(0.5)
                      : Colors.redAccent.withOpacity(0.5)),
              child: Center(
                  child: Text(
                isCorrect ? 'תשובה נכונה!' : 'תשובה לא נכונה',
                style: TextStyle(fontSize: 20.sp),
              )),
            ),
        ]);
  }

  Widget getCheckBoxWidget(Question item, [bool displayAnswer = false]) {
    bool isCorrect=false;
    if(displayAnswer) {
       isCorrect = verifyCheck() == widget.question.points;
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: HtmlDataWidget(
              item.question,
              quizId: widget.question.quizId,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          for (int i = 0; i < item.ans!.length; i++) ...[
            Container(
              margin: EdgeInsets.only(bottom: displayAnswer ? 10.h : 0),
              decoration: displayAnswer
                  ? BoxDecoration(
                      border: Border.all(
                          color: item.ans![i].isCorrect
                              ? Colors.green
                              : item.ans![i].isSelected
                                  ? Colors.blue
                                  : Colors.transparent))
                  : null,
              child: CheckBoxWidget(
                quizId: widget.question.quizId,
                label: item.ans![i].ans,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                value: _isSelected[i],
                onChanged: !displayAnswer?(bool newValue) {
                  setState(() {
                    _isSelected[i] = newValue;
                    item.ans![i].isSelected = true;
                  });
                }:null,
              ),
            ),
          ],
          if (displayAnswer)
            Container(
              height: 80.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: isCorrect
                      ? Colors.greenAccent.withOpacity(0.5)
                      : Colors.redAccent.withOpacity(0.5)),
              child: Center(
                  child: Text(
                    isCorrect ? 'תשובה נכונה!' : widget.question.points==1?'תשובה לא נכונה':'אחת או יותר מהתשובות לא נכונות',
                    style: TextStyle(fontSize: 20.sp),
                  )),
            ),
        ]);
  }

  bool isFilled() {
    if (widget.question.type == QType.radio) {
      if (_character.isNotEmpty) {
        widget.questionController.displayWithAnswers = displayWithAnswers();
      }
      return _character.isNotEmpty;
    } else {
      bool? b = _isSelected.firstWhereOrNull((element) => element);
      if (b != null) {
        widget.questionController.displayWithAnswers = displayWithAnswers();
      }
      return b != null;
    }
  }

  int verifyCheck() {
    if (widget.question.type == QType.radio) {
      Answer? correctAnswer =
          widget.question.ans!.firstWhere((ans) => ans.isCorrect == true);
      return _character == correctAnswer.ans?widget.question.points:0;
    } else {
      if(widget.question.points>1) {
        int numPoints = 0;
        for (int i = 0; i < widget.question.ans!.length; i++) {
          if (widget.question.ans![i].isCorrect == _isSelected[i]) {
            numPoints += widget.question.ans![i].points;
          }
        }
        return numPoints;
      }
      else {
        for (int i = 0; i < widget.question.ans!.length; i++) {
          if (widget.question.ans![i].isCorrect != _isSelected[i]) {
            return 0;
          }
        }
          return widget.question.points; //(always 1)


        // for (int i = 0; i < widget.question.ans!.length; i++) {
        //   if (widget.question.ans![i].isCorrect != _isSelected[i]) {
        //     return false;
        //   }
        // }
        // return true;
      }
    }
  }

  displayWithAnswers() {
    return Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Column(children: <Widget>[
          widget.question.type == QType.checkbox
              ? getCheckBoxWidget(widget.question, true)
              : getRadioWidget(widget.question, true),
        ]));
  }
}
