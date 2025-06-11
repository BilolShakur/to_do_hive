import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tod_do_or_not_to_do/models/todo.dart';
import 'package:uuid/uuid.dart';

class TodoProvider extends ChangeNotifier {
  late Box<Todo> _todoBox;
  List<Todo> _todos = [];
  String _filter = 'all'; 
  String _sortBy = 'createdAt'; 

  TodoProvider() {
    _loadTodos();
  }

  List<Todo> get todos => _getFilteredAndSortedTodos();
  String get filter => _filter;
  String get sortBy => _sortBy;

  Future<void> _loadTodos() async {
    _todoBox = Hive.box<Todo>('todos');
    _todos = _todoBox.values.toList();
    notifyListeners();
  }

  List<Todo> _getFilteredAndSortedTodos() {
    List<Todo> filteredTodos = _todos.where((todo) {
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
    final todo = Todo(
      id: const Uuid().v4(),
      title: title,
      description: description,
      dueDate: dueDate,
    );
    await _todoBox.put(todo.id, todo);
    _todos.add(todo);
    notifyListeners();
  }

  Future<void> updateTodo(Todo todo) async {
    await _todoBox.put(todo.id, todo);
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      notifyListeners();
    }
  }

  Future<void> deleteTodo(String id) async {
    await _todoBox.delete(id);
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
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
