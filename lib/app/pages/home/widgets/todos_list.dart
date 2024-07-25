import 'package:flutter/material.dart';

class TodosList extends StatelessWidget {
  const TodosList({super.key, required this.todos, required this.onRemove});

  final List<String> todos;
  final void Function(int index) onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Center(
                child: Text(todos[index][0].toUpperCase()),
              ),
            ),
            title: Text(todos[index]),
            trailing: IconButton(
              onPressed: () {
                onRemove(index);
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          );
        },
      ),
    );
  }
}
