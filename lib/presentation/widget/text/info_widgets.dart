import 'package:flutter/cupertino.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_typography.dart';

class GreenpinHeader extends StatelessWidget {
  const GreenpinHeader({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.headline1Bold.copyWith(color: AppColors.gray),
    );
  }
}

class GreenpinSubHeader extends StatelessWidget {
  const GreenpinSubHeader({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.bodyText1,
      textAlign: TextAlign.center,
    );
  }
}
