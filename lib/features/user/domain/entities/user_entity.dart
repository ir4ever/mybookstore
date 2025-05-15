import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String name;
  final String photo;
  final String role;

  const UserEntity({this.id, required this.name, required this.photo, required this.role});

  @override
  List<Object?> get props => [id, name, photo, role];
}
