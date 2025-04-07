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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Todo List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          print("uzunlik: ${provider.todo.length}");

          if (provider.isLoading) {
            return ListView.builder(
              itemCount: 5, // Fake 5 ta shimmer effekt
              itemBuilder: (context, index) => const TaskListShimmer(),
            );
          }

          if (provider.todo.isEmpty) {
            return  Center(
              child: Image.asset('assets/empty_todo.png')
            );
          }

          return ListView.builder(
            itemCount: provider.todo.length,
            itemBuilder: (context, index) {
              final todo = provider.todo[index];
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
