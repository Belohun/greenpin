import 'package:flutter/cupertino.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_shadows.dart';

class GreenpinCard extends StatelessWidget {
  const GreenpinCard({
    required this.child,
    this.shadow = AppShadows.cardShadow,
    this.borderRadius = const BorderRadius.all(Radius.circular(AppDimens.cardRadius)),
    this.footer,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  final BoxShadow shadow;
  final Widget child;
  final double? height;
  final double? width;
  final Widget? footer;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: borderRadius,
      color: AppColors.white,
      boxShadow: [shadow],
    ),
    child: child,
  );
}
