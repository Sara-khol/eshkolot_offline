import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';


class OpenQuestion extends StatefulWidget {
  Questionnaire question;
  OpenQuestion(this.question,{super.key,});
  
  @override
  _OpenQuestionState createState() => _OpenQuestionState(question);

}

class _OpenQuestionState extends State<OpenQuestion> {
  _OpenQuestionState(this.question);
  
  final myController = TextEditingController();
  String ans='';
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
          ans=myController.text;
        },
        child: const Text('ans'),//Icon(Icons.search),
      ),
    );
  }
}