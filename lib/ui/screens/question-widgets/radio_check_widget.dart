import 'package:flutter/material.dart';
import 'package:eshkolot_offline/ui/screens/question-widgets/checkbox_widget.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:collection/collection.dart';

class RadioCheck extends StatefulWidget {
  Questionnaire question;

  RadioCheck(this.question, {super.key});

  @override
  _RadioCheckState createState() => _RadioCheckState(question);
}

class _RadioCheckState extends State<RadioCheck> {
  _RadioCheckState(this.item);

  Questionnaire item;

  // AppEnum _character = AppEnum.NON;
  String _character = '';

  bool _isSelectedA = false;
  bool _isSelectedB = false;
  bool _isSelectedC = false;
  bool _isSelectedD = false;

  int radio = 1;
  int check = 2;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          item.type == QType.checkbox
              ? getCheckBoxWidget(item)
              : getRadioWidget(item),
          SizedBox(
            height: 30.0,
          ),
          actionButton(),
        ]));
  }

  Widget getRadioWidget(Questionnaire item) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item.question,
                textAlign: TextAlign.left,
              )),
          RadioListTile<String?>(
            title: Text(item.optionA!),
            value: item.optionA,
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value!;
              });
            },
          ),
          RadioListTile<String?>(
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
          ),
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
          CheckBoxWidget(
            label: item.optionA!,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: _isSelectedA,
            onChanged: (bool newValue) {
              setState(() {
                _isSelectedA = newValue;
              });
            },
          ),
          CheckBoxWidget(
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
          ),
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
    if (item.type == QType.radio) {
      if (_character == item.ans![0]) {
        // if (_character == AppEnum.optionA && item.optionA == item.ans[0] ||
        //     _character == AppEnum.optionB && item.optionB == item.ans[0] ||
        //     _character == AppEnum.optionC && item.optionC == item.ans[0] ||
        //     _character == AppEnum.optionD && item.optionD == item.ans[0]){
        msg = "Correct";
      } else {
        msg = "Incorrect";
      }
    } else {
      if (_isSelectedA) answers.add(item.optionA);
      if (_isSelectedB) answers.add(item.optionB);
      if (_isSelectedC) answers.add(item.optionC);
      if (_isSelectedD) answers.add(item.optionD);
      Function eq = const DeepCollectionEquality.unordered().equals;
      print('answers${answers}');
      print('item.ans${item.ans}');

      if (eq(answers, item.ans)) {
        msg = "Correct";
      } else {
        msg = "Incorrect";
      }
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(content: Text(msg), backgroundColor: Colors.green);
      },
    );
  }
}
