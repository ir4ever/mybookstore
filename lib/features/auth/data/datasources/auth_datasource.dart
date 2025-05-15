import 'package:mybookstore/core/errors/exceptions.dart';
import 'package:mybookstore/core/http/app_interceptor.dart';
import 'package:mybookstore/core/http/client_http.dart';
import 'package:mybookstore/features/auth/data/auth_endpoints.dart';
import 'package:mybookstore/features/auth/data/models/auth_model.dart';
import 'package:mybookstore/features/auth/domain/entities/auth_entity.dart';
import 'package:mybookstore/features/store/data/models/admin_store_model.dart';
import 'package:mybookstore/features/store/data/store_endpoints.dart';
import 'package:mybookstore/features/store/domain/entities/admin_store_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDatasource {
  Future<AuthEntity> signUp(AdminStoreEntity store);
  Future<AuthEntity> signIn(String user, String password);
}

class AuthDatasourceImpl implements AuthDatasource {
  const AuthDatasourceImpl({required ClientHttp client, required SharedPreferencesAsync prefs})
      : _client = client,
        _prefs = prefs;

  final ClientHttp _client;
  final SharedPreferencesAsync _prefs;

  @override
  Future<AuthEntity> signUp(AdminStoreEntity store) async {
    try {
      final storeModel = AdminStoreModel.fromEntity(store);
      final response = await _client.request(HttpMethod.post, StoreEndpoints.signUp.path, data: storeModel.toMap());
      if (response.statusCode == 200 && response.data != null) {
        final auth = AuthModel.fromMap(response.data);
        await _saveToken(auth.token);
        return auth;
      }
      throw ServerException(message: '${response.message}');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<AuthEntity> signIn(String user, String password) async {
    try {
      final data = {'user': user, 'password': password};
      final response = await _client.request(HttpMethod.post, AuthEndpoints.signIn.path, data: data);
      if (response.statusCode == 200 && response.data != null) {
        final auth = AuthModel.fromMap(response.data);
        await _saveToken(auth.token);
        return auth;
      }
      throw ServerException(message: '${response.message}');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> _saveToken(String token) async {
    _client.addInterceptor(AppInterceptor(token: token));
    await _prefs.setString('token', token);
  }
}
