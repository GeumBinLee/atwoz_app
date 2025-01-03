import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/theme.dart';
import 'app_icon.dart';

class AppErrorImage extends ConsumerWidget {
  const AppErrorImage({
    super.key,
    this.width,
    this.height,
    this.isRounded = false,
    this.borderRadius,
    this.image,
  });

  final double? width, height;
  final bool isRounded;
  final BorderRadiusGeometry? borderRadius;
  final String? image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.appColors.shadow,
        shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: borderRadius,
      ),
      child: AppIcon(
        image ?? AppIcons.icImage,
        size: height ?? width ?? AppDimens.iconSize,
        colorFilter: AppIcon.fillColor(context.colorScheme.primary),
      ),
    );
  }
}
