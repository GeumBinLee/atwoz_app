import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/theme.dart';
import '../view/progress_indicator.dart';

class AppTextButton extends ConsumerWidget {
  const AppTextButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.padding = AppDimens.buttonPadding,
    this.primary,
    this.expandedWidth = true,
    this.isLoading = false,
    this.alignment,
    this.height = AppDimens.buttonHeight,
    this.width = 0.0,
    this.borderRadius = AppDimens.buttonRadius,
  });

  final Widget child;

  final Color? primary;

  final EdgeInsetsGeometry padding;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final ValueChanged<bool>? onHover;

  final ValueChanged<bool>? onFocusChange;

  final bool expandedWidth;

  final AlignmentGeometry? alignment;

  final bool isLoading;

  final double height;

  final double width;

  final BorderRadiusGeometry borderRadius;

  bool get isDisable => onPressed == null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color foregroundColor = primary ?? context.colorScheme.primary;
    final Color? disabledForegroundColor = primary?.withOpacity(0.2);

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        disabledForegroundColor: disabledForegroundColor,
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        textStyle: AppStyles.body01Medium(),
        minimumSize: Size(
          expandedWidth ? double.infinity : width,
          height,
        ),
        alignment: alignment,
      ),
      onPressed: isLoading ? () {} : onPressed,
      onLongPress: isLoading ? () {} : onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      child: AnimatedSize(
        duration: AppParams.animationDurationFast,
        curve: Curves.fastOutSlowIn,
        child: isLoading
            ? SizedBox(
                height: height - padding.vertical,
                child: FittedBox(
                    child:
                        AppCircularProgressIndicator(color: foregroundColor)),
              )
            : child,
      ),
    );
  }
}
