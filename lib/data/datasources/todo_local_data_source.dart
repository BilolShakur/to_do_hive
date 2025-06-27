import 'package:hive/hive.dart';
import '../models/todo_model.dart';

class TodoLocalDataSource {
  final Box<TodoModel> todoBox;

  TodoLocalDataSource(this.todoBox);

  List<TodoModel> getTodos() {
    return todoBox.values.toList();
  }

  Future<void> addTodo(TodoModel todo) async {
    await todoBox.put(todo.id, todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await todoBox.put(todo.id, todo);
  }

  Future<void> deleteTodo(String id) async {
    await todoBox.delete(id);
  }
}
