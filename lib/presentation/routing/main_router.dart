import 'package:auto_route/auto_route.dart';
import 'package:greenpin/presentation/home_page/home_page.dart';

@AdaptiveAutoRouter(
  routes: [
    AutoRoute(
      page: HomePage,
      initial: true,
    ),
  ],
)
class $MainRouter {}
