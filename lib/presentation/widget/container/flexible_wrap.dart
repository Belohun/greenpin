import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef FlexibleWrapChildrenBuilder = List<Widget> Function(double width);

class FlexibleWrap extends StatelessWidget {
  const FlexibleWrap({
    required this.childrenBuilder,
    required this.childrenRowCount,
    this.spacing = 0,
    Key? key,
  }) : super(key: key);

  final FlexibleWrapChildrenBuilder childrenBuilder;
  final double spacing;
  final int childrenRowCount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _HookWrap(
          spacing: spacing,
          childrenBuilder: childrenBuilder,
          childrenRowCount: childrenRowCount,
          constraints: constraints,
        );
      },
    );
  }
}

class _HookWrap extends HookWidget {
  const _HookWrap({
    required this.constraints,
    required this.spacing,
    required this.childrenBuilder,
    required this.childrenRowCount,
    Key? key,
  }) : super(key: key);

  final double spacing;
  final FlexibleWrapChildrenBuilder childrenBuilder;
  final BoxConstraints constraints;
  final int childrenRowCount;

  @override
  Widget build(BuildContext context) {
    final flexWidth = useMemoized(
          () => (constraints.maxWidth - spacing) / childrenRowCount,
      [constraints.maxWidth],
    );
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: spacing,
      spacing: spacing,
      children: childrenBuilder(flexWidth),
    );
  }
}
