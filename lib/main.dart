import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todos = [];
  TextEditingController _textEditingController = TextEditingController();
  List<bool> checkedState = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        backgroundColor: Color(0xFFF5F5DC),
      ),
      body: Container(
        color: Colors.brown,
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(todos[index]),
              onDismissed: (direction) {
                setState(() {
                  todos.removeAt(index);
                  checkedState.removeAt(index);
                });
              },
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.black87,
                  ),
                ),
              ),
              child: Card(
                color: Color(0xFFF5F5DC),
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    todos[index],
                    style: TextStyle(color: Colors.black87),
                  ),
                  value: checkedState.length > index ? checkedState[index] : false,
                  onChanged: (bool? value) {
                    if (value != null) {
                      setState(() {
                        checkedState[index] = value;
                      });

                      if (value) {
                        Timer(Duration(milliseconds: 500), () {
                          setState(() {
                            todos.removeAt(index);
                            checkedState.removeAt(index);
                          });
                        });
                      }
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addTodo();
        },
        label: Text('Add Todo'),
        icon: Icon(Icons.add),
      ),
    );
  }

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textEditingController,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Enter a todo',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_textEditingController.text.isNotEmpty) {
                    setState(() {
                      todos.add(_textEditingController.text);
                      checkedState.add(false);
                      _textEditingController.clear();
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }
}
