import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/dragging_question.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  State<OrderSelectionWidget> createState() => _OrderSelectionWidgetState();
}

class _OrderSelectionWidgetState extends State<OrderSelectionWidget> {

  List<int> maxSimultaneousDrags = [];

  @override
  void initState() {
    // Generate a list
    maxSimultaneousDrags =
        List<int>.generate(widget.question.items.length, (index) => 1);
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
    print('build ${widget.question.isDropped}');
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt:true,
      builder: (BuildContext context, Widget? child) {
      return Scaffold(
      backgroundColor:Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      for (int i = 0; i < widget.question.items.length; i++) ...[
                        Draggable<String>(
                          maxSimultaneousDrags: maxSimultaneousDrags[i],
                          // Data is the value this Draggable stores.
                          data: widget.question.items[i],
                          feedback: Material(
                            child: Container(
                            height: 40.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color:
                                    const Color.fromARGB(255, 45, 40, 40))),
                            //margin: EdgeInsets.all(10.0),
                            child: Center(
                              child: Row(
                                children: [
                                  Icon(Icons.menu),
                                  Text(
                                    widget.question.items[i],
                                    textScaleFactor: 2.w,
                                    textAlign:  TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ),
                          childWhenDragging: Container(
                            height: 40.h,
                            width: 80.w,
                           /*color: maxSimultaneousDrags[i] > 0
                                ? Colors.pinkAccent[100]
                                : Colors.grey[200],*/
                            margin: EdgeInsets.all(10.0),
                            child: Center(
                              child: Row(
                                children: [
                                  Icon(Icons.menu),
                                  Text(
                                    widget.question.items[i],
                                    textScaleFactor: 2.w,
                                    textAlign:  TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onDragCompleted: () {
                            maxSimultaneousDrags[i] = 0;
                            setState(() {
                              Container(
                                height: 40.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color:
                                        const Color.fromARGB(255, 45, 40, 40))),
                                margin: EdgeInsets.all(10.0),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.menu),
                                      Text(
                                        widget.question.items[i],
                                        textScaleFactor: 2.w,
                                        textAlign:  TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                          child: Container(
                            height: 40.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 45, 40, 40))),
                            margin: EdgeInsets.all(10.0),
                            child: Center(
                              child: Row(
                                children: [
                                  Icon(Icons.menu),
                                  Text(
                                    widget.question.items[i],
                                    textScaleFactor: 2.w,
                                    textAlign:  TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),

              for (int i = 0; i < widget.question.items.length; i++) ...[
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: SizedBox(
                    height: 50.h,
                    child: Row(
                      children: [
                        Container(
                          width: 70.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromARGB(255, 200, 201, 206)),
                            color: Colors.transparent,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width-70.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromARGB(255, 200, 201, 206)),
                            color: Colors.transparent,
                          ),
                          //TODO: child: DragTarget(onAccept: ,),
                          child: DragTarget<String>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ){
                              return ClipRRect(
                                child: Text(
                                  widget.question.isDropped[widget.question.items[i]]!?widget.question.ans[i]:'drop',
                                ),
                              );
                            },
                            onAccept: (data){
                              print(data);
                              setState(() {
                                widget.question.isDropped[data] = true;
                                widget.question.ans[i] = data;
                              });
                              print('widget.question.isDropped[${widget.question.items[i]}] ${widget.question.isDropped[widget.question.items[i]]!}');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]
              /*  Expanded(
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
                )*/
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('${widget.question.ans} ${widget.question.positions}');
            showDialog(
              context: context,
              builder: (context) {
                if (listEquals(widget.question.ans, widget.question.positions)) {
                  return const AlertDialog(content: Text('Correct'));
                } else {
                  return const AlertDialog(content: Text('Incorrect'));
                }
              },
            );
          },
          child: const Icon(Icons.check),
        ),
      );
    });
  }

  _listOfItems() {
    return [
      for (int i = 0; i < widget.question.items.length; i++) ...[
        Container(
          color: Colors.black12,
          // key: Key("${_list[i]}"),
          key: Key(widget.question.items[i]),
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
                        color: widget.question.ans[i] == '' ||
                                !widget.question.isDropped[widget.question.ans[i]]!
                            ? null
                            : Colors.pinkAccent[100],
                        child: Center(
                            child: Text(
                          widget.question.ans[i] == '' ||
                                  !widget.question
                                      .isDropped[widget.question.ans[i]]!
                              ? 'Drop'
                              : widget.question.ans[i],
                          textScaleFactor: 2,
                        )),
                      ),
                    ),
                  );
                },
                onAccept: (data) {
                  debugPrint(data);
                  setState(() {
                    widget.question.isDropped[data] = true;
                    widget.question.ans[i] = data;
                    print('onAccept${widget.question.isDropped}');
                    print('onAccept${widget.question.ans}');
                    print('data${data}');
                  });
                },
              )),
        )
      ]
    ];
  }
}
