import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mybookstore/core/errors/exceptions.dart';
import 'package:mybookstore/features/auth/data/datasources/auth_datasource.dart';
import 'package:mybookstore/features/auth/domain/entities/auth_entity.dart';
import 'package:mybookstore/features/auth/domain/repositories/auth_repository.dart';
import 'package:mybookstore/features/store/domain/entities/admin_store_entity.dart';
import 'package:mybookstore/features/store/domain/entities/store_entity.dart';
import 'package:mybookstore/features/user/domain/entities/admin_user_entity.dart';
import 'package:mybookstore/features/user/domain/entities/user_entity.dart';

class MockAuthDatasource extends Mock implements AuthDatasource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthDatasource datasource;

  setUp(() {
    datasource = MockAuthDatasource();
    repository = AuthRepositoryImpl(datasource: datasource);
  });

  const authEntity = AuthEntity(
    token: 'token',
    refreshToken: 'refreshToken',
    store: StoreEntity(id: 1, name: 'name', slogan: 'slogan', banner: 'banner'),
    user: UserEntity(name: 'name', photo: 'photo', role: 'role'),
  );

  const adminEntity = AdminStoreEntity(
    banner: 'banner',
    name: 'name',
    slogan: 'slogan',
    admin: AdminUserEntity(
      userName: 'userName',
      name: 'name',
      photo: 'photo',
      role: 'role',
      password: 'password',
    ),
  );

  group('AuthRepositoryImpl', () {
    test('should return AuthEntity when signIn succeeds', () async {
      when(() => datasource.signIn('user', 'password')).thenAnswer((_) async => authEntity);

      final result = await repository.signIn(user: 'user', password: 'password');

      expect(result, isA<AuthEntity>());
      expect(result?.token, equals(authEntity.token));
      verify(() => datasource.signIn('user', 'password')).called(1);
    });

    test('should throw ServerException when signIn fails', () async {
      when(() => datasource.signIn('user', 'password')).thenThrow(ServerException(message: 'Error'));

      expect(
        () => repository.signIn(user: 'user', password: 'password'),
        throwsA(isA<ServerException>()),
      );
      verify(() => datasource.signIn('user', 'password')).called(1);
    });

    test('should return AuthEntity when signUp succeeds', () async {
      when(() => datasource.signUp(adminEntity)).thenAnswer((_) async => authEntity);

      final result = await repository.signUp(adminEntity);

      expect(result, isA<AuthEntity>());
      expect(result?.token, equals(authEntity.token));
      verify(() => datasource.signUp(adminEntity)).called(1);
    });

    test('should throw ServerException when signUp fails', () async {
      when(() => datasource.signUp(adminEntity)).thenThrow(ServerException(message: 'Error'));

      expect(
        () => repository.signUp(adminEntity),
        throwsA(isA<ServerException>()),
      );
      verify(() => datasource.signUp(adminEntity)).called(1);
    });
  });
}
