import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<List<TodoEntity>> getTodos() async {
    final models = localDataSource.getTodos();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> addTodo(TodoEntity todo) async {
    final model = TodoModel.fromEntity(todo);
    await localDataSource.addTodo(model);
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    final model = TodoModel.fromEntity(todo);
    await localDataSource.updateTodo(model);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await localDataSource.deleteTodo(id);
  }
}
