import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/routes.dart';
import 'package:todo_app/core/config/themes/light_theme.dart';
import 'package:todo_app/core/utils/supabase_helper.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/presentation/provider/auth_provider.dart';
import 'package:todo_app/presentation/provider/todo_provider.dart';
import 'package:todo_app/presentation/provider/user_provider.dart';
import 'package:todo_app/test.dart';
import 'core/config/themes/dark_theme.dart';

void main() async {
  //Connect with supabase
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseHelper.initializeSupabase();
  //   final notificationService = SupabaseNotificationService();
  // await notificationService.initNotifications();
  // notificationService.listenForDatabaseChanges();
  runApp(
    ScreenUtilInit(
      designSize: Size(375, 812),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => TodoProvider())
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: DarkTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }



  
}
