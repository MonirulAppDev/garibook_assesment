import 'dart:math' as math;

import 'package:flutter/material.dart';

class CarMarker extends StatelessWidget {
  const CarMarker({
    required this.bearingDegrees,
    required this.color,
    super.key,
  });

  final double bearingDegrees;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: bearingDegrees * math.pi / 180,
      child: CustomPaint(painter: _CarPainter(color)),
    );
  }
}

class _CarPainter extends CustomPainter {
  _CarPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width * 0.5;
    final h = size.height * 0.9;
    final body = RRect.fromRectAndRadius(
      Rect.fromCenter(center: size.center(Offset.zero), width: w, height: h),
      Radius.circular(w * 0.35),
    );

    canvas
      ..drawShadow(Path()..addRRect(body), Colors.black, 3, false)
      ..drawRRect(body, Paint()..color = color)
      ..drawRRect(
        body,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );

    final glass = Paint()..color = Colors.white.withValues(alpha: 0.85);
    final top = body.top;
    canvas
      ..drawRRect(
        RRect.fromLTRBR(
          body.left + w * 0.15,
          top + h * 0.18,
          body.right - w * 0.15,
          top + h * 0.38,
          const Radius.circular(3),
        ),
        glass,
      )
      ..drawRRect(
        RRect.fromLTRBR(
          body.left + w * 0.2,
          top + h * 0.72,
          body.right - w * 0.2,
          top + h * 0.85,
          const Radius.circular(2),
        ),
        glass,
      );
  }

  @override
  bool shouldRepaint(_CarPainter oldDelegate) => oldDelegate.color != color;
}
