import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/update_todo.dart';
import '../../domain/usecases/delete_todo.dart';

class TodoProvider extends ChangeNotifier {
  final GetTodos getTodosUseCase;
  final AddTodo addTodoUseCase;
  final UpdateTodo updateTodoUseCase;
  final DeleteTodo deleteTodoUseCase;

  List<TodoEntity> _todos = [];
  String _filter = 'all';
  String _sortBy = 'createdAt';

  TodoProvider({
    required this.getTodosUseCase,
    required this.addTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
  }) {
    loadTodos();
  }

  List<TodoEntity> get todos => _getFilteredAndSortedTodos();
  String get filter => _filter;
  String get sortBy => _sortBy;

  Future<void> loadTodos() async {
    _todos = await getTodosUseCase();
    notifyListeners();
  }

  List<TodoEntity> _getFilteredAndSortedTodos() {
    List<TodoEntity> filteredTodos = _todos.where((todo) {
      switch (_filter) {
        case 'active':
          return !todo.isCompleted;
        case 'completed':
          return todo.isCompleted;
        default:
          return true;
      }
    }).toList();

    filteredTodos.sort((a, b) {
      switch (_sortBy) {
        case 'dueDate':
          if (a.dueDate == null && b.dueDate == null) return 0;
          if (a.dueDate == null) return 1;
          if (b.dueDate == null) return -1;
          return a.dueDate!.compareTo(b.dueDate!);
        case 'title':
          return a.title.compareTo(b.title);
        default:
          return b.createdAt.compareTo(a.createdAt);
      }
    });

    return filteredTodos;
  }

  Future<void> addTodo(String title,
      {String description = '', DateTime? dueDate}) async {
    final todo = TodoEntity(
      id: const Uuid().v4(),
      title: title,
      description: description,
      dueDate: dueDate,
    );
    await addTodoUseCase(todo);
    await loadTodos();
  }

  Future<void> updateTodo(TodoEntity todo) async {
    await updateTodoUseCase(todo);
    await loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    await deleteTodoUseCase(id);
    await loadTodos();
  }

  Future<void> toggleTodoCompletion(String id) async {
    final todo = _todos.firstWhere((t) => t.id == id);
    final updatedTodo = todo.copyWith(
      isCompleted: !todo.isCompleted,
      updatedAt: DateTime.now(),
    );
    await updateTodo(updatedTodo);
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }
}
