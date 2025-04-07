import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isCategory;
  final  onTap;

  TaskInfoRow(
      {required this.icon,
      required this.label,
      required this.value,
      required this.onTap,
      this.isCategory = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20.sp),
          SizedBox(width: 10.w),
          Text(label, style: TextStyle(color: Colors.white70, fontSize: 16)),
          Spacer(),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  if (isCategory)
                    Icon(Icons.add_circle, color: Colors.white, size: 16),
                  if (isCategory) SizedBox(width: 5),
                  Text(value,
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
