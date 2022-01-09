import 'package:greenpin/core/app_env.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ConfigModule {
  @dev
  @Singleton()
  AppEnv get devEnv => AppEnv.development();

  @prod
  @Singleton()
  AppEnv get prodDev => AppEnv.production();
}
