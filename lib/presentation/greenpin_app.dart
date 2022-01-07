import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/core/app_constants.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/routing/main_router.gr.dart';

class GreenpinApp extends HookWidget {
  const GreenpinApp({
    required this.mainRouter,
    Key? key,
  }) : super(key: key);

  final MainRouter mainRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routeInformationParser: mainRouter.defaultRouteParser(),
      routerDelegate: mainRouter.delegate(),
    );
  }
}
