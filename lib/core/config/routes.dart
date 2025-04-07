import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/presentation/screens/auth/auth_gate.dart';
import 'package:todo_app/presentation/screens/auth/register_screen.dart';
import 'package:todo_app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:todo_app/presentation/screens/splash/splash_screen.dart';
import '../../data/model/todo_model.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/task/task_edit_screen.dart';
import '../../presentation/widgets/bottomNagationBar_widget.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String taskedit = '/taskedit';
  static const String home = '/home';
  static const String NavigationBar = '/NavigationBar';
  static const String authgate = '/authgate';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return PageTransition(
          type: PageTransitionType.fade,
          child: SplashScreen(),
        );
      case onboarding:
        return PageTransition(
          type: PageTransitionType.fade,
          child: OnboardingScreen(),
        );
      case login:
        return PageTransition(
          duration: 700.ms,
          type: PageTransitionType.fade,
          child: LoginScreen(),
        );
      case register:
        return PageTransition(
          duration: 700.ms,
          type: PageTransitionType.fade,
          child: RegisterScreen(),
        );
      case taskedit:
  if (settings.arguments is TodoModel) {
    final todoModel = settings.arguments as TodoModel;
    return PageTransition(
      duration: 700.ms,
      type: PageTransitionType.fade,
      child: TaskEditScreen(todo: todoModel), // To‘g‘ri yuborish
    );
  } else {
    print("Xatolik: TaskEditScreen uchun argument null yoki noto‘g‘ri formatda!");
    return null;
  }


      case home:
        return PageTransition(
          duration: 700.ms,
          type: PageTransitionType.fade,
          child: HomeScreen(),
        );
      case NavigationBar:
        return PageTransition(
          duration: 700.ms,
          type: PageTransitionType.fade,
          child: NavigationBarWidget(),
        );
      case authgate:
        return PageTransition(
          duration: 700.ms,
          type: PageTransitionType.fade,
          child: AuthGate(),
        );
      default:
        return null;
    }
  }
}
