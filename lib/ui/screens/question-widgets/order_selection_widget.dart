import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/questionnaire.dart';
import 'package:eshkolot_offline/models/dragging_question.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  DragQ q=DragQ(['c','a','b','d'],['a','b','c','d'],{});

  @override
  Widget build(BuildContext context) {

    for (var item in q.items){
      q.isDropped[item]=false;
    }
    print('my app ${q.isDropped}');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: const Color(0xFF02BB9F),
        // primaryColorDark: const Color(0xFF167F67),
        // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF167F67)),
      ),
      home: OrderSelectionWidget(q),
    );
  }
}

class OrderSelectionWidget extends StatefulWidget {
  DragQ question;
  OrderSelectionWidget(this.question,{super.key,});

  @override
  _OrderSelectionWidgetState createState() => _OrderSelectionWidgetState(question);

}

class _OrderSelectionWidgetState extends State<OrderSelectionWidget> {
  _OrderSelectionWidgetState(this.question);
  DragQ question;
  //Questionnaire question;

  @override
  Widget build(BuildContext context) {

    print('build ${question.isDropped}');
    return Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        for(var q in question.items)...[
                          Draggable<String>(
                            // Data is the value this Draggable stores.
                            data: q,
                            child: Container(
                              height: 50.0,
                              width: 80.0,
                              color: Colors.pinkAccent[100],
                              margin: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(
                                  q,
                                  textScaleFactor: 2,
                                ),
                              ),
                            ),
                            feedback: Material(
                              child: Container(
                                height: 50.0,
                                width: 80.0,

                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                ),
                                child:  Center(
                                  child: Text(
                                    q,
                                    textScaleFactor: 2,
                                  ),
                                ),
                              ),
                            ),
                            childWhenDragging: Container(
                              height: 50.0,
                              width: 80.0,
                              margin: EdgeInsets.all(10.0),
                            ),
                          ),
                        ],
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),


                  Row(
                    children: [
                      for(int i=0;i< question.items.length;i++)...[
                      DragTarget<String>(
                        builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                            ) {
                          return DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(12),
                            padding: EdgeInsets.all(6),
                            color: Colors.grey,
                            strokeWidth: 2,
                            dashPattern: [8],

                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                height: 50,
                                width: 80,
                                margin: EdgeInsets.all(10.0),
                                color: question.isDropped[question.items[i]]! ? Colors.pinkAccent[100] : null,
                                child: Center(
                                    child: Text(
                                      !question.isDropped[question.items[i]]! ? 'Drop' :
                                      question.ans[i],
                                      textScaleFactor: 2,
                                    )),
                              ),
                            ),
                          );
                        },
                        onAccept: (data) {
                          debugPrint(data);
                          setState(() {
                            //showSnackBarGlobal(context, 'Dropped successfully!');
                            question.isDropped[data] = true;
                            question.ans[i]=data;
                            print('onAccept${question.isDropped}');
                            print('onAccept${question.ans}');
                            print('data${data}');
                          });
                        },
                        onLeave: (data) {
                          //showSnackBarGlobal(context, 'Missed');
                        },
                      ),
                      ],
                    ],
                  ),
                  ],
                ),
              ],
          ),
        )
      )
    );
  }
}