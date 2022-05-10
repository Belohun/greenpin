import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';

class GreenpinCachedImage extends HookWidget {
  final String? url;
  final double? height;
  final double? width;
  final BoxFit imageFit;
  final BorderRadius borderRadius;
  final Widget? placeHolder;
  final Color? color;

  const GreenpinCachedImage({
    required this.url,
    this.height = AppDimens.xxxl,
    this.width = AppDimens.xxxl,
    this.imageFit = BoxFit.cover,
    this.borderRadius = const BorderRadius.all(Radius.circular(AppDimens.ss)),
    this.placeHolder,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxMemWidth = useMemoized(() => MediaQuery.of(context).size.width / 2,
        [MediaQuery.of(context).size]);

    if (url?.isEmpty ?? false) {
      return placeHolder ??
          ClipRRect(
            borderRadius: borderRadius,
            child: SvgPicture.asset(
              'assets/img/placeholder_icon.svg',
              width: width,
              height: height,
            ),
          );
    } else {
      return CachedNetworkImage(
        memCacheWidth: maxMemWidth.toInt(),
        memCacheHeight: maxMemWidth.toInt(),
        height: height,
        width: width,
        imageUrl: url!,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
            image: DecorationImage(
              image: imageProvider,
              fit: imageFit,
            ),
          ),
        ),
        placeholder: (context, string) => Container(
            height: AppDimens.xxl,
            width: AppDimens.xxl,
            child: const CircularProgressIndicator()),
        errorWidget: (context, string, dynamic) => SvgPicture.asset(
          'assets/img/placeholder_icon.svg',
          width: width,
          height: height,
        ),
      );
    }
  }
}
