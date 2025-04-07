class UserModel {
  final String id;
  final String name;
  String created_at;
  final String email;
  final String password;
  final String image_url;

  UserModel({
    required this.id,
    required this.name,
    required this.created_at,
    required this.email,
    required this.password,
    required this.image_url,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      created_at: json['created_at'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      image_url: json['image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'created_at': created_at,
      'image_url': image_url,
    };
  }
}
