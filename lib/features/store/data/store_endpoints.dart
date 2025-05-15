const _basePath = 'v1/store';

enum StoreEndpoints {
  signUp(_basePath);

  final String path;
  const StoreEndpoints(this.path);
}
