import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentation/provider/user_provider.dart';

class ChangeImageWidget {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Change account Image',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Divider(
                color: Theme.of(context).dividerColor,
              ),
              TextButton(
                onPressed: () {
                  Provider.of<UserProvider>(context, listen: false).pickImage();
                },
                child: Text(
                  'Import from gallery',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            
            ],
          ),
        );
      },
    );
  }
}
