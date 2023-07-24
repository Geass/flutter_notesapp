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
  final _todoList = <Map<String, String>>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (BuildContext context, int index) {
          final todo = _todoList[index];
          return Dismissible(
            key: Key(todo['title']!),
            onDismissed: (direction) {
              setState(() {
                _todoList.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${todo['title']} dismissed")));
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(todo['title']!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetailPage(note: todo),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to the AddNotePage when the button is tapped
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotePage()),
          );
          // Add the new note to the list if it is not null
          if (result != null) {
            setState(() {
              _todoList.add({'title': result[0], 'content': result[1]});
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Save the note and navigate back to the home page
                Navigator.pop(
                    context, [_titleController.text, _contentController.text]);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteDetailPage extends StatelessWidget {
  final Map<String, String> note;

  NoteDetailPage({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note['title']!,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8.0),
            Text(note['content']!),
          ],
        ),
      ),
    );
  }
}
