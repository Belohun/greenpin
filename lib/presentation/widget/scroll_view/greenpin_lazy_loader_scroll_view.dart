import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';

class GreenpinLazyLoaderScrollView extends HookWidget {
  const GreenpinLazyLoaderScrollView({
    required this.shouldLoadMore,
    required this.itemCount,
    required this.mainItemBuilder,
    required this.onPageEnd,
    this.topWidget,
    this.padding,
    this.bottomWidget,
    this.isSliver = false,
    Key? key,
  }) : super(key: key);

  final bool shouldLoadMore;
  final int itemCount;
  final IndexedWidgetBuilder mainItemBuilder;
  final VoidCallback onPageEnd;
  final Widget? topWidget;
  final Widget? bottomWidget;
  final EdgeInsets? padding;
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    final _topWidgetCount = useMemoized(
      () {
        return topWidget == null ? 0 : 1;
      },
      [topWidget],
    );

    final _widgetsCount = useMemoized(() {
      if (shouldLoadMore || (bottomWidget != null && !shouldLoadMore)) {
        return itemCount + 1 + _topWidgetCount;
      } else {
        return itemCount + _topWidgetCount;
      }
    }, [shouldLoadMore, itemCount]);

    if (isSliver) {
      return _SliverBuilder(
        padding: padding,
        topWidget: topWidget,
        shouldLoadMore: shouldLoadMore,
        widgetsCount: _widgetsCount,
        onPageEnd: onPageEnd,
        bottomWidget: bottomWidget,
        mainItemBuilder: mainItemBuilder,
        topWidgetCount: _topWidgetCount,
      );
    }

    return _ListViewBuilder(
      padding: padding,
      widgetsCount: _widgetsCount,
      topWidget: topWidget,
      shouldLoadMore: shouldLoadMore,
      onPageEnd: onPageEnd,
      bottomWidget: bottomWidget,
      mainItemBuilder: mainItemBuilder,
      topWidgetCount: _topWidgetCount,
    );
  }
}

class _ListViewBuilder extends StatelessWidget {
  const _ListViewBuilder({
    required this.padding,
    required this.widgetsCount,
    required this.topWidget,
    required this.shouldLoadMore,
    required this.onPageEnd,
    required this.bottomWidget,
    required this.mainItemBuilder,
    required this.topWidgetCount,
    Key? key,
  }) : super(key: key);

  final EdgeInsets? padding;
  final int widgetsCount;
  final Widget? topWidget;
  final bool shouldLoadMore;
  final VoidCallback onPageEnd;
  final Widget? bottomWidget;
  final IndexedWidgetBuilder mainItemBuilder;
  final int topWidgetCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding,
      itemCount: widgetsCount,
      itemBuilder: (context, index) {
        if (topWidget != null && index == 0) {
          return topWidget!;
        } else if (shouldLoadMore && index == widgetsCount - 1) {
          return _LazyScrollLoader(
            index: index,
            onPageEnd: onPageEnd,
          );
        } else if (bottomWidget != null &&
            !shouldLoadMore &&
            index == widgetsCount - 1) {
          return bottomWidget!;
        }
        return mainItemBuilder(context, index - topWidgetCount);
      },
    );
  }
}

class _SliverBuilder extends StatelessWidget {
  const _SliverBuilder({
    required this.padding,
    required this.topWidget,
    required this.shouldLoadMore,
    required this.widgetsCount,
    required this.onPageEnd,
    required this.bottomWidget,
    required this.mainItemBuilder,
    required this.topWidgetCount,
    Key? key,
  }) : super(key: key);

  final EdgeInsets? padding;
  final Widget? topWidget;
  final bool shouldLoadMore;
  final int widgetsCount;
  final VoidCallback onPageEnd;
  final Widget? bottomWidget;
  final IndexedWidgetBuilder mainItemBuilder;
  final int topWidgetCount;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (topWidget != null && index == 0) {
              return topWidget!;
            } else if (shouldLoadMore && index == widgetsCount - 1) {
              return _LazyScrollLoader(
                index: index,
                onPageEnd: onPageEnd,
              );
            } else if (bottomWidget != null &&
                !shouldLoadMore &&
                index == widgetsCount - 1) {
              return bottomWidget!;
            }
            return mainItemBuilder(context, index - topWidgetCount);
          },
          childCount: widgetsCount,
        ),
      ),
    );
  }
}

class _LazyScrollLoader extends HookWidget {
  const _LazyScrollLoader({
    required this.index,
    required this.onPageEnd,
    Key? key,
  }) : super(key: key);

  final int index;
  final VoidCallback onPageEnd;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      onPageEnd();
    }, [index]);

    return const SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(AppDimens.m),
        child: GreenpinLoader(),
      ),
    );
  }
}
