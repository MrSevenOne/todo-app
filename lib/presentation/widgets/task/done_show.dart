import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/presentation/provider/todo_provider.dart';

class DoneTaskWidget extends StatelessWidget {
  final TodoModel todoModel;

  const DoneTaskWidget({super.key, required this.todoModel});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    return AlertDialog(
      title: Text('Done Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Is the todo done?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
                        Navigator.pop(context);
            await todoProvider.doneTodo(todomodel: todoModel);
          },
          child: Text('Done'),
        ),
      ],
    );
  }

  static void showDoneTask({required BuildContext context, required TodoModel todoModel}) {
    showDialog(
      context: context,
      builder: (context) => DoneTaskWidget(todoModel: todoModel),
    );
  }
}
