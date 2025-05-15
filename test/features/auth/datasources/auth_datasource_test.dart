import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mybookstore/core/errors/exceptions.dart';
import 'package:mybookstore/core/http/client_http.dart';
import 'package:mybookstore/features/auth/data/auth_endpoints.dart';
import 'package:mybookstore/features/auth/data/datasources/auth_datasource.dart';
import 'package:mybookstore/features/auth/data/models/auth_model.dart';
import 'package:mybookstore/features/auth/domain/entities/auth_entity.dart';
import 'package:mybookstore/features/store/data/models/admin_store_model.dart';
import 'package:mybookstore/features/store/data/models/store_model.dart';
import 'package:mybookstore/features/store/data/store_endpoints.dart';
import 'package:mybookstore/features/user/data/models/admin_user_model.dart';
import 'package:mybookstore/features/user/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockClient extends Mock implements ClientHttp {}

class MockPrefs extends Mock implements SharedPreferencesAsync {}

void main() {
  late AuthDatasource datasource;
  late MockClient client;
  late MockPrefs prefs;

  setUp(() {
    client = MockClient();
    prefs = MockPrefs();
    datasource = AuthDatasourceImpl(client: client, prefs: prefs);

    // O mock do SharedPreferencesAsync nao implementa o metodo setString, entao precisamos mockar ele
    when(() => prefs.setString(any(), any())).thenAnswer((_) async => true);
  });

  const authModel = AuthModel(
    token: 'token',
    user: UserModel(id: 1, name: 'name', photo: 'photo', role: 'role'),
    refreshToken: '',
    store: StoreModel(banner: 'banner', id: 1, name: 'name', slogan: 'slogan'),
  );

  const adminModel = AdminStoreModel(
    banner: 'banner',
    name: 'name',
    slogan: 'slogan',
    admin: AdminUserModel(
      userName: 'userName',
      name: 'name',
      photo: 'photo',
      role: 'role',
      password: 'password',
    ),
  );

  group('AuthDatasourceImpl', () {
    test('signIn should return AuthEntity on success', () async {
      when(() => client.request(HttpMethod.post, AuthEndpoints.signIn.path, data: any(named: 'data')))
          .thenAnswer((_) async => HttpResponse(data: authModel.toMap(), statusCode: 200));

      final auth = await datasource.signIn('user', 'password');

      expect(auth, isA<AuthEntity>());
      expect(auth.token, authModel.token);
      verify(() => prefs.setString('token', authModel.token)).called(1);
    });

    test('signIn should throw ServerException on failure', () async {
      when(() => client.request(HttpMethod.post, AuthEndpoints.signIn.path, data: any(named: 'data')))
          .thenThrow(ServerException(message: 'Error'));

      expect(
        () async => await datasource.signIn('user', 'password'),
        throwsA(isA<ServerException>()),
      );
    });

    test('signUp should return AuthEntity on success', () async {
      when(() => client.request(HttpMethod.post, StoreEndpoints.signUp.path, data: any(named: 'data')))
          .thenAnswer((_) async => HttpResponse(data: authModel.toMap(), statusCode: 200));

      final auth = await datasource.signUp(adminModel);

      expect(auth, isA<AuthEntity>());
      expect(auth.token, authModel.token);
      verify(() => prefs.setString('token', authModel.token)).called(1);
    });

    test('signUp should throw ServerException on failure', () async {
      when(() => client.request(HttpMethod.post, StoreEndpoints.signUp.path, data: any(named: 'data')))
          .thenThrow(ServerException(message: 'Error'));

      expect(
        () async => await datasource.signUp(adminModel),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
