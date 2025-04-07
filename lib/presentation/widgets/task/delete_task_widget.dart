import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/presentation/provider/todo_provider.dart';
import 'package:todo_app/presentation/widgets/snackBar_widget.dart';

class DeleteTaskWidget extends StatelessWidget {
  final TodoModel todoModel;
  const DeleteTaskWidget({required this.todoModel});
  static void showDeleteTask(
      {required BuildContext context, required TodoModel todoModel}) {
    showDialog(
      context: context,
      builder: (context) => DeleteTaskWidget(
        todoModel: todoModel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Do you want to delete the "${todoModel.title}" ?',            style: Theme.of(context).textTheme.bodyLarge,
),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'cancel',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            SnackBarWidget.showSuccess(todoModel.title, 'Successfully deleted');
            Provider.of<TodoProvider>(context, listen: false)
                .deleteTodo(todoId: todoModel.id!);
          },
          child: Text(
            'delete',
          ),
        ),
      ],
    );
  }
}
