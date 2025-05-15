import 'package:mybookstore/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.id, required super.name, required super.photo, required super.role});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      photo: map['photo'] as String,
      role: map['role'] as String,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      photo: entity.photo,
      role: entity.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'role': role,
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, photo: $photo, role: $role}';
  }
}
