import 'package:flutter/material.dart';

import '../../../models/lesson.dart';

class LessonWidget  extends StatelessWidget {

  final Lesson lesson;

   const LessonWidget({super.key, required this.lesson});


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const Text('שיעור'),
        Text(lesson.name),
      ],
    ) ;
  }
}
