import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditAccountPasswordDialog extends StatelessWidget {
  const EditAccountPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController oldPasswordController =
        TextEditingController(text: 'oldPasswordController');
    TextEditingController newPasswordController =
        TextEditingController(text: 'newPasswordController');
    return AlertDialog(
      title: Text(
        'Change account password',
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(color: Theme.of(context).colorScheme.outline),
          SizedBox(height: 16.h),
          Text(
            'Enter old password',
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: oldPasswordController,
            obscureText: true,
          ),
          SizedBox(height: 10.h),
          Text(
            'Enter new password',
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: newPasswordController,
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancal',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Edit",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
