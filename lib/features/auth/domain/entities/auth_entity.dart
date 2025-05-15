import 'package:equatable/equatable.dart';
import 'package:mybookstore/features/store/domain/entities/store_entity.dart';
import 'package:mybookstore/features/user/domain/entities/user_entity.dart';

class AuthEntity extends Equatable {
  final String refreshToken;
  final StoreEntity store;
  final String token;
  final UserEntity user;

  const AuthEntity({
    required this.refreshToken,
    required this.store,
    required this.token,
    required this.user,
  });

  @override
  List<Object?> get props => [refreshToken, store, token, user];
}
