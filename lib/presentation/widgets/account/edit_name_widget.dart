import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentation/provider/user_provider.dart';

class EditAccountNameDialog extends StatelessWidget {
  const EditAccountNameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final username = provider.user?.name ?? '';
        final TextEditingController _nameController = TextEditingController();

        return AlertDialog(
          title: Text(
            'Change account name',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(color: Theme.of(context).colorScheme.outline),
              SizedBox(height: 16.h),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter new name',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            provider.isLoading
                ? SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      await provider.upgrateUserInfo(
                        name: _nameController.text.trim(),
                      );
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Edit",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
          ],
        );
      },
    );
  }
}
