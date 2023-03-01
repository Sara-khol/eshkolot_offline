import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';


class FreeChoice extends StatefulWidget {
 final Questionnaire question;
  FreeChoice(this.question,{super.key,});

  @override
  State<FreeChoice> createState() => _FreeChoiceState();

}

class _FreeChoiceState extends State<FreeChoice> {

  final myController = TextEditingController();

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
        Text(widget.question.question),
        TextField(
          controller: myController,
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                showDialog(context: context, builder: (context) {
                  if (widget.question.ans!.contains(myController.text)) {
                    return AlertDialog(content: Text('Correct'),backgroundColor: Colors.green);
                  }
                  else {
                    return AlertDialog(content: Text('Incorrect'),backgroundColor: Colors.red);
                  }
                },);
              },
              child: const Icon(Icons.check),
            ),
          ],
        )*/],
    );

  }
}
