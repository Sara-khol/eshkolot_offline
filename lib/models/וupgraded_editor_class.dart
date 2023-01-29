
import 'dart:ui';

import 'package:flutter/material.dart';

class UpgradedEditor{

  late String question;

  late int length;
  late int width;

  late List<Image1> images=[];
  late List<TextBox1> txtbox=[];
  late List<String> anss=[];
  late List<String> ans=[];

  UpgradedEditor(this.question,this.length,this.width,this.images,this.txtbox):
        anss=List<String>.generate(txtbox.length, (index) => ''),
        ans=List<String>.generate(txtbox.length, (index) => '');
}

class Image1{

  late Offset offset;

  late String path;
  late double height;
  late double width;

  Image1(this.offset,this.path,this.height,this.width);
}

class TextBox1{

  late Offset offset;

  late int id;
  late String hint;//
  late String correctAns;
  late CorrectAnsPosition position;
  late int pts;

  //style
  late bool bold;//
  late TextDecoration txtdeco;//
  late double fontSize;//
  late Color color;//
  late Color backgroundColor;//
  late TextDirection direction;//
  late TextAlign align;//
  late double maxWidth;
  late int maxChar;//
  late double height;//

 TextBox1(this.offset,this.id,this.hint,this.correctAns,this.position,this.pts,
     this.bold,this.txtdeco,this.fontSize,this.color,this.backgroundColor,this.direction,
     this.align,this.maxWidth,this.maxChar,this.height);

}

enum CorrectAnsPosition{above,under}
//enum Style{crossLine, bottomLine, inclined, none}
//enum Direction{rtl,ltr}
//enum Align{right, left,center}



