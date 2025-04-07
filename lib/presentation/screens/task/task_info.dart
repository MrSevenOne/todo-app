import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/data/model/todo_model.dart';

import '../../../core/utils/time_formatted.dart';
import '../../widgets/task/task_info_widget.dart';

class TaskInfo extends StatelessWidget {
  TodoModel todoModel;

  TaskInfo({required this.todoModel});
  static void showTaskInfo({required TodoModel todoModel, required BuildContext context}) {
     showDialog(
      context: context,
      builder: (context) => TaskInfo(todoModel: todoModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deadline = DateTimeFormatted.dateFormat(dateTime: todoModel.deadline);
    return AlertDialog(
      
      title: Text(todoModel.title,textAlign: TextAlign.center,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            todoModel.description, // UI dagi vaqtincha ma'lumot
            style: TextStyle(color: Theme.of(context).colorScheme.outline),
          ),
          SizedBox(height: 20.h),
          TaskInfoRow(
            icon: Icons.access_time,
            label: "Time:",
            value: "$deadline",
            onTap: () {},
          ),
          TaskInfoRow(
            icon: Icons.location_on,
            label: "Category:",
            value: "${todoModel.categories}",
            onTap: () {},
            isCategory: true,
          ),
          TaskInfoRow(
            icon: Icons.flag,
            label: "Priority:",
            value: "${todoModel.priority}",
            onTap: () {},
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    );
  }
}
