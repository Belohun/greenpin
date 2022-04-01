import 'package:get_it/get_it.dart';
import 'package:greenpin/core/app_env.dart';
import 'package:greenpin/core/di_config.config.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

const dev = Environment(AppEnv.devName);
const prod = Environment(AppEnv.prodName);

@InjectableInit(preferRelativeImports: false)
void configureDependencies(String env) => $initGetIt(getIt, environment: env);
