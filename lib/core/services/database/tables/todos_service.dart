import 'package:todo_app/core/utils/supabase_helper.dart';
import 'package:todo_app/data/model/todo_model.dart';

class ToDoService {
  ///ADD
  static Future<void> addTodo({required TodoModel todomodel}) async =>
      await SupabaseHelper.insertData<TodoModel>(
        tableName: 'todos',
        model: todomodel,
        toJson: (todo) => todo.toJson(),
      );

  ///GET
  static Future<List<TodoModel>> getTodo({required sortValue}) async =>
      await SupabaseHelper.getSortData(
        tableName: 'todos',
        fromJson: (json) => TodoModel.fromJson(json),
        columnName: 'userId',
        columnValue: sortValue,
      );

  ///EDIT
  static Future<void> editTodo({
    required TodoModel model,
  }) async {
    await SupabaseHelper.updateData(
        tableName: 'todos',
        column: 'id',
        value: model.id,
        model: model,
        toJson: (todo) => todo.toJson());
  }

  ///DONE
  static Future<void> doneTodo({required TodoModel todomodel}) async {
    await SupabaseHelper.updateSingleData(
      tableName: 'todos',
      columnName: 'id',
      updateName: 'isActive',
      updateValue: !todomodel.isActive,
      value: todomodel.id,
    );
  }

  ///DELETE
  static Future<void> deleteTodo({required int todoId}) async {
    await SupabaseHelper.deleteData(
        tableName: 'todos', column: 'id', value: todoId,);
  }
}
