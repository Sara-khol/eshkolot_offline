import 'package:flutter/material.dart';

import '../../../models/lesson.dart';

class LessonWidget extends StatefulWidget {
  final Lesson lesson;

  LessonWidget({super.key, required this.lesson});

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 50,
          color: Colors.amber,
          child: Center(
            child: Text(
              ' שיעור ${widget.lesson.name}',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
        SizedBox(height: 15),
        TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(backgroundColor: Colors.teal,),
            child: const Text('סמן כהושלם',style: TextStyle(color: Colors.white),))
      ],
    );
  }
}
