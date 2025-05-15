import 'package:mybookstore/features/user/domain/entities/admin_user_entity.dart';

class AdminUserModel extends AdminUserEntity {
  const AdminUserModel(
      {required super.userName,
      required super.name,
      required super.photo,
      required super.role,
      required super.password});

  factory AdminUserModel.fromEntity(AdminUserEntity entity) {
    return AdminUserModel(
      userName: entity.userName,
      name: entity.name,
      photo: entity.photo,
      role: entity.role,
      password: entity.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'photo': photo,
      'username': userName,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'AdminUserModel{ name: $name, photo: $photo, userName: $userName, role: $role, password: $password}';
  }
}
