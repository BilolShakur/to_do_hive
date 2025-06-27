import 'package:flutter/material.dart';
import '../../domain/entities/todo_entity.dart';
import '../theme/app_theme.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => onToggle(),
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
              color: todo.isCompleted
                  ? (isDark ? Colors.grey : AppTheme.bodyText)
                  : (isDark ? Colors.white : AppTheme.titleText),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (todo.description.isNotEmpty)
                Text(
                  todo.description,
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : AppTheme.bodyText,
                    fontSize: 12,
                  ),
                ),
              if (todo.dueDate != null)
                Text(
                  'Due: ${DateFormat('MMM d, y HH:mm').format(todo.dueDate!)}',
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : AppTheme.bodyText,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          trailing: todo.dueDate != null &&
                  todo.dueDate!.isBefore(DateTime.now()) &&
                  !todo.isCompleted
              ? const Icon(Icons.warning, color: Colors.red)
              : null,
        ),
      ),
    );
  }
}
