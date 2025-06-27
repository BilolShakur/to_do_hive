import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repository;
  AddTodo(this.repository);

  Future<void> call(TodoEntity todo) async {
    await repository.addTodo(todo);
  }
}
