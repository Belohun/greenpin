import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:greenpin/core/bloc/simple_bloc_observer.dart';
import 'package:greenpin/domain/language/language_code.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/greenpin_app.dart';
import 'package:greenpin/presentation/routing/main_router.gr.dart';
import 'package:greenpin/core/di_config.dart';

Future<void> runMain(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  configureDependencies(env);

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
