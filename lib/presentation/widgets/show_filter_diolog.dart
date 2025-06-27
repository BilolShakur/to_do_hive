import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tod_do_or_not_to_do/presentation/providers/todo_provider.dart';

void showFilterDialog(BuildContext context) {
  final todoProvider = Provider.of<TodoProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Filter Todos'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            title: const Text('All'),
            value: 'all',
            groupValue: todoProvider.filter,
            onChanged: (value) {
              todoProvider.setFilter(value.toString());
              Navigator.pop(context);
            },
          ),
          RadioListTile(
            title: const Text('Active'),
            value: 'active',
            groupValue: todoProvider.filter,
            onChanged: (value) {
              todoProvider.setFilter(value.toString());
              Navigator.pop(context);
            },
          ),
          RadioListTile(
            title: const Text('Completed'),
            value: 'completed',
            groupValue: todoProvider.filter,
            onChanged: (value) {
              todoProvider.setFilter(value.toString());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}
