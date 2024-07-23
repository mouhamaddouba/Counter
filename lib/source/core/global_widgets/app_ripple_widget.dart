import 'package:counter/source/core/values/constant/app_dimentions.dart';
import 'package:flutter/material.dart';

class AppRippleWidget extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final double? radius;
  final BorderRadius? borderRadius;

  const AppRippleWidget({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.child,
    this.radius = AppDimensions.radius10,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        radius: radius,
        borderRadius: borderRadius ??
            BorderRadius.all(
              Radius.circular(
                radius ?? AppDimensions.zero,
              ),
            ),
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
