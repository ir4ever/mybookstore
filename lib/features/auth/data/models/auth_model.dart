import 'package:mybookstore/features/auth/domain/entities/auth_entity.dart';
import 'package:mybookstore/features/store/data/models/store_model.dart';
import 'package:mybookstore/features/user/data/models/user_model.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.user,
    required super.token,
    required super.store,
    required super.refreshToken,
  });

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      user: UserModel.fromMap(map['user']),
      token: map['token'],
      store: StoreModel.fromMap(map['store']),
      refreshToken: map['refreshToken'],
    );
  }

  Map<String, dynamic> toMap() {
    final userModel = UserModel.fromEntity(user);
    final storeModel = StoreModel.fromEntity(store);
    return {
      'user': userModel.toMap(),
      'token': token,
      'store': storeModel.toMap(),
      'refreshToken': refreshToken,
    };
  }
}
