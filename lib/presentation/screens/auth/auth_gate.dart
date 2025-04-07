import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/presentation/provider/auth_provider.dart';
import 'package:todo_app/presentation/screens/auth/login_screen.dart';
import 'package:todo_app/presentation/widgets/bottomNagationBar_widget.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: StreamBuilder<AuthState>(
        stream: authProvider.authState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final session = snapshot.data?.session;
          if (session != null) {
            return NavigationBarWidget();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
