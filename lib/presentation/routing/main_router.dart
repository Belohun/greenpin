import 'package:auto_route/auto_route.dart';
import 'package:greenpin/presentation/page/cart_page/cart_page.dart';
import 'package:greenpin/presentation/page/categories_page/categories_page.dart';
import 'package:greenpin/presentation/page/category_page/category_page.dart';
import 'package:greenpin/presentation/page/edit_user_data_page/edit_user_page.dart';
import 'package:greenpin/presentation/page/edit_user_email/edit_user_email_page.dart';
import 'package:greenpin/presentation/page/edit_user_password/edit_user_password_page.dart';
import 'package:greenpin/presentation/page/entry_page/entry_page.dart';
import 'package:greenpin/presentation/page/home_page/home_page.dart';
import 'package:greenpin/presentation/page/login_page/login_page.dart';
import 'package:greenpin/presentation/page/orders_page/orders_page.dart';
import 'package:greenpin/presentation/page/product_page/product_page.dart';
import 'package:greenpin/presentation/page/profile_page/profile_page.dart';
import 'package:greenpin/presentation/page/register_page/register_page.dart';
import 'package:greenpin/presentation/page/shoping_page/shopping_page.dart';

@AdaptiveAutoRouter(
  routes: [
    AutoRoute(
      page: EntryPage,
      initial: true,
    ),
    AutoRoute(
      page: HomePage,
      children: [
        AutoRoute(
          page: EmptyRouterPage,
          name: 'ShoppingTabGroupRouter',
          initial: true,
          children: [
            AutoRoute(
              page: ShoppingPage,
              initial: true,
            ),
            AutoRoute(page: CategoriesPage),
            AutoRoute(page: CategoryPage),
            AutoRoute(page: ProductPage),
          ],
        ),
        AutoRoute(page: OrdersPage),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'CartTabGroupRouter',
          children: [
            AutoRoute(
              page: CartPage,
              initial: true,
            ),
            AutoRoute(page: ProductPage),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'ProfileTabGroupRouter',
          children: [
            AutoRoute(
              page: ProfilePage,
              initial: true,
            ),
            AutoRoute(page: EditUserPage),
            AutoRoute(page: EditUserEmailPage),
            AutoRoute(page: EditUserPasswordPage),
          ],
        ),
      ],
    ),
    AutoRoute(page: LoginPage),
    AutoRoute(page: RegisterPage),
  ],
)
class $MainRouter {}
