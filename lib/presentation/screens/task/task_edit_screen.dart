import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/constants.dart';
import 'package:todo_app/presentation/provider/todo_provider.dart';
import 'package:todo_app/presentation/widgets/task/task_info_widget.dart';

import '../../../core/utils/time_formatted.dart';
import '../../../data/model/todo_model.dart';
import '../../widgets/task/edit_task_widget.dart';
import '../../widgets/task/priority_widget.dart';

class TaskEditScreen extends StatefulWidget {
  final TodoModel todo;

  const TaskEditScreen({required this.todo, Key? key}) : super(key: key);

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  late TodoModel tempTodo; // UI da vaqtincha saqlanadigan model

  @override
  void initState() {
    super.initState();
    tempTodo = widget.todo; // Eski modelni saqlab qolamiz
  }

  Future<void> _editTask() async {
    TodoModel? updatedTodo = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => EditTaskDialog(model: tempTodo),
    );

    if (updatedTodo != null) {
      setState(() {
        tempTodo = updatedTodo; // UI da vaqtincha yangilash
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deadline = DateTimeFormatted.dateFormat(dateTime: tempTodo.deadline);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(deffaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.circle_outlined, color: Colors.white, size: 20.sp),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    tempTodo.title, // UI dagi vaqtincha ma'lumot
                    style: theme.textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: _editTask,
                  icon: Icon(Icons.edit,
                      color: theme.colorScheme.onPrimary, size: 20.sp),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              tempTodo.description, // UI dagi vaqtincha ma'lumot
              style: TextStyle(color: theme.colorScheme.outline),
            ),
            SizedBox(height: 20.h),
            TaskInfoRow(
              icon: Icons.access_time,
              label: "Task Time :",
              value: "$deadline",
              onTap: () {

              },
            ),
            TaskInfoRow(
              icon: Icons.location_on,
              label: "Task Category :",
              value: "${tempTodo.categories}",
              onTap: () {},
              isCategory: true,
            ),
            TaskInfoRow(
              icon: Icons.flag,
              label: "Task Priority :",
              value: "${tempTodo.priority}",
              onTap: ()  {
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10.h,
          left: deffaultPadding,
          right: deffaultPadding,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: () {
              // Database ga o'zgarishlarni saqlash
              Provider.of<TodoProvider>(context,listen: false).editTodo(model: tempTodo);
              Navigator.pop(context, tempTodo); // UI ni yangilash
            },
            child: Text("Ok", style: theme.textTheme.titleSmall),
          ),
        ),
      ),
    );
  }
}
