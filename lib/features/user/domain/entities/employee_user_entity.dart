import 'package:mybookstore/features/user/domain/entities/user_entity.dart';

class EmployeeUserEntity extends UserEntity {
  final String? password;
  final String userName;
  const EmployeeUserEntity({
    this.password,
    required this.userName,
    super.id,
    super.role = 'Employee',
    required super.name,
    required super.photo,
  });
}
