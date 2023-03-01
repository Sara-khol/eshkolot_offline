import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';


class OpenQuestion extends StatefulWidget {
  Questionnaire question;
  OpenQuestion(this.question,{super.key,});
  
  @override
  State<OpenQuestion> createState() => _OpenQuestionState();

}

class _OpenQuestionState extends State<OpenQuestion> {
  
  final myController = TextEditingController();
  String ans='';
  
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
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: TextField(
            controller: myController,
          ),
        )],
    );
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          ans=myController.text;
        },
        child: const Text('ans'),//Icon(Icons.search),
      ),*/
  }
}