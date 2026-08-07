import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';

class GridOverlay extends ConsumerWidget {
  const GridOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridType = ref.watch(gridSettingsProvider);

    if (gridType == GridType.none) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: GridPainter(gridType: gridType),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final GridType gridType;

  GridPainter({required this.gridType});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.35)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    if (gridType == GridType.ruleOfThirds) {
      // Draw Rule of Thirds (3x3 grid)
      final double widthThird = size.width / 3;
      final double heightThird = size.height / 3;

      // Vertical lines
      canvas.drawLine(Offset(widthThird, 0), Offset(widthThird, size.height), paint);
      canvas.drawLine(Offset(widthThird * 2, 0), Offset(widthThird * 2, size.height), paint);

      // Horizontal lines
      canvas.drawLine(Offset(0, heightThird), Offset(size.width, heightThird), paint);
      canvas.drawLine(Offset(0, heightThird * 2), Offset(size.width, heightThird * 2), paint);

      // Intersection accent dots
      final dotPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.7)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(widthThird, heightThird), 3, dotPaint);
      canvas.drawCircle(Offset(widthThird * 2, heightThird), 3, dotPaint);
      canvas.drawCircle(Offset(widthThird, heightThird * 2), 3, dotPaint);
      canvas.drawCircle(Offset(widthThird * 2, heightThird * 2), 3, dotPaint);
    } else if (gridType == GridType.goldenRatio) {
      // Golden Ratio (phi ~ 0.618)
      const double phi = 0.61803398875;
      final double x1 = size.width * (1 - phi);
      final double x2 = size.width * phi;
      final double y1 = size.height * (1 - phi);
      final double y2 = size.height * phi;

      canvas.drawLine(Offset(x1, 0), Offset(x1, size.height), paint);
      canvas.drawLine(Offset(x2, 0), Offset(x2, size.height), paint);
      canvas.drawLine(Offset(0, y1), Offset(size.width, y1), paint);
      canvas.drawLine(Offset(0, y2), Offset(size.width, y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    return oldDelegate.gridType != gridType;
  }
}
