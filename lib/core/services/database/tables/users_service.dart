import 'package:todo_app/core/utils/supabase_helper.dart';
import 'package:todo_app/data/model/user_model.dart';

class UserService {
  /// **Foydalanuvchini qo'shish**
  Future<void> addUser({required UserModel usermodel}) async {
    await SupabaseHelper.insertData<UserModel>(
      tableName: 'users',
      model: usermodel,
      toJson: (user) => user.toJson(),
    );
  }

  /// **Foydalanuvchi ma'lumotlarini olish**
  Future<UserModel?> getUserInfo({required id}) async {
    final data = await SupabaseHelper.getSingleData(
      tableName: 'users',
      columnName: 'id',
      value: id,
      fromJson: UserModel.fromJson,
    );

    if (data != null) {
      return data;
    } else {
      print("getUserInfo: Foydalanuvchi topilmadi!");
      return null;
    }
  }

  /// **Foydalanuvchi ma'lumotlarini yangilash**
  Future<UserModel?> upgrateUserInfo({
    required String updateValue,
    required String columnValue,
  }) async {
    try {
      await SupabaseHelper.updateSingleData(
        tableName: 'users',
        columnName: 'id',
        updateName: 'name',
        updateValue: updateValue,
        value: columnValue,
      );

      // Yangilangan ma'lumotni qaytarish
      return await getUserInfo(id: columnValue);
    } catch (e) {
      print("UserInfoUpgrate xato:  $e");
      return null;
    }
  }

  
}
