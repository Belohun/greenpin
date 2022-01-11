import 'package:auto_route/auto_route.dart';
import 'package:greenpin/presentation/page/entry_page/entry_page.dart';
import 'package:greenpin/presentation/page/home_page/home_page.dart';
import 'package:greenpin/presentation/page/login_page/login_page.dart';
import 'package:greenpin/presentation/page/register_page/register_page.dart';

@AdaptiveAutoRouter(
  routes: [
    AutoRoute(
      page: EntryPage,
      initial: true,
    ),
    AutoRoute(page: HomePage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: RegisterPage),
  ],
)
class $MainRouter {}
