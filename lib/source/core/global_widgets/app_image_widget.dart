// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:counter/source/core/global_widgets/app_image_preview_widget.dart';
import 'package:counter/source/core/values/constant/app_assets.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppImageWidget extends StatelessWidget {
  final String? path;
  final String? pathWithoutCompressing;
  final dynamic tag;
  final String? secondPath;
  final Color? color;
  final Color? backgroundColor;
  final bool? keepOriginalColor;
  final bool deleteCashAfter1Day;
  final BoxFit fit;
  final double? width;
  final double? height;
  final double scale;
  final bool fileWithPlaceholder;
  final bool isCircle;
  final bool isRounded;
  final double radius;
  final bool isPadding;
  final bool isCenter;
  final Border? border;
  final bool disablePreview;
  final Function? onPressed;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const AppImageWidget({
    super.key,
    this.path,
    this.pathWithoutCompressing,
    this.tag,
    this.secondPath,
    this.fit = BoxFit.contain,
    this.keepOriginalColor,
    this.color,
    this.backgroundColor,
    this.width,
    this.height,
    this.scale = 1.0,
    this.fileWithPlaceholder = false,
    this.border,
    this.onPressed,
    this.isCircle = false,
    this.isRounded = false,
    this.radius = AppDimensions.radius10,
    this.disablePreview = true,
    this.isPadding = true,
    this.isCenter = true,
    this.errorBuilder,
    this.deleteCashAfter1Day = false,
  });

  @override
  Widget build(BuildContext context) {
    final heroTag = tag ?? UniqueKey();
    Widget? child;
    if (path?.isEmpty == true) {
      if (secondPath != null) {
        child = Image.asset(
          secondPath!,
          color: color,
          width: width,
          height: height,
          fit: fit,
          scale: scale,
        );
      } else {
        child = Padding(
          padding: isPadding
              ? EdgeInsets.only(
                  bottom: isCenter
                      ? AppDimensions.zero
                      : AppDimensions.paddingOrMargin70,
                )
              : EdgeInsets.zero,
          child: Center(
            child: Image.asset(
              path ?? AppConstants.emptyText,
              width: AppDimensions.width200,
              scale: scale,
            ),
          ),
        );
      }
    } else if (path?.contains("http") == true) {
      child = CachedNetworkImage(
        cacheManager: CacheManager(
          Config(
            'cacheImages',
            stalePeriod: Duration(days: deleteCashAfter1Day ? 1 : 90),
          ),
        ),
        imageUrl: path!,
        fit: fit,
        height: height,
        width: width,
        color: color,
        placeholder: (_, __) {
          return LayoutBuilder(
            builder: (context, c) {
              return Padding(
                padding: isPadding
                    ? EdgeInsets.only(
                        bottom: isCenter
                            ? AppDimensions.zero
                            : AppDimensions.paddingOrMargin70,
                      )
                    : EdgeInsets.zero,
                child: Center(
                  child: Image.asset(
                    AppAssets.logo,
                    width: AppDimensions.width200,
                    scale: scale,
                  ),
                ),
              );
            },
          );
        },
        errorWidget: (_, __, ___) {
          return LayoutBuilder(
            builder: (context, c) {
              return Padding(
                padding: isPadding
                    ? EdgeInsets.only(
                        bottom: isCenter
                            ? AppDimensions.zero
                            : AppDimensions.paddingOrMargin70,
                      )
                    : EdgeInsets.zero,
                child: Center(
                  child: Image.asset(
                    AppAssets.logo,
                    width: AppDimensions.width200,
                    scale: scale,
                  ),
                ),
              );
            },
          );
        },
      );
    } else if (path?.split(".").last == "svg") {
      child = SvgPicture.asset(
        path!,
        color: color,
        width: width,
        height: height,
        fit: BoxFit.scaleDown,
      );
    } else if (path?.startsWith("asset") == true) {
      child = Image.asset(
        path!,
        color: color,
        width: width,
        height: height,
        fit: fit,
        scale: scale,
      );
    } else {
      child = fileWithPlaceholder
          ? FadeInImage(
              placeholderFit: BoxFit.scaleDown,
              placeholder: const AssetImage(
                AppAssets.logo,
              ),
              image: FileImage(
                File(path!),
                scale: scale,
              ),
              width: width,
              height: height,
              fit: fit,
            )
          : Image.file(
              File(path ?? AppAssets.logo),
              color: color,
              width: width,
              height: height,
              fit: fit,
              scale: scale,
              errorBuilder: errorBuilder,
            );
    }
    return GestureDetector(
      onTap: (disablePreview && onPressed == null)
          ? null
          : () {
              if (onPressed != null) {
                onPressed!();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AppImagePreviewWidget(
                        path: pathWithoutCompressing ?? path!,
                        tag: heroTag,
                      );
                    },
                  ),
                );
              }
            },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle
              ? null
              : isRounded
                  ? BorderRadius.all(
                      Radius.circular(
                        radius,
                      ),
                    )
                  : null,
          border: border,
          color: backgroundColor,
        ),
        foregroundDecoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle
              ? null
              : isRounded
                  ? BorderRadius.all(
                      Radius.circular(
                        radius,
                      ),
                    )
                  : null,
          border: border,
        ),
        clipBehavior: Clip.antiAlias,
        child: Hero(
          tag: heroTag,
          child: child,
        ),
      ),
    );
  }
}
