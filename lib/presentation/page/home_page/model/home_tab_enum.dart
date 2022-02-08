import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenpin/exports.dart';

enum HomeTabEnum {
  shopping,
  orders,
  cart,
  profile,
}

extension HomeTabEnumExtension on HomeTabEnum {
  String get name {
    switch (this) {
      case HomeTabEnum.shopping:
        return LocaleKeys.shopping.tr();

      case HomeTabEnum.orders:
        return LocaleKeys.orders.tr();

      case HomeTabEnum.cart:
        return LocaleKeys.cart.tr();

      case HomeTabEnum.profile:
        return LocaleKeys.profile.tr();
    }
  }

  IconData get icon {
    switch (this) {
      case HomeTabEnum.shopping:
        return Icons.store;

      case HomeTabEnum.orders:
        return Icons.receipt;

      case HomeTabEnum.cart:
        return Icons.local_grocery_store;

      case HomeTabEnum.profile:
        return Icons.person;
    }
  }
}
