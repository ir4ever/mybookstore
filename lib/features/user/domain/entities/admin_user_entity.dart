import 'package:mybookstore/features/user/domain/entities/user_entity.dart';

class AdminUserEntity extends UserEntity {
  final String? password;
  final String userName;

  const AdminUserEntity({
    this.password,
    required this.userName,
    super.id,
    super.role = 'Admin',
    required super.name,
    required super.photo,
  });

  @override
  List<Object?> get props => [id, name, photo, role, password, userName];
}
