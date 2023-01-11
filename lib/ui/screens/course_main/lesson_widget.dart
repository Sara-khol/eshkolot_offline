import 'package:eshkolot_offline/isar_service.dart';
import 'package:flutter/material.dart';

import '../../../models/lesson.dart';

class LessonWidget extends StatefulWidget {
  final Lesson lesson;
  final Function() notifyParent;

  LessonWidget({super.key, required this.lesson, required this.notifyParent});

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
            onPressed: () async{
              if (!widget.lesson.isCompleted) {
                  widget.lesson.isCompleted = true;
                  print('pressed id ${widget.lesson.id}');
                await IsarService.instance.updateLesson(widget.lesson.id);
                setState(() {});
                widget.notifyParent();
              }
            },
            style: TextButton.styleFrom(backgroundColor: Colors.teal),
            child: Text(
                widget.lesson.isCompleted ? 'השיעור הושלם' : 'סמן כהושלם',
                style: TextStyle(color: Colors.white)))
      ],
    );
  }
}
