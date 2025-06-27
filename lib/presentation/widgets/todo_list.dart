import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

import 'todo_item.dart';


class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final todos = todoProvider.todos;

        if (todos.isEmpty) {
          return const Center(
            child: Text(
              'No todos yet!\nTap + to add one',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return TodoItem(
              todo: todo,
              onToggle: () => todoProvider.toggleTodoCompletion(todo.id),
              onDelete: () => todoProvider.deleteTodo(todo.id),
            );
          },
        );
      },
    );
  }
}
