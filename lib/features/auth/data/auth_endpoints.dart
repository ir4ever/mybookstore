const _basePath = 'v1/auth';

enum AuthEndpoints {
  signIn(_basePath),
  getAuthEntity(_basePath),
  validateToken('$_basePath/validateToken');

  final String path;
  const AuthEndpoints(this.path);
}
