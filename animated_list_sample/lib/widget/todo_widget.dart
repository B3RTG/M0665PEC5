import 'package:animated_list_sample/model/todo.dart';
import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  final Todo todoItem;
  final Animation<double> animation;
  final VoidCallback onClicked;

  const TodoWidget(
      {Key? key,
      required this.todoItem,
      required this.animation,
      required this.onClicked})
      : super(key: key);
  @override
  // Widget build(BuildContext context) {
  //   return Text(todoItem.title);
  // }
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: animation,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            leading: CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(todoItem.urlImage),
            ),
            title: Text(todoItem.title, style: const TextStyle(fontSize: 20)),
            trailing: IconButton(
              icon:
                  const Icon(Icons.remove_circle, color: Colors.red, size: 32),
              onPressed: onClicked,
            ),
          ),
        ),
      );
}
