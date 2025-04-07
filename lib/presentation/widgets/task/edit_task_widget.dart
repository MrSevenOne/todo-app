import 'package:flutter/material.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/presentation/widgets/task/category_widget.dart';



class EditTaskDialog extends StatefulWidget {
  final TodoModel model;
  EditTaskDialog({required this.model});

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController taskController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    taskController = TextEditingController(text: widget.model.title);
    descriptionController = TextEditingController(text: widget.model.description);
  }

  @override
  void dispose() {
    taskController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text("Edit Task", style: TextStyle(color: Colors.white)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: taskController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Title",
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            style: TextStyle(color: Colors.white),
            maxLines: 3,
            decoration: InputDecoration(
              labelText: "Description",
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Cancel bosilganda o'zgarish yo'q
          child: Text("Cancel", style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
        ElevatedButton(
          onPressed: () {
            // UI da vaqtincha o‘zgarish uchun yangi modelni qaytarish
            TodoModel updatedModel = widget.model.copyWith(
              title: taskController.text,
              description: descriptionController.text,
            );
            Navigator.pop(context, updatedModel);
          },
          child: Text("Save", style: Theme.of(context).textTheme.titleSmall),
        ),
      ],
    );
  }
}


