import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/dragging_question.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
  import 'package:flutter/foundation.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  DragQ q = DragQ(['c', 'a', 'b', 'd'], ['a', 'b', 'c', 'd'], {});

  @override
  Widget build(BuildContext context) {
    for (var item in q.items) {
      q.isDropped[item] = false;
    }
    print('my app ${q.isDropped}');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: OrderSelectionWidget(q),
    );
  }
}

class OrderSelectionWidget extends StatefulWidget {
  DragQ question;

  OrderSelectionWidget(
    this.question, {
    super.key,
  });

  @override
  _OrderSelectionWidgetState createState() =>
      _OrderSelectionWidgetState(question);
}

class _OrderSelectionWidgetState extends State<OrderSelectionWidget> {
  _OrderSelectionWidgetState(this.question);

  DragQ question;
  //late List<DragAndDropList> _contents;
  List<int> maxSimultaneousDrags=[];

  @override
  void initState() {
    // Generate a list
     maxSimultaneousDrags=List<int>.generate(question.items.length, (index) =>1);
    // _contents = List.generate(5, (index) {
    //   return DragAndDropList(
    //     header: Text('Header $index'),
    //     children: <DragAndDropItem>[
    //       DragAndDropItem(
    //         child: Text('$index.1'),
    //       ),
    //       DragAndDropItem(
    //         child: Text('$index.2'),
    //       ),
    //       DragAndDropItem(
    //         child: Text('$index.3'),
    //       ),
    //     ],
    //   );
    // });
    super.initState();
  }

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
                          for (int i = 0; i < question.items.length; i++) ...[
                            Draggable<String>(
                              maxSimultaneousDrags: maxSimultaneousDrags[i],
                              // Data is the value this Draggable stores.
                              data: question.items[i],
                              child: Container(
                                height: 50.0,
                                width: 80.0,
                                color: maxSimultaneousDrags[i]>0?Colors.pinkAccent[100]:Colors.grey[300],
                                margin: EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    question.items[i],
                                    textScaleFactor: 2,
                                  ),
                                ),
                              ),
                              feedback: Material(
                                child: Container(
                                  height: 50.0,
                                  width: 80.0,
                                  decoration: const BoxDecoration(
                                    color: Colors.pinkAccent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      question.items[i],
                                      textScaleFactor: 2,
                                    ),
                                  ),
                                ),
                              ),
                              childWhenDragging: Container(
                                height: 50.0,
                                width: 80.0,
                                color: maxSimultaneousDrags[i]>0?Colors.pinkAccent[100]:Colors.grey[200],
                                margin: EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    question.items[i],
                                    textScaleFactor: 2,
                                  ),
                                ),
                              ),
                              onDragCompleted: (){
                                maxSimultaneousDrags[i]=0;
                                setState(() {
                                  Container(
                                    height: 50.0,
                                    width: 80.0,
                                    margin: EdgeInsets.all(10.0),
                                    color: Colors.pinkAccent[50],
                                  );
                                });
                              },
                            ),
                          ],
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Expanded(
                    child: ReorderableListView(
                      buildDefaultDragHandles: false,
                      children:_listOfItems(),
                      onReorder: (int start, int current) {
                        // dragging from top to bottom

                        if (start < current) {
                          int end = current - 1;
                          String startItem = question.ans[start];
                          int i = 0;
                          int local = start;
                          do {
                            question.ans[local] = question.ans[++local];
                            i++;
                          } while (i < end - start);
                          question.ans[end] = startItem;
                        }
                        // dragging from bottom to top
                        else if (start > current) {
                          String startItem = question.ans[start];
                          for (int i = start; i > current; i--) {
                            question.ans[i] = question.ans[i - 1];
                          }
                          question.ans[current] = startItem;
                        }
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            )
        ),
        floatingActionButton: FloatingActionButton(

          onPressed: () {
            print('${question.ans} ${ question.positions}');
            showDialog(context: context, builder: (context) {
              if (listEquals(question.ans,question.positions)) {
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

  _listOfItems() {
    return [
      for (int i = 0; i < question.items.length; i++) ...[
        Container(
          color: Colors.black12,
          // key: Key("${_list[i]}"),
          key: Key(question.items[i]),
          child: ReorderableDragStartListener(
              index: i,
             // key: Key("${_list[i]}"),
              child: DragTarget<String>(
                builder: (BuildContext context, List<dynamic> accepted,
                    List<dynamic> rejected) {
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
                        color: question.ans[i] == '' ||
                                !question.isDropped[question.ans[i]]!
                            ? null
                            : Colors.pinkAccent[100],
                        child: Center(
                            child: Text(
                          question.ans[i] == '' ||
                                  !question.isDropped[question.ans[i]]!
                              ? 'Drop'
                              : question.ans[i],
                          textScaleFactor: 2,
                        )),
                      ),
                    ),
                  );
                },
                onAccept: (data) {
                  debugPrint(data);
                  setState(() {
                    question.isDropped[data] = true;
                    question.ans[i] = data;
                    print('onAccept${question.isDropped}');
                    print('onAccept${question.ans}');
                    print('data${data}');
                  }
                );
              },
            )
          ),
        )
      ]
    ];
  }
}
