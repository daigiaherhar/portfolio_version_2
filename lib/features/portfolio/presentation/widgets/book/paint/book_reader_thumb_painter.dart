import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/theme/book_palette.dart';

/// Soft capsule / dot for page indicators (painted, not boxes).
class BookReaderThumbPainter extends CustomPainter {
  BookReaderThumbPainter({required this.active, required this.phase});

  final bool active;
  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    if (!active) {
      canvas.drawCircle(
        Offset(cx, cy),
        3.6,
        Paint()
          ..color = BookPalette.yellow.withValues(alpha: 0.28)
          ..isAntiAlias = true,
      );
      return;
    }
    final double wobble = math.sin(phase * math.pi * 2) * 1.5;
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, cy),
        width: 22 + wobble,
        height: 8,
      ),
      const Radius.circular(10),
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = BookPalette.yellow.withValues(alpha: 0.92)
        ..isAntiAlias = true,
    );
    canvas.drawRRect(
      rrect.deflate(0.5),
      Paint()
        ..color = BookPalette.black.withValues(alpha: 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..isAntiAlias = true,
    );
  }

  @override
  bool shouldRepaint(covariant BookReaderThumbPainter oldDelegate) {
    return oldDelegate.active != active || oldDelegate.phase != phase;
  }
}
