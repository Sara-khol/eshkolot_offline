import 'package:flutter/material.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/checkbox_widget.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioCheck extends StatefulWidget {
  RadioCheck(this.question, {super.key});

  Questionnaire question;

  @override
  State<RadioCheck> createState() => _RadioCheckState(/*question*/);
}

class _RadioCheckState extends State<RadioCheck> {

  String _character = '';

  List<bool> _isSelected=[];

  void initState(){

    for(int i=0;i<widget.question.options!.length;i++){
      _isSelected.add(false);
    }
    print(_isSelected);
  }

  // bool _isSelectedA = false;
  // bool _isSelectedB = false;
  // bool _isSelectedC = false;
  // bool _isSelectedD = false;

  int radio = 1;
  int check = 2;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
           widget.question.type == QType.checkbox
              ? getCheckBoxWidget(widget.question)
              : getRadioWidget(widget.question),
          SizedBox(
            height: 30.h,
          ),
          actionButton(),
        ]));
  }

  Widget getRadioWidget(Questionnaire item) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                item.question,
                textAlign: TextAlign.right,
                style: TextStyle(color: Color.fromARGB(255, 45, 40, 40),fontSize: 27.w),
              )),
          for(var option in item.options!)...[
            RadioListTile<String?>(
              title: Text(option),
              value: option,
              groupValue: _character,
              onChanged: (value) {
                setState(() {
                  _character = value!;
                });
              },
            ),
          ]
          /*RadioListTile<String?>(
            title: Text(item.optionB!),
            value: item.optionB,
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value!;
              });
            },
          ),
          RadioListTile<String?>(
            title: Text(item.optionC!),
            value: item.optionC,
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value!;
              });
            },
          ),
          RadioListTile<String?>(
            title: Text(item.optionD!),
            value: item.optionD,
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value!;
              });
            },
          ),*/
        ]);
  }

  Widget getCheckBoxWidget(Questionnaire item) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              item.question,
              textAlign: TextAlign.left,
            ),
          ),
          for(int i=0;i<item.options!.length;i++)...[
            CheckBoxWidget(
              label: item.options![i],
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _isSelected[i],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[i] = newValue;
                });
              },
            ),
          ]
          /*CheckBoxWidget(
            label: item.optionB!,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: _isSelectedB,
            onChanged: (bool newValue) {
              setState(() {
                _isSelectedB = newValue;
              });
            },
          ),
          CheckBoxWidget(
            label: item.optionC!,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: _isSelectedC,
            onChanged: (bool newValue) {
              setState(() {
                _isSelectedC = newValue;
              });
            },
          ),
          CheckBoxWidget(
            label: item.optionD!,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: _isSelectedD,
            onChanged: (bool newValue) {
              setState(() {
                _isSelectedD = newValue;
              });
            },
          ),*/
        ]);
  }

  Widget actionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF167F67)),
          child: Text(
            "Verify",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => onVerifyClick(),
        ),
      ],
    );
  }

  onVerifyClick() {
    var msg = "";
    final answers = [];
    if (widget.question.type == QType.radio) {
      if (_character == widget.question.ans![0]) {
        msg = "Correct";
      } else {
        msg = "Incorrect";
      }
    }
    else {
      for(int i=0;i<widget.question.options!.length;i++){
        if (_isSelected[i]) answers.add(widget.question.options![i]);
      }
      Function eq = const DeepCollectionEquality.unordered().equals;
      debugPrint('answers${answers}');
      debugPrint('widget.question.ans${widget.question.ans}');

      if (eq(answers, widget.question.ans)) {
        msg = "Correct";
      } else {
        msg = "Incorrect";
      }
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(content: Text(msg),);
      },
    );
  }
}
