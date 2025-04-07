import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/config/routes.dart';
import 'package:todo_app/core/utils/time_formatted.dart';
import 'package:todo_app/data/model/todo_model.dart';
import '../../../data/model/category_model.dart';
import '../task/delete_task_widget.dart';
import '../task/done_show.dart';

class TaskListItem extends StatelessWidget {
  final TodoModel model;
  final VoidCallback onTap;
  final int index;

  const TaskListItem({
    Key? key,
    required this.model,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Kategoriyani topish
    final Category? categoryData = categories.firstWhere(
      (cat) => cat.name == model.categories,
      orElse: () =>
          Category(name: model.categories, icon: Icons.category, color: Colors.grey),
    );
    final deadline = DateTimeFormatted.dateFormat(dateTime: model.deadline);

    return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),

      child: Slidable(
      
        key: ValueKey(index),
       endActionPane: ActionPane(
  motion: ScrollMotion(),
  children: model.isActive
      ? [
          SlidableAction(
            onPressed: (context) {
              DoneTaskWidget.showDoneTask(context: context, todoModel: model);
            },
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            icon: Icons.done,
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
          SlidableAction(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(12.0)),
            onPressed: (context) =>
                DeleteTaskWidget.showDeleteTask(context: context, todoModel: model),
            backgroundColor: const Color.fromARGB(255, 210, 12, 12),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ]
      : [
          SlidableAction(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(12.0)),
            onPressed: (context) =>
                DeleteTaskWidget.showDeleteTask(context: context, todoModel: model),
            backgroundColor: const Color.fromARGB(255, 210, 12, 12),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(model.isActive == true ? Icons.radio_button_unchecked : Icons.radio_button_checked,
                    color: model.isActive == true ? theme.colorScheme.outline : theme.primaryColor,
                    ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$deadline",
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: categoryData?.color, // Kategoriya rangi
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(categoryData?.icon,
                          color: theme.scaffoldBackgroundColor,
                          size: 16), // Kategoriya ikonkasi
                      const SizedBox(width: 6),
                      Text(
                        categoryData!.name,
                        style: TextStyle(color: theme.scaffoldBackgroundColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.flag_outlined,
                          color: theme.colorScheme.outline, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${model.priority}',
                        style: TextStyle(color: theme.colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
            .animate(delay: 100.ms)
            .fade(duration: 500.ms)
            .move(
              begin: Offset(0, 10),
              end: Offset(0, 0),
            )
            .slideY(begin: 0.2, end: 0, duration: (index * 300).ms),
      ),
    );
  }
}
