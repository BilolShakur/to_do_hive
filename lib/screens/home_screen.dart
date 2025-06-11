import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tod_do_or_not_to_do/providers/todo_provider.dart';
import 'package:tod_do_or_not_to_do/providers/theme_provider.dart';
import 'package:tod_do_or_not_to_do/widgets/todo_list.dart';
import 'package:tod_do_or_not_to_do/widgets/add_todo_dialog.dart';
import 'package:tod_do_or_not_to_do/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => _toggleTheme(context),
          ),
        ],
      ),
      body: const TodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
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

  void _showSortDialog(BuildContext context) {
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

  void _toggleTheme(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final currentTheme = themeProvider.themeMode;
    ThemeMode newTheme;

    switch (currentTheme) {
      case ThemeMode.light:
        newTheme = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newTheme = ThemeMode.system;
        break;
      default:
        newTheme = ThemeMode.light;
    }

    themeProvider.setThemeMode(newTheme);
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddTodoDialog(),
    );
  }
}
