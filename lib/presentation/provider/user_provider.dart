import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/core/services/database/auth_service.dart';
import '../../data/model/image_model.dart';
import '../../data/model/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/users_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  StreamSubscription? _authSubscription;
  final supabase = Supabase.instance.client;
  final AuthService _authService = AuthService();

  UserModel? _user;
  bool _isLoading = false;
  String? _error;
  File? _image;
  String? _imageUrl;
  final picker = ImagePicker();

  bool get isLoading => _isLoading;
  UserModel? get user => _user;
  String? get error => _error;
  File? get image => _image;
  String? get imageUrl => _imageUrl;

  UserProvider() {
    _listenAuthChanges();
  }

  /// **Auth holatini tinglash**
  void _listenAuthChanges() {
    _authSubscription = AuthRepository().authState.listen((authState) {
      if (authState.session != null) {
        getUserInfo(); // Foydalanuvchi almashsa, ma'lumotni yangilaymiz
      } else {
        _user = null; // Agar chiqib ketsa, user null bo'lishi kerak
        notifyListeners();
      }
    });
  }

  /// **User ma'lumotlarini olish**
  Future<void> getUserInfo() async {
    _setLoading(true);
    try {
      _user = await _userRepository.getUserInfo();
    } catch (e) {
      _error = 'Xatolik: $e';
    } finally {
      _setLoading(false);
    }
  }

  /// **User ma'lumotlarini yangilash**
  Future<void> upgrateUserInfo({required String name}) async {
    _setLoading(true);
    await _userRepository.upgrateUserInfo(updateValue: name);
    await getUserInfo();
  }

  /// Profile rasm tanlash
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
      await uploadImage(_image!);
    }
  }

  /// Store uploade image
  /// **Rasm yuklash va URL'ni Supabase database'ga saqlash**
Future<void> uploadImage(File image) async {
  final userId = _authService.getUserId();
  if (userId == null) return;

  try {
    final storage = supabase.storage;
    final fileName = '$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';

    //Rasmni yuklash
    await storage.from('profileimg').upload(fileName, image);

    //Rasm uchun public URL olish
    final imageUrl = storage.from('profileimg').getPublicUrl(fileName);
    
    //`users` jadvaliga rasm URL'ni saqlash
    await supabase
        .from('users')
        .update({'image_url': imageUrl}) // Rasm URL'ni yangilash
        .eq('id', userId); // Faqat shu user uchun

    //Providerda URL'ni yangilash
    _imageUrl = imageUrl;
    notifyListeners();
    
  } catch (e) {
    print('Rasm yuklashda xatolik: $e');
  }
}


  /// **Loading holatini boshqarish**
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// **Provider yo'q qilinayotganda stream-ni tozalash**
  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
