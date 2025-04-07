import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_app/core/config/routes.dart';
import 'package:todo_app/core/utils/time_formatted.dart';
import 'package:todo_app/presentation/provider/todo_provider.dart';
import 'package:todo_app/presentation/screens/task/task_info.dart';
import 'package:todo_app/presentation/widgets/task/add_task_widget.dart';
import 'package:todo_app/presentation/widgets/task/done_show.dart';
import 'package:todo_app/presentation/widgets/task_items/tasklist_design.dart';
import '../../widgets/task_items/tasklist_shimmer.dart';

class DoneScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Done Todos',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {

          if (provider.isLoading) {
            return ListView.builder(
              itemCount: 5, // Fake 5 ta shimmer effekt
              itemBuilder: (context, index) => const TaskListShimmer(),
            );
          }

          if (provider.doneTodos.isEmpty) {
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                Image.asset('assets/empty_todo.png'),
                SizedBox(height: 10.h),
                Text('Completed work is not available'),

              ],),
            );
          }

          return ListView.builder(
            itemCount: provider.doneTodos.length,
            itemBuilder: (context, index) {
              final todo = provider.doneTodos[index];
              final deadline =
                  DateTimeFormatted.dateFormat(dateTime: todo.deadline);
              return Dismissible(
                key: Key(todo.id.toString()),
                background: Container(
                  color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(Icons.edit, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    Navigator.pushNamed(context, AppRoutes.taskedit,
                        arguments: todo);
                    return false;
                  } else {
                    return true;
                  }
                },
                onDismissed: (direction) {
                  // provider.deleteTask(todo.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${todo.title} o‘chirildi!')),
                  );
                },
                child: TaskListItem(
                  model: todo,
                  index: index,
                  onTap: () {
                    TaskInfo.showTaskInfo(todoModel: todo, context: context);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddTaskWidget.show(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
