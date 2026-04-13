import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/theme/const_colors.dart';

/// Subtle vertical grain and soft smudges so the paper feels tactile.
class BookPaperFiberPainter extends CustomPainter {
  BookPaperFiberPainter({required this.phase, this.seed = 7});

  final double phase;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final math.Random random = math.Random(seed);
    final double t = phase * math.pi * 2;
    
    // Subtle background noise
    final Paint noisePaint = Paint()
      ..color = ConstColors.black.withValues(alpha: 0.015);
    for (int i = 0; i < 300; i++) {
      final double x = random.nextDouble() * size.width;
      final double y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 0.5, noisePaint);
    }

    // More organic fibers
    for (int i = 0; i < 80; i++) {
      final double x = random.nextDouble() * size.width;
      final double w = 0.3 + random.nextDouble() * 0.7;
      final double length = 20 + random.nextDouble() * 100;
      final double startY = random.nextDouble() * size.height;
      final double angle = (random.nextDouble() - 0.5) * 0.1;
      
      final Paint fiberPaint = Paint()
        ..color = ConstColors.black.withValues(
          alpha: 0.01 + random.nextDouble() * 0.02,
        )
        ..strokeWidth = w
        ..strokeCap = StrokeCap.round;
        
      canvas.drawLine(
        Offset(x, startY),
        Offset(x + math.sin(angle) * length, startY + math.cos(angle) * length),
        fiberPaint,
      );
    }

    final Path smudge = Path();
    smudge.addOval(
      Rect.fromCenter(
        center: Offset(
          size.width * 0.82 + math.cos(t * 0.7) * 12,
          size.height * 0.25 + math.sin(t) * 8,
        ),
        width: size.width * 0.45,
        height: size.height * 0.22,
      ),
    );
    canvas.drawPath(
      smudge,
      Paint()
        ..shader = RadialGradient(
          colors: [
            ConstColors.yellow.withValues(alpha: 0.03),
            ConstColors.yellow.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );
  }

  @override
  bool shouldRepaint(covariant BookPaperFiberPainter oldDelegate) {
    return oldDelegate.phase != phase;
  }
}
