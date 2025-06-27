import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tod_do_or_not_to_do/presentation/providers/todo_provider.dart';

void showSortDialog(BuildContext context) {
  final todoProvider = Provider.of<TodoProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Sort Todos'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            title: const Text('Created Date'),
            value: 'createdAt',
            groupValue: todoProvider.sortBy,
            onChanged: (value) {
              todoProvider.setSortBy(value.toString());
              Navigator.pop(context);
            },
          ),
          RadioListTile(
            title: const Text('Due Date'),
            value: 'dueDate',
            groupValue: todoProvider.sortBy,
            onChanged: (value) {
              todoProvider.setSortBy(value.toString());
              Navigator.pop(context);
            },
          ),
          RadioListTile(
            title: const Text('Title'),
            value: 'title',
            groupValue: todoProvider.sortBy,
            onChanged: (value) {
              todoProvider.setSortBy(value.toString());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}
