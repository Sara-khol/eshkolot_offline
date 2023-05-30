import 'package:eshkolot_offline/models/%D7%95upgraded_editor_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final q=UpgradedEditor(
    'question',85,200,
      [Image1(Offset(10,10),'assets/images/img.jpg',100,500)],
      [TextBox1(Offset(50,50), 1, '?', '5', CorrectAnsPosition.above, 2, false, TextDecoration.none, 16, Colors.blue,
      Colors.transparent, TextDirection.rtl, TextAlign.center, 50, 5, 50),
        TextBox1(Offset(100,100), 2, '?', '8', CorrectAnsPosition.above, 2, true, TextDecoration.none, 16, Colors.blue,
          Colors.transparent, TextDirection.rtl, TextAlign.center, 100, 2, 100)],
      );


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: UpgradedEditorQuestion(q),
    );
  }
}

class UpgradedEditorQuestion extends StatefulWidget {
  UpgradedEditor question;

  UpgradedEditorQuestion(
      this.question, {
        super.key,
      });

  @override
  State<UpgradedEditorQuestion> createState() => _UpgradedEditorQuestionState(question);
}

class _UpgradedEditorQuestionState extends State<UpgradedEditorQuestion> {
 _UpgradedEditorQuestionState(this.question);

  UpgradedEditor question;
  //List<String> ans=[];
  @override
  Widget build(BuildContext context) {
    for( int i=0;i<question.txtbox.length;i++) {
      question.ans[i] = question.txtbox[i].correctAns;
    }
    debugPrint('${question.anss}  ${question.ans}');
    return Scaffold(
      appBar: AppBar(title: Text(question.question)),
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children:<Widget>[
          for (int i=0;i<question.images.length;i++)...[
            Positioned(
              top: question.images[i].offset.dx,
              left: question.images[i].offset.dy,
              //width: question.images[0].width,
              child:
                Image.asset(
                    // color: Colors.white.withOpacity(0.5),
                    // colorBlendMode: BlendMode.modulate,
                  question.images[i].path,
                    //fit: BoxFit.none,
                  width: question.images[i].width
                ),
              ),
            ],
            for (int i=0;i<question.txtbox.length;i++)...[
              Positioned(
                height: question.txtbox[i].height,
                width: question.txtbox[i].maxWidth,
                top: question.txtbox[i].offset.dx,
                left: question.txtbox[i].offset.dy,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      //labelText: txtbox.hint,
                      hintText: question.txtbox[i].hint
                  ),
                  textAlign: question.txtbox[i].align,
                  maxLength: question.txtbox[i].maxChar,
                  textDirection: question.txtbox[i].direction,
                  style: TextStyle(
                    decoration: question.txtbox[i].txtdeco,
                    fontSize: question.txtbox[i].fontSize,
                    color: question.txtbox[i].color,
                    backgroundColor: question.txtbox[i].backgroundColor,
                    fontWeight: question.txtbox[i].bold?FontWeight.bold:FontWeight.normal
                  ),
                  onChanged: (txt){
                    debugPrint(question.anss.toString());
                    question.anss[i]=txt;
                  },
                ),
              )
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          debugPrint('${question.anss} ${question.ans}');
          showDialog(context: context, builder: (context) {
            if (listEquals(question.anss,question.ans)) {
              return const AlertDialog(content: Text('Correct'));
            }
            else {
              return const AlertDialog(content: Text('Incorrect'));
            }
          },);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}


