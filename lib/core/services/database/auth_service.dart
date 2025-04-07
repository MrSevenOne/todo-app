import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/core/services/database/tables/users_service.dart';
import 'package:todo_app/data/model/user_model.dart';
import 'package:todo_app/presentation/widgets/snackBar_widget.dart';

class AuthService {
  static final SupabaseClient _supabase = Supabase.instance.client;
  UserService userService = UserService();

  /// **Auth State Stream**
  static Stream<AuthState> get authState => _supabase.auth.onAuthStateChange;

  /// **Ro‘yxatdan o‘tish (E-mail & Parol)**
  Future<AuthResponse?> signUp({
  required String name,
  required String email,
  required String password,
}) async {
  try {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user != null) {
      UserModel userModel = UserModel(
        id: response.user!.id,
        name: name,
        email: email,
        password: password,
        created_at: response.user!.createdAt,
        image_url: 'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=', // 🖼 Default rasm URL
      );
      await userService.addUser(usermodel: userModel);
    }
 SnackBarWidget.showInfo(
          title: 'Sign Up', message: 'You have successfully registered!');
    return response;
  } on AuthException catch (e) {
    if (e.message.contains('already registered')) {
      SnackBarWidget.showInfo(
          title: 'Registered', message: "This email is already registered!");
    } else {
      SnackBarWidget.showInfo(title: 'Error', message: "${e.message}");
    }
  } catch (e) {
    SnackBarWidget.showInfo(title: 'Error registered', message: "$e");
    return null;
  }
}

     


  /// **Tizimga kirish (E-mail & Parol)**
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
            SnackBarWidget.showInfo(title: 'Sign In', message: "You are logged in!");
    } on AuthException catch (e) {
      SnackBarWidget.showInfo(title: 'Error Login', message: "${e.message}");
    } catch (e) {
      SnackBarWidget.showInfo(title: 'Error', message: "$e");
    }
  }

  /// **Tizimdan chiqish**
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
        SnackBarWidget.showInfo(
          title: 'Sign Out', message: 'You are logged out!');
    } catch (e) {
      SnackBarWidget.showInfo(title: 'Error Logout', message: "${e}");
    }
  }

  /// **Hozirgi foydalanuvchini olish**
  String? getUserId() {
    final user = _supabase.auth.currentUser;
    return user?.id;
  }
}
