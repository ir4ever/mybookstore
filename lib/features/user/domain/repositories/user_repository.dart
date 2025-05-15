import 'dart:async';

import 'package:mybookstore/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getUser();
}

class UserRepositoryImpl implements UserRepository {
  UserEntity? _user;

  @override
  Future<UserEntity> getUser() async {
    if (_user != null) return _user!;
    //obter user
    return _user!;
  }
}
