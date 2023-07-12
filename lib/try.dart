import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<String> list1 = ['Apple', 'Banana', 'Orange'];
  List<String> list2 = ['Red', 'Yellow', 'Orange'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Quiz'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ReorderableListView(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              children: List.generate(list1.length, (index) {
                return ListTile(
                  key: Key('$index'),
                  title: Text(list1[index]),
                  trailing: Icon(Icons.drag_handle),
                );
              }),
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final String item = list1.removeAt(oldIndex);
                  list1.insert(newIndex, item);
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              itemCount: list2.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(list2[index]),
                  onTap: () {
                    if (index < list1.length) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Match'),
                            content: Text(
                                'You matched ${list1[index]} with ${list2[index]}.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
