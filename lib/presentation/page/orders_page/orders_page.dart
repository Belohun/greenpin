import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenpin/presentation/page/home_page/model/home_tab_enum.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenpinAppbar.green(
        leading: const SizedBox.shrink(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
            child: Icon(
              HomeTabEnum.orders.icon,
              size: AppDimens.iconButtonSize,
            ),
          ),
        ],
        title: HomeTabEnum.orders.name,
      ),
      body: Text('Orders'),
    );
  }
}
