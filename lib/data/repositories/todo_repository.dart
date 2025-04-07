import 'package:todo_app/core/services/database/auth_service.dart';
import 'package:todo_app/core/services/database/tables/todos_service.dart';
import '../model/todo_model.dart';

class TodoRepository {
  ///Add
  Future addTodo({required TodoModel todomodel}) async =>
      ToDoService.addTodo(todomodel: todomodel);

  /// Get
  Future<List<TodoModel>> getTodo() async => ToDoService.getTodo(
        sortValue: AuthService().getUserId(),
      );

  /// edit todo
  Future<void> editTodo({required TodoModel model}) async =>
      ToDoService.editTodo(model: model);

  /// Done todo
  Future<void> doneTodo({required TodoModel todomodel}) async =>
      ToDoService.doneTodo(todomodel: todomodel);

  ///Delete todo
  Future<void> deleteTodo({required int todoId}) async =>
      ToDoService.deleteTodo(todoId: todoId);
}
