import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentation/provider/todo_provider.dart';

class PriorityDialog extends StatefulWidget {
  const PriorityDialog({super.key});

  @override
  State<PriorityDialog> createState() => _PriorityDialogState();
}

class _PriorityDialogState extends State<PriorityDialog> {
  int selectedPriority = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(
        "Task Priority",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
         width: 250.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: theme.dividerColor,
            ),
            SizedBox(height: 15.h),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                final isSelected = selectedPriority == index + 1;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPriority = index + 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.primaryColor
                          : const Color(0xFF272727),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flag,
                            color: isSelected
                                ? theme.colorScheme.onPrimary
                                : Colors.grey.shade400),
                        const SizedBox(height: 4),
                        Text(
                          '${index + 1}',
                          style: TextStyle(
                            color:
                                isSelected ? Colors.white : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: theme.primaryColor),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, selectedPriority);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<int?> showPriorityDialog(BuildContext context) async {
  return await showDialog<int>(
    context: context,
    builder: (context) => const PriorityDialog(),
  );
}
