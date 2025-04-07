import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_app/core/config/constants.dart';
import 'package:todo_app/presentation/provider/auth_provider.dart';
import 'package:todo_app/presentation/provider/todo_provider.dart';
import 'package:todo_app/presentation/provider/user_provider.dart';
import 'package:todo_app/presentation/widgets/account/change_image_widget.dart';
import 'package:todo_app/presentation/widgets/account/edit_name_widget.dart';
import 'package:todo_app/presentation/widgets/account/edit_password_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _todoProvider = Provider.of<TodoProvider>(context);
    int activePrioritySum =
        _todoProvider.getPrioritySum(true); // isActive == true
    int inactivePrioritySum =
        _todoProvider.getPrioritySum(false); // isActive == false

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(deffaultPadding / 2),
        child: Consumer<UserProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                SizedBox(height: 50.h),
               provider.user?.image_url != null
                ? CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                    provider.user!.image_url
                  ),
                )
                : Shimmer.fromColors(
  baseColor: Colors.grey[800]!,
  highlightColor: Colors.grey[700]!,
  child: CircleAvatar(
    radius: 50.0,
    backgroundColor: Colors.grey[850], // Shimmer ta'sir qiladigan rang
  ),
)
,
                const SizedBox(height: 10),
                Text(
                  '${provider.user?.name}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTaskButton(text: '$activePrioritySum Task left'),
                    const SizedBox(width: 10),
                    _buildTaskButton(text: '$inactivePrioritySum Task done'),
                  ],
                ),
                SizedBox(height: 30.h),
                _buildSectionTitle(context: context, title: 'Settings'),
                _buildMenuItem(
                    context: context,
                    icon: Icons.settings_outlined,
                    title: 'App Settings',
                    onTap: () {}),
                SizedBox(height: 10.h),
                _buildSectionTitle(context: context, title: 'Account'),
                _buildMenuItem(
                  context: context,
                  icon: Icons.person_outline,
                  title: 'Change account name',
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return EditAccountNameDialog();
                    },
                  ),
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.key_outlined,
                  title: 'Change account password',
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => EditAccountPasswordDialog(),
                  ),
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.camera_alt_outlined,
                  title: 'Change account Image',
                  onTap: () => ChangeImageWidget.show(context),
                ),
                SizedBox(height: 10.h),
                _buildSectionTitle(context: context, title: 'Uptodo'),
                _buildMenuItem(
                    context: context,
                    icon: Icons.info_outline,
                    title: 'About US',
                    onTap: () {}),
                _buildMenuItem(
                    context: context,
                    icon: Icons.help_outline,
                    title: 'FAQ',
                    onTap: () {}),
                _buildMenuItem(
                    context: context,
                    icon: Icons.feedback_outlined,
                    title: 'Help & Feedback',
                    onTap: () {}),
                _buildMenuItem(
                    context: context,
                    icon: Icons.thumb_up_off_alt_outlined,
                    title: 'Support US',
                    onTap: () {}),
                SizedBox(height: 20.h),
                ListTile(
                  leading: Icon(Icons.logout, color: theme.colorScheme.error),
                  title: Text(
                    'Log out',
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .signOut(context);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTaskButton({required String text}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[800],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _buildSectionTitle(
      {required BuildContext context, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).colorScheme.outline),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: Icon(
        Icons.navigate_next_outlined,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      onTap: onTap,
    );
  }
}
