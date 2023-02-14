

import 'package:flutter/material.dart';

class CourseLd
{
 late int id;
 late String title;
 late int knowledge;//תחום מתמטיקה , אנגלית וכו
 late String course_disable_lesson_progression;// צורת אפשרית למעבר ביו שיעורים
 late String steps;// לינק לנושאים
 late String users;// לינק למשתמשים
 late String groups;// לינק לקבוצות המשתמשים , לבדוק אם צריך..
}


class KnowledgeLd
{
 late int id;
 late String title;
 late IconData  icon;
 late int color;
 late List<CourseLd> courses;

 KnowledgeLd(this.id, this.title, this.icon, this.color,this.courses);
}