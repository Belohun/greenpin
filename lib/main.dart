import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:greenpin/core/bloc/simple_bloc_observer.dart';
import 'package:greenpin/data/product/entity/product_entity.dart';
import 'package:greenpin/domain/language/language_code.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/greenpin_app.dart';
import 'package:greenpin/presentation/routing/main_router.gr.dart';
import 'package:greenpin/core/di_config.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> runMain(String env) async {
  await initHive();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await configureDependencies(env);

  final mainRouter = MainRouter();

  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: availableLocales.values.toList(),
    fallbackLocale: availableLocales[fallbackLanguageCode],
    useOnlyLangCode: true,
    saveLocale: true,
    child: GreenpinApp(mainRouter: mainRouter),
  ));
}

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ProductEntityAdapter());
}
