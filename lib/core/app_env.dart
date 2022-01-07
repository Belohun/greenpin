class AppEnv {
  static const devName = 'dev';
  static const prodName = 'prod';

  final String name;
  final String apiUrl;

  AppEnv._(
      this.name, {
        required this.apiUrl,
      });

  factory AppEnv.development() {
    return AppEnv._(
      devName,
      apiUrl: 'https://greenpin-api-dev.herokuapp.com/',
    );
  }

  factory AppEnv.production() {
    return AppEnv._(
      prodName,
      apiUrl: 'https://greenpin-api-prod.herokuapp.com/',
    );
  }
}
