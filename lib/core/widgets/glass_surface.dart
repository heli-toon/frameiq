import 'dart:ui';
import 'package:flutter/material.dart';

/// A reusable glassmorphic surface that provides a subtle translucent tint,
/// soft backdrop blur, and a crisp, fine hairline border.
///
/// Designed to be used sparingly for elevated layers such as floating panels,
/// HUD overlays, dialogs, and floating navigation bars.
class GlassSurface extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double blurSigma;
  final Color? surfaceColor;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;

  const GlassSurface({
    super.key,
    required this.child,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.padding,
    this.margin,
    this.blurSigma = 14.0,
    this.surfaceColor,
    this.borderColor,
    this.borderWidth = 0.8,
    this.onTap,
  });

  /// Factory for pill / stadium shaped floating controls
  factory GlassSurface.pill({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double blurSigma = 14.0,
    Color? surfaceColor,
    Color? borderColor,
    double borderWidth = 0.8,
    VoidCallback? onTap,
  }) {
    return GlassSurface(
      key: key,
      borderRadius: BorderRadius.circular(999),
      padding: padding,
      margin: margin,
      blurSigma: blurSigma,
      surfaceColor: surfaceColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      onTap: onTap,
      child: child,
    );
  }

  /// Factory for circular glass floating buttons
  factory GlassSurface.circle({
    Key? key,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double blurSigma = 14.0,
    Color? surfaceColor,
    Color? borderColor,
    double borderWidth = 0.8,
    VoidCallback? onTap,
  }) {
    return GlassSurface(
      key: key,
      shape: BoxShape.circle,
      padding: padding,
      margin: margin,
      blurSigma: blurSigma,
      surfaceColor: surfaceColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      onTap: onTap,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Subtle, legible transparency matching the theme
    final resolvedSurfaceColor = surfaceColor ??
        (isDark
            ? const Color(0xFF0F172A).withValues(alpha: 0.70)
            : Colors.white.withValues(alpha: 0.78));

    // Crisp fine hairline border
    final resolvedBorderColor = borderColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.14)
            : Colors.black.withValues(alpha: 0.08));

    final effectiveRadius = shape == BoxShape.circle
        ? null
        : (borderRadius ?? BorderRadius.circular(16));

    Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: resolvedSurfaceColor,
        shape: shape,
        borderRadius: effectiveRadius,
        border: Border.all(
          color: resolvedBorderColor,
          width: borderWidth,
        ),
      ),
      child: child,
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: shape == BoxShape.circle
              ? const CircleBorder()
              : (effectiveRadius != null
                  ? RoundedRectangleBorder(borderRadius: effectiveRadius)
                  : null),
          child: content,
        ),
      );
    }

    Widget blurred = ClipRRect(
      borderRadius: effectiveRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: content,
      ),
    );

    if (shape == BoxShape.circle) {
      blurred = ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: content,
        ),
      );
    }

    if (margin != null) {
      return Padding(
        padding: margin!,
        child: blurred,
      );
    }

    return blurred;
  }
}
