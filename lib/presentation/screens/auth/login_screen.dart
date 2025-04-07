import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/routes.dart';
import 'package:todo_app/presentation/provider/auth_provider.dart';

import '../../../core/config/constants.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: deffaultPadding * 2, horizontal: deffaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 23.h),
                  Text(
                    'Email',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Enter your Email",
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Enter your Password",
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 48.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.signIn(
                          email: _emailController.text,
                          password: _passwordController.text,
                          context: context,
                        );
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Divider(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    height: 48.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10.0,
                      children: [
                        Icon(Icons.g_mobiledata),
                        Text("Login with google"),
                      ],
                    ),
                  ),
                  SizedBox(height: 46.h),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Don’t have an account? ',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.register,
              );
            },
            child: Text(
              'Register',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
