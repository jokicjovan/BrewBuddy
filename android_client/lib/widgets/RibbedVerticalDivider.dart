import 'package:flutter/material.dart';

class RibbedVerticalDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double dashLength;
  final double gapLength;

  const RibbedVerticalDivider({
    super.key,
    required this.color,
    this.thickness = 1.2,
    this.dashLength = 6.0,
    this.gapLength = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(1, double.infinity),
      painter: _RibbedVerticalDividerPainter(
        color: color,
        thickness: thickness,
        dashLength: dashLength,
        gapLength: gapLength,
      ),
    );
  }
}

class _RibbedVerticalDividerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double dashLength;
  final double gapLength;

  _RibbedVerticalDividerPainter({
    required this.color,
    required this.thickness,
    required this.dashLength,
    required this.gapLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashLength),
        paint,
      );
      startY += dashLength + gapLength;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}