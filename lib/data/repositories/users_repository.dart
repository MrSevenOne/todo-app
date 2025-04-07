import 'package:todo_app/core/services/database/tables/users_service.dart';
import 'package:todo_app/data/model/user_model.dart';

import '../../core/services/database/auth_service.dart';

class UserRepository {
  final UserService _userService = UserService();

  /// **User ma'lumotini olish**
  Future<UserModel?> getUserInfo() async {
    final userId = AuthService().getUserId();
    if (userId == null) return null;
    return await _userService.getUserInfo(id: userId);
  }

  /// **User ma'lumotini yangilash**
  Future<UserModel?> upgrateUserInfo({required String updateValue}) async {
    final userId = AuthService().getUserId();
    if (userId == null) return null;
    return await _userService.upgrateUserInfo(
      columnValue: userId,
      updateValue: updateValue,
    );
  }
}
