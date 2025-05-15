class AppConfig {
  final Enviroment env;

  const AppConfig._({required this.env});

  static AppConfig? _instance;

  static AppConfig get instance {
    assert(_instance != null, 'AppConfig não foi inicializado.');
    return _instance!;
  }

  static void init(Enviroment env) {
    _instance = AppConfig._(env: env);
  }

  static bool get isProd => instance.env == Enviroment.prod;

  static String get urlBase => instance.env.urlBase;
}

enum Enviroment {
  prod(
    urlBase: 'https://api-flutter-prova.hml.sesisenai.org.br/',
    label: 'Produção',
  ),
  hml(
    urlBase: 'https://api-flutter-prova-qa.hml.sesisenai.org.br/',
    label: 'Homologação',
  );

  final String urlBase;
  final String label;

  const Enviroment({required this.urlBase, required this.label});

  static Enviroment fromArgs() {
    const profile = String.fromEnvironment('PROFILE');
    return Enviroment.values.firstWhere(
      (e) => e.name == profile,
      orElse: () => Enviroment.hml,
    );
  }
}
