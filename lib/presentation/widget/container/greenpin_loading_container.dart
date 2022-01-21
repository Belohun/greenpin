import 'package:flutter/material.dart';
import 'package:greenpin/presentation/style/app_colors.dart';

class GreenpinLoadingContainer extends StatelessWidget {
  const GreenpinLoadingContainer({
    required this.child,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          child,
          if (isLoading)
            Container(
              color: Colors.transparent,
              child: const Center(
                  child: CircularProgressIndicator(color: AppColors.primary)),
            ),
        ],
      );
}
