import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';

//TODO:create a dynamic fill-in question with unknown number of blanks

class FillIn extends StatefulWidget {
  Questionnaire question;
  FillIn(this.question,{super.key});

  @override
  _FillInState createState() => _FillInState(question);

}

class _FillInState extends State<FillIn> {
  _FillInState(this.question);
  Questionnaire question;

  int numOfBlanks=2;
  //final myList=['a','b','c','d','e','f','g'];
   //HashMap<int,List<String>> hm=new HashMap<int,List<String>>;

  List<TextEditingController> myControllers = [];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    for( var controller in myControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 1; i < numOfBlanks; i++) myControllers.add(TextEditingController());
    print("myControllers.length ${myControllers.length}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Row(
        children:<Widget>[
          //Spacer(),
          Text('Fill in the blanks: a,b ${Expanded(
          child: TextField(
            controller: myControllers[0],
          )
          )
              }'),

          Text('d,e'),
          Expanded(
              child: TextField(
                controller: myControllers[1],
              )
          )
        ],),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) {
            if (question.ans!.contains(myControllers[0].text)&&question.ans!.contains(myControllers[1].text)) {
              return AlertDialog(content: Text('Correct'),backgroundColor: Colors.green);
            }
            else {
              return AlertDialog(content: Text('Incorrect'),backgroundColor: Colors.red);
            }
          },);
        },
        child: const Text('ans'),//Icon(Icons.search),
      ),

    );
  }
}
