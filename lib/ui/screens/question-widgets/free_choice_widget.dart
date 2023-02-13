import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';


class FreeChoice extends StatefulWidget {
 final Questionnaire question;
  FreeChoice(this.question,{super.key,});

  @override
  State<FreeChoice> createState() => _FreeChoiceState(question);

}

class _FreeChoiceState extends State<FreeChoice> {
  _FreeChoiceState(this.question);
  //final myList=['a','b','c','d','e','f','g'];
  final myController = TextEditingController();
  Questionnaire question;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Column(
        children:[
          //Spacer(),
          Text(question.question),
          TextField(
            controller: myController,
          )],),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) {
            if (question.ans!.contains(myController.text)) {
              return AlertDialog(content: Text('Correct'),backgroundColor: Colors.green);
            }
            else {
              return AlertDialog(content: Text('Incorrect'),backgroundColor: Colors.red);
            }
            },);
          },
        child: const Icon(Icons.check),
      ),

    );

  }
}
