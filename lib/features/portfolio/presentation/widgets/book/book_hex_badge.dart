import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/theme/book_palette.dart';

class BookHexBadge extends StatelessWidget {
  final double size;

  const BookHexBadge({super.key, this.size = 28});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HexPainter(color: BookPalette.yellow),
    );
  }
}

class _HexPainter extends CustomPainter {
  final Color color;

  _HexPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double r = math.min(size.width, size.height) / 2;
    final Path path = Path();
    for (int i = 0; i < 6; i++) {
      final double a = (i * 60 - 90) * math.pi / 180;
      final double x = cx + r * math.cos(a);
      final double y = cy + r * math.sin(a);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
