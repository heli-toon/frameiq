import 'package:flutter/material.dart';

/// A high-precision vector widget that renders the FrameIQ brand icon.
///
/// Captures the brand's core identity:
/// - The architectural 'F' viewfinder caliper (composition framing)
/// - The complementary bottom-right camera framing corner
/// - The intelligent lens core & coaching reticle (positioned at the Rule of Thirds power point)
class FrameIQLogo extends StatelessWidget {
  /// The width and height of the square icon. Defaults to 36.0.
  final double size;

  /// Optional override for the primary caliper color.
  /// Defaults to Obsidian Slate (`#0F172A`) in light mode and Crisp Off-White (`#F8FAFC`) in dark mode.
  final Color? color;

  /// Optional override for the lens core accent color.
  /// Defaults to Camera Lens Blue (`#2563EB` / `#3B82F6`).
  final Color? accentColor;

  /// Optional override for the inner pupil core color.
  /// If null, matches the ambient background or contrasting tone.
  final Color? pupilColor;

  /// Whether to render as a single-ink monochrome silhouette.
  final bool isMonochrome;

  const FrameIQLogo({
    super.key,
    this.size = 36.0,
    this.color,
    this.accentColor,
    this.pupilColor,
    this.isMonochrome = false,
  });

  /// Factory constructor for a single-color silhouette (ideal for buttons, monochrome watermarks, etc.)
  const FrameIQLogo.monochrome({
    super.key,
    this.size = 24.0,
    required Color color,
  })  : color = color,
        accentColor = color,
        pupilColor = Colors.transparent,
        isMonochrome = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final primaryColor = color ?? (isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A));
    final lensAccent = isMonochrome
        ? primaryColor
        : (accentColor ?? (isDark ? const Color(0xFF3B82F6) : const Color(0xFF2563EB)));
    final pupil = isMonochrome
        ? Colors.transparent
        : (pupilColor ?? (isDark ? const Color(0xFF090D16) : Colors.white));

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: FrameIQLogoPainter(
          primaryColor: primaryColor,
          accentColor: lensAccent,
          pupilColor: pupil,
          isMonochrome: isMonochrome,
        ),
      ),
    );
  }
}

/// CustomPainter rendering the exact mathematical vectors of the FrameIQ brand mark.
class FrameIQLogoPainter extends CustomPainter {
  final Color primaryColor;
  final Color accentColor;
  final Color pupilColor;
  final bool isMonochrome;

  const FrameIQLogoPainter({
    required this.primaryColor,
    required this.accentColor,
    required this.pupilColor,
    this.isMonochrome = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 512.0;

    final primaryPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final accentPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final pupilPaint = Paint()
      ..color = pupilColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.save();
    canvas.scale(scale, scale);

    // 1. Top-Left Architectural 'F' Viewfinder Caliper
    final fBracketPath = Path()
      ..moveTo(88, 152)
      ..cubicTo(88, 116.65, 116.65, 88, 152, 88)
      ..lineTo(398, 88)
      ..cubicTo(412.36, 88, 424, 99.64, 424, 114)
      ..cubicTo(424, 128.36, 412.36, 140, 398, 140)
      ..lineTo(156, 140)
      ..cubicTo(147.16, 140, 140, 147.16, 140, 156)
      ..lineTo(140, 398)
      ..cubicTo(140, 412.36, 128.36, 424, 114, 424)
      ..cubicTo(99.64, 424, 88, 412.36, 88, 398)
      ..close();
    canvas.drawPath(fBracketPath, primaryPaint);

    // 2. Middle F Crossbar / Viewfinder Horizon Shelf
    final fCrossbarPath = Path()
      ..moveTo(140, 236)
      ..lineTo(230, 236)
      ..cubicTo(244.36, 236, 256, 247.64, 256, 262)
      ..cubicTo(256, 276.36, 244.36, 288, 230, 288)
      ..lineTo(140, 288)
      ..close();
    canvas.drawPath(fCrossbarPath, primaryPaint);

    // 3. Bottom-Right Viewfinder Frame Corner
    final brBracketPath = Path()
      ..moveTo(424, 282)
      ..cubicTo(424, 267.64, 412.36, 256, 398, 256)
      ..cubicTo(383.64, 256, 372, 267.64, 372, 282)
      ..lineTo(372, 356)
      ..cubicTo(372, 364.84, 364.84, 372, 356, 372)
      ..lineTo(282, 372)
      ..cubicTo(267.64, 372, 256, 383.64, 256, 398)
      ..cubicTo(256, 412.36, 267.64, 424, 282, 424)
      ..lineTo(360, 424)
      ..cubicTo(395.35, 424, 424, 395.35, 424, 360)
      ..close();
    canvas.drawPath(brBracketPath, primaryPaint);

    // 4. Intelligent Lens Core & Coaching Reticle (Rule of Thirds Power Point)
    const lensCenter = Offset(316, 198);
    const lensRadius = 38.0;
    const pupilRadius = 16.0;

    if (isMonochrome && pupilColor == Colors.transparent) {
      // For pure monochrome stencils, draw the outer ring with the pupil as negative space
      final ringPath = Path()
        ..addOval(Rect.fromCircle(center: lensCenter, radius: lensRadius))
        ..addOval(Rect.fromCircle(center: lensCenter, radius: pupilRadius))
        ..fillType = PathFillType.evenOdd;
      canvas.drawPath(ringPath, primaryPaint);
    } else {
      // Primary dual-tone: outer lens blue + inner pupil
      canvas.drawCircle(lensCenter, lensRadius, accentPaint);
      if (pupilColor != Colors.transparent) {
        canvas.drawCircle(lensCenter, pupilRadius, pupilPaint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant FrameIQLogoPainter oldDelegate) {
    return oldDelegate.primaryColor != primaryColor ||
        oldDelegate.accentColor != accentColor ||
        oldDelegate.pupilColor != pupilColor ||
        oldDelegate.isMonochrome != isMonochrome;
  }
}
