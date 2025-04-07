import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/routes.dart';
import 'package:todo_app/presentation/provider/auth_provider.dart';

import '../../../core/config/constants.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _configpasswordController = TextEditingController();
    void _checkPassword() {
      if (_passwordController.text == _configpasswordController.text) {
        Provider.of<AuthProvider>(context, listen: false).signUp(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          context: context,
        );
        Navigator.pushNamed(context, AppRoutes.splash);
      } else {
        print('password xato');
      }
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: deffaultPadding * 2, horizontal: deffaultPadding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Register',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 23.h),
              Text(
                'Name',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Enter your Name",
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20.h),
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
                controller: _configpasswordController,
                decoration: InputDecoration(
                  hintText: "Enter your Password",
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20.h),
              Text(
                'Config Password',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Enter your Config Password",
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 48.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: _checkPassword,
                  child: Text(
                    'Register',
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
                    Text("Register with google"),
                  ],
                ),
              ),
              SizedBox(height: 46.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.login,
              );
            },
            child: Text(
              'Login',
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
