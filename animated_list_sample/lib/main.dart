import 'package:animated_list_sample/data/todo_data.dart';
import 'package:animated_list_sample/model/todo.dart';
import 'package:animated_list_sample/widget/todo_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo animated list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoList(title: 'Todo animated list'),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final GlobalKey<AnimatedListState> _todoListKey =
      GlobalKey<AnimatedListState>();

  final List<Todo> todos = TodoData.todoDataList;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.8),
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(onPressed: _addNewTodo, icon: const Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: AnimatedList(
                    key: _todoListKey,
                    initialItemCount: todos.length,
                    itemBuilder: (context, index, animation) =>
                        buildItem(todos[index], index, animation)))
          ],
        ),
      );

  buildItem(Todo todo, int index, Animation<double> animation) => TodoWidget(
        todoItem: todo,
        animation: animation,
        onClicked: () => removeItem(index),
      );

  removeItem(int index) {
    final todo = todos.removeAt(index);
    _todoListKey.currentState!.removeItem(
        index, (context, animation) => buildItem(todo, index, animation));
  }

  void _addNewTodo() {
    final todo = Todo(
        description: "Lorem ipsum",
        id: todos.length,
        title: "Lorem ipsun",
        urlImage: 'https://picsum.photos/100/10' + todos.length.toString());

    todos.insert(todos.length - 1, todo);
    _todoListKey.currentState!.insertItem(todos.length - 1);
  }
}
