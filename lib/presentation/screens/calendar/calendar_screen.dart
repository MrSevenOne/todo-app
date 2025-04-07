import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/todo_provider.dart';
import '../../widgets/date/easy_datepicker_widget.dart';
import '../../widgets/task_items/tasklist_design.dart';
import '../../widgets/task_items/tasklist_shimmer.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now(); // Default bugungi sana
    Future.microtask(() {
      Provider.of<TodoProvider>(context, listen: false)
          .getTodoByDate(selectedDate!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Calendar"),
      ),
      body: Column(
        children: [
          EasyDatePickerWidget(
            onDateSelected: (DateTime date) {
              setState(() {
                selectedDate = date;
              });
              Provider.of<TodoProvider>(context, listen: false)
                  .getTodoByDate(date);
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer<TodoProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return ListView.builder(
                    itemCount: 5, // Fake 5 ta shimmer effekt
                    itemBuilder: (context, index) => const TaskListShimmer(),
                  );
                }

                if (provider.sortByDate.isEmpty) {
                  return const Center(
                    child: Text(
                      "Vazifalar mavjud emas",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: provider.sortByDate.length,
                  itemBuilder: (context, index) {
                    final todo = provider.sortByDate[index];
                    return TaskListItem(
                      model: todo,
                      index: index,
                      onTap: () {},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
