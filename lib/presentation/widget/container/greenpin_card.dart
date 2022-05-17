import 'package:flutter/cupertino.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_shadows.dart';

class GreenpinCard extends StatelessWidget {
  const GreenpinCard({
    required this.child,
    this.shadow = AppShadows.cardShadow,
    this.borderRadius = BorderRadius.zero,
    this.footer,
    this.height,
    this.width,
    this.padding,
    Key? key,
  }) : super(key: key);

  final BoxShadow shadow;
  final Widget child;
  final double? height;
  final double? width;
  final Widget? footer;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
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
