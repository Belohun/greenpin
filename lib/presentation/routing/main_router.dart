import 'package:auto_route/auto_route.dart';
import 'package:greenpin/presentation/page/edit_user_data_page/edit_user_page.dart';
import 'package:greenpin/presentation/page/edit_user_email/edit_user_email_page.dart';
import 'package:greenpin/presentation/page/edit_user_password/edit_user_password_page.dart';
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
    AutoRoute(page: EditUserPage),
    AutoRoute(page: EditUserEmailPage),
    AutoRoute(page: EditUserPasswordPage)
  ],
)
class $MainRouter {}
