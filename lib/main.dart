import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter ToDo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _todoList = <String>[];
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (BuildContext context, int index) {
                final todo = _todoList[index];
                return Dismissible(
                  key: Key(todo),
                  onDismissed: (direction) {
                    setState(() {
                      _todoList.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("$todo dismissed")));
                  },
                  background: Container(color: Colors.red),
                  child: ListTile(title: Text(todo)),
                );
              },
            ),
          ),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Enter task',
            ),
            onSubmitted: (text) {
              setState(() {
                if (text.isNotEmpty) {
                  _todoList.add(text);
                  _textController.clear();
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
