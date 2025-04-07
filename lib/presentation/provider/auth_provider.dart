import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/data/repositories/auth_repository.dart';
import 'package:todo_app/presentation/widgets/snackBar_widget.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  bool? _isLoggedIn;

  bool? get isLoggedIn => _isLoggedIn;

  bool get loading => _isLoading;

  /// **Auth State Stream**
  Stream<AuthState> get authState => _authRepository.authState;

  String? get currentUser => _authRepository.getUserId();

  /// **Ro'yxatdan o'tish**
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _setLoading(true);
    try {
      await _authRepository.signUp(
          name: name, email: email, password: password);
      _isLoggedIn = true;
      notifyListeners();
     
    } catch (e) {
    }
    _setLoading(false);
  }

  /// **Tizimga kirish**
  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _setLoading(true);
    try {
      await _authRepository.signIn(email: email, password: password);
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
    }
    _setLoading(false);
  }

  /// **Tizimdan chiqish**
  Future<void> signOut(BuildContext context) async {
    try {
      await _authRepository.signOut();
      _isLoggedIn = false;
    
      notifyListeners();
    } catch (e) {
    }
  }


  /// **Loading holatini boshqarish**
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
