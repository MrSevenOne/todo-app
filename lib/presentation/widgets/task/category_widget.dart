import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model/category_model.dart';
import '../date/datepicker_widget.dart';
import 'priority_widget.dart';

class CategoryDialog extends StatefulWidget {
  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.cardColor,
      title: Text(
        "Choose Category",
        style: TextStyle(
            color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: theme.colorScheme.outline,
          ),
          SizedBox(height: 15.h),
          SizedBox(
            height: 300.h, // Dialog ichida GridView balandligi
            width: double.maxFinite,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10.h,
              mainAxisSpacing: 10.w,
              shrinkWrap: true,
              children: List.generate(categories.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: categories[index].color,
                      borderRadius: BorderRadius.circular(10),
                      border: selectedIndex == index
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          categories[index].icon,
                          size: 30,
                          color: theme.scaffoldBackgroundColor,
                        ),
                        SizedBox(height: 5),
                        Text(categories[index].name,
                            style: TextStyle(
                                color: theme.scaffoldBackgroundColor,
                                fontSize: 12)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).primaryColor)),
        ),
        ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: selectedIndex == null
              ? null
              : () {
                  final selectedCategory = categories[selectedIndex!].name;
                  Navigator.pop(context, selectedCategory);
                },
          child: Text(
            "Next",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}

Future<String?> showCategoryDialog(BuildContext context) async {
  return await showDialog<String>(
    context: context,
    builder: (context) => CategoryDialog(),
  );
}
