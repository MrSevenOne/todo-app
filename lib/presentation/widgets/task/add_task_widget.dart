import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/constants.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/presentation/provider/todo_provider.dart';
import 'package:todo_app/presentation/widgets/date/datepicker_widget.dart';
import 'package:todo_app/presentation/widgets/snackBar_widget.dart';
import 'package:todo_app/presentation/widgets/task/category_widget.dart';
import 'package:todo_app/presentation/widgets/task/priority_widget.dart';

class AddTaskWidget {
  static int? selectedPriority;

  static String? selectedCategory;

  static DateTime? selectedDeadline;

  static void show(
    BuildContext context,
  ) {
    showBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        TextEditingController _titleController = TextEditingController();
        TextEditingController _descriptionController = TextEditingController();
        final theme = Theme.of(context);
        return Stack(
          children: [
            Positioned(
              top: 5.0,
              right: 5.0,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.cancel_outlined,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(deffaultPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 14.0,
                children: [
                  Text(
                    'Add Task',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Do math homework'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(hintText: 'Description'),
                  ),
                  Row(
                    spacing: 16.h,
                    children: [
                      /// deadline
                      IconButton(
                        onPressed: () async {
                          selectedDeadline =
                              await DatePickerWidget.selectDeadline(context);
                        },
                        icon: Icon(
                          Icons.timer,
                          color: theme.colorScheme.outline,
                        ),
                      ),

                      /// category
                      IconButton(
                        onPressed: () async {
                          selectedCategory = await showCategoryDialog(context);
                        },
                        icon: Icon(
                          Icons.task,
                          color: theme.colorScheme.outline,
                        ),
                      ),

                      ///priority
                      IconButton(
                        onPressed: () async {
                          selectedPriority = await showPriorityDialog(context);
                        },
                        icon: Icon(
                          Icons.flag_outlined,
                          color: theme.colorScheme.outline,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          if (selectedDeadline == null ||
                              selectedCategory == null ||
                              selectedPriority == null) {
                            SnackBarWidget.showError(
                                "Error", "Please fill in all the information");
                          } else {
                            TodoModel todoModel = TodoModel(
                              title: _titleController.text.trim(),
                              description: _descriptionController.text.trim(),
                              categories: selectedCategory!,
                              deadline: selectedDeadline!,
                              priority: selectedPriority!, isActive: true,
                            );
                            Provider.of<TodoProvider>(context, listen: false)
                                .addCollectedTodo(todoModel: todoModel);
                            Navigator.pop(context);
                            SnackBarWidget.showSuccess(
                                'Add Task', "Task added successfully");
                          }
                        },
                        icon: Icon(
                          Icons.send_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
