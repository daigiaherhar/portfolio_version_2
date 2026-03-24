import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/theme/book_palette.dart';

/// Subtle vertical grain and soft smudges so the paper feels tactile.
class BookPaperFiberPainter extends CustomPainter {
  BookPaperFiberPainter({required this.phase, this.seed = 7});

  final double phase;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final math.Random random = math.Random(seed);
    final double t = phase * math.pi * 2;
    for (int i = 0; i < 48; i++) {
      final double x = random.nextDouble() * size.width;
      final double w = 0.4 + random.nextDouble() * 0.9;
      final double shift = math.sin(t + x * 0.02) * 2;
      final Paint paint = Paint()
        ..color = BookPalette.black.withValues(
          alpha: 0.018 + random.nextDouble() * 0.028,
        )
        ..strokeWidth = w
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true;
      canvas.drawLine(
        Offset(x + shift, 0),
        Offset(x + shift * 1.2 + random.nextDouble() * 3, size.height),
        paint,
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
            BookPalette.yellow.withValues(alpha: 0.045),
            BookPalette.yellow.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );
  }

  @override
  bool shouldRepaint(covariant BookPaperFiberPainter oldDelegate) {
    return oldDelegate.phase != phase;
  }
}
