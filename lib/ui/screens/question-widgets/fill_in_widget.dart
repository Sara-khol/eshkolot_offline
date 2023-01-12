import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';
import 'dart:convert';

//TODO:create a dynamic fill-in question with unknown number of blanks

class FillIn extends StatefulWidget {
  final Questionnaire question;

  FillIn(this.question, {super.key});

  @override
  _FillInState createState() => _FillInState();
}

class _FillInState extends State<FillIn> {
  List<TextEditingController> myControllers = [];

  // late Map<String, List<String>> fillInQ;
  late Map<String, dynamic> fillInQ;

  @override
  void initState() {
    fillInQ = json.decode(widget.question.fillInQuestion!);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    for (var controller in myControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var english = RegExp(r'[a-zA-Z]');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Text(widget.question.question,
                style: const TextStyle(fontSize: 30, color: Colors.cyan)),
            const SizedBox(
              height: 35,
            ),
            Directionality(
              textDirection: english.hasMatch(fillInQ.keys.first.isNotEmpty
                      ? fillInQ.keys.first
                      : fillInQ.keys.length > 1
                          ? fillInQ.keys.elementAt(1)
                          : '')
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildDisplay(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                if (validAnswer())
                  return const AlertDialog(
                      content: Text('Correct'), backgroundColor: Colors.green);
                else {
                  return const AlertDialog(
                      content: Text('Incorrect'), backgroundColor: Colors.red);
                }
              });
        },
        child: const Text('ans'), //Icon(Icons.search),
      ),
    );
  }

  buildDisplay() {
    List<Widget> children = [];
    fillInQ.forEach((key, value) {
      children.add(Text(key,style: TextStyle(fontSize: 25),));
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
        width: 50,
        height: 50,
        child: TextField(
            controller: controller,
            cursorColor:  Colors.black,
            textAlign: TextAlign.center,
             style: TextStyle(fontSize: 25),
            decoration:const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
                contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 15 ),
              isDense: true,
            )));
  }

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
}
