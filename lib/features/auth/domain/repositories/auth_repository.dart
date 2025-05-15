import 'dart:async';

import 'package:mybookstore/features/auth/data/datasources/auth_datasource.dart';
import 'package:mybookstore/features/auth/domain/entities/auth_entity.dart';
import 'package:mybookstore/features/store/domain/entities/admin_store_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { authenticated, unauthenticated }

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  Future<AuthEntity?> signUp(AdminStoreEntity store);
  Future<AuthEntity?> signIn({required String user, required String password});
  AuthEntity? getAuthEntity();
  void signOut();
  void dispose();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthDatasource datasource}) : _datasource = datasource;

  final AuthDatasource _datasource;

  final _authStatusController = StreamController<AuthStatus>();
  AuthEntity? _authEntity;

  @override
  Stream<AuthStatus> get status async* {
    yield AuthStatus.unauthenticated;
    yield* _authStatusController.stream;
  }

  @override
  Future<AuthEntity?> signIn({required String user, required String password}) async {
    try {
      _authEntity = await _datasource.signIn(user, password);
      _authStatusController.add(AuthStatus.authenticated);
      return _authEntity;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthEntity?> signUp(AdminStoreEntity store) async {
    try {
      _authEntity = await _datasource.signUp(store);
      _authStatusController.add(AuthStatus.authenticated);
      return _authEntity;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void signOut() {
    final prefs = SharedPreferencesAsync();
    _authStatusController.add(AuthStatus.unauthenticated);
    _authEntity = null;
    prefs.clear();
  }

  @override
  void dispose() {
    _authStatusController.close();
  }

  @override
  AuthEntity? getAuthEntity() {
    return _authEntity;
  }
}
