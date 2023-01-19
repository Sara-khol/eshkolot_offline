import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/dragging_question.dart';
<<<<<<< HEAD
//import 'package:flutter/foundation.dart';
=======
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

>>>>>>> 287dbb7f58175202e5f16f64dce39213758af7b8

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
  late List<DragAndDropList> _contents;
  List<String> _list = ["Apple", "Ball", "Cat", "Dog", "Elephant"];

  //Questionnaire question;

  @override
  void initState() {
    // Generate a list
    _contents = List.generate(5, (index) {
      return DragAndDropList(
        header: Text('Header $index'),
        children: <DragAndDropItem>[
          DragAndDropItem(
            child: Text('$index.1'),
          ),
          DragAndDropItem(
            child: Text('$index.2'),
          ),
          DragAndDropItem(
            child: Text('$index.3'),
          ),
        ],
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build ${question.isDropped}');
    return Scaffold(
<<<<<<< HEAD
        body: Center(
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
                              color:  question.ans[i]=='' ||!question.isDropped[question.ans[i]]!  ? null:Colors.pinkAccent[100],
                              child: Center(
                                  child: Text(
                                    question.ans[i]=='' ||!question.isDropped[question.ans[i]]! ? 'Drop' :
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
                          print('data $data');
                        });
                      },
                      onLeave: (data) {
                        //question.isDropped[data!] = false;
                        print('$data is left');
                      },
                    ),
                    ],
                  ],
                ),
                ],
              ),
            ],
        ),
        ),

    );
=======
        body: Container(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  for (var q in question.items) ...[
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
                          child: Center(
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
                  for (int i = 0; i < question.items.length; i++) ...[
                    DragTarget<String>(
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
                          //showSnackBarGlobal(context, 'Dropped successfully!');
                          question.isDropped[data] = true;
                          question.ans[i] = data;
                          print('onAccept${question.isDropped}');
                          print('onAccept${question.ans}');
                          print('data${data}');
                        });
                      },
                      onLeave: (data) {
                        print('bjkhk');
                      },
                    ),
                  ],
                ],
              ),
            ],
          ),
          // Expanded(
          //   child: DraggableGridViewBuilder(
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 1,
          //       childAspectRatio: MediaQuery.of(context).size.width /
          //           (MediaQuery.of(context).size.height / 10),
          //     ),
          //     children: _listOfDraggableGridItem(),
          //     isOnlyLongPress: false,
          //     dragCompletion: (List<DraggableGridItem> list, int beforeIndex,
          //         int afterIndex) {
          //       print('onDragAccept: $beforeIndex -> $afterIndex');
          //     },
          //     dragFeedback: (List<DraggableGridItem> list, int index) {
          //       return Container(
          //         child: list[index].child,
          //         width: 200,
          //         height: 150,
          //       );
          //     },
          //     dragPlaceHolder: (List<DraggableGridItem> list, int index) {
          //       return PlaceHolderWidget(
          //         child: Container(
          //           color: Colors.white,
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // Container(height: 30,color: Colors.deepOrange,),
          SizedBox(height: 30,),
          Expanded(
            child: ReorderableListView(
              buildDefaultDragHandles: false,
              children:_listOfItems(),/* <Widget>[
                for (int index = 0; index < _list.length; index++)
                  ReorderableDragStartListener(
                    key: Key("${_list[index]}"),
                    index: index,
                    child: ListTile(
                      title: Text("${_list[index]}"),
                      //  trailing: Icon(Icons.menu),
                    ),
                  )
              ],*/
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
    )));
>>>>>>> 287dbb7f58175202e5f16f64dce39213758af7b8
  }

  _listOfDraggableGridItem() {
    return [
      for (int i = 0; i < question.items.length; i++) ...[
        DraggableGridItem(
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
                  //showSnackBarGlobal(context, 'Dropped successfully!');
                  question.isDropped[data] = true;
                  question.ans[i] = data;
                  print('onAccept${question.isDropped}');
                  print('onAccept${question.ans}');
                  print('data${data}');
                });
              },
              onLeave: (data) {
              },
            ),
            isDraggable: true),
      ]
    ];
  }

  _listOfItems() {
    return [
      for (int i = 0; i < question.items.length; i++) ...[
        Container(
          color: Colors.black12,
          key: Key("${_list[i]}"),
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
                    //showSnackBarGlobal(context, 'Dropped successfully!');
                    question.isDropped[data] = true;
                    question.ans[i] = data;
                    print('onAccept${question.isDropped}');
                    print('onAccept${question.ans}');
                    print('data${data}');
                  });
                },
                onLeave: (data) {
                  print('bjkhk');
                },
              )),
        )
      ]
    ];
  }
}
