import 'package:flutter/material.dart';
import 'package:eshkolot_offline/models/dragging_question.dart';
import 'package:flutter/foundation.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  DragQ q = DragQ(['c', 'a', 'b', 'd'], ['a', 'b', 'c', 'd'], {});

  @override
  Widget build(BuildContext context) {

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
  State<OrderSelectionWidget> createState() => _OrderSelectionWidgetState(question);
}

class _OrderSelectionWidgetState extends State<OrderSelectionWidget> {
  _OrderSelectionWidgetState(this.question);

  DragQ question;
  //late List<DragAndDropList> _contents;

  List<int> maxSimultaneousDrags=[];


  //Questionnaire question;

  @override
  void initState() {
    // Generate a list
    maxSimultaneousDrags=List<int>.generate(question.items.length, (index) =>1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  child: ReorderableListView(
                    //buildDefaultDragHandles: false,
                    children: _listOfItems(),
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final String item = question.items.removeAt(oldIndex);
                        question.items.insert(newIndex, item);
                      });
                    },
                  ),
                )
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          print('${question.items} ${ question.positions}');
          showDialog(context: context, builder: (context) {
            if (listEquals(question.items,question.positions)) {
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
        ListTile(
          tileColor: Colors.black12,
          key: Key(question.items[i]),
          title: Text(question.items[i]),
          ),
      ]
    ];
  }
}
