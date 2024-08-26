import 'dart:async';

import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:flutter/material.dart';

class AnimationTransaction extends StatefulWidget {
  final Curve curve;
  final Widget child;
  final double offset;
  final Duration delayStart;
  final Duration animationDuration;
  final AlignmentGeometry alignmentGeometry;

  const AnimationTransaction({
    super.key,
    required this.child,
    this.curve = Curves.easeIn,
    this.offset = AppConstants.opacity01,
    this.delayStart = const Duration(
      seconds: AppConstants.duration00,
    ),
    this.animationDuration = const Duration(
      milliseconds: AppConstants.duration800,
    ),
    this.alignmentGeometry = Alignment.centerRight,
  });

  @override
  State<AnimationTransaction> createState() => _AnimationTransactionState();
}

class _AnimationTransactionState extends State<AnimationTransaction>
    with SingleTickerProviderStateMixin {
  Animation<Offset>? _animationSlide;

  AnimationController? _animationController;

  Animation<double>? _animationFade;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animationSlide = Tween<Offset>(
      begin: Offset(
        AppDimensions.zero,
        widget.offset,
      ),
      end: AppConstants.offset00,
    ).animate(
      CurvedAnimation(
        curve: widget.curve,
        parent: _animationController!,
      ),
    );

    _animationFade = Tween<double>(
      begin: -AppDimensions.zero,
      end: AppDimensions.elevation01,
    ).animate(
      CurvedAnimation(
        curve: widget.curve,
        parent: _animationController!,
      ),
    );

    Timer(widget.delayStart, () {
      _animationController?.forward();
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationFade!,
      child: SlideTransition(
        position: _animationSlide!,
        child: widget.child,
      ),
    );
  }
}
