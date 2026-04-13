import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Wavy edge on chapter panel (spine / fold side) for a softer spread.
class BookChapterWaveClipper extends CustomClipper<Path> {
  BookChapterWaveClipper({required this.phase, required this.edge});

  final double phase;
  final BookWaveEdge edge;

  static const double _amp = 12;
  static const double _waves = 3.4;

  @override
  Path getClip(Size size) {
    final double ph = phase * math.pi * 2;
    return switch (edge) {
      BookWaveEdge.right => _pathRightWave(size, ph),
      BookWaveEdge.bottom => _pathBottomWave(size, ph),
    };
  }

  Path _pathRightWave(Size size, double ph) {
    final Path path = Path();
    path.moveTo(0, 0);
    const int steps = 36;
    for (int i = 0; i <= steps; i++) {
      final double y = size.height * (i / steps);
      final double x =
          size.width +
          _amp * math.sin((y / size.height) * _waves * math.pi * 2 + ph);
      path.lineTo(x, y);
    }
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  Path _pathBottomWave(Size size, double ph) {
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    const int steps = 36;
    for (int i = steps; i >= 0; i--) {
      final double x = size.width * (i / steps);
      final double y =
          size.height +
          _amp * math.sin((x / size.width) * _waves * math.pi * 2 + ph);
      path.lineTo(x, y);
    }
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant BookChapterWaveClipper oldClipper) {
    return oldClipper.phase != phase || oldClipper.edge != edge;
  }
}

enum BookWaveEdge { right, bottom }
