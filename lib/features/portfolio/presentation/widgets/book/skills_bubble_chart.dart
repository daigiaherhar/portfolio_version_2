import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_version_2/core/theme/const_colors.dart';
import 'package:portfolio_version_2/core/theme/const_sizes.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/skill.dart';

/// Muted palette (sage, terracotta, dusty blue, plum, ochre, …) for bubble fill.
const List<Color> _kBubbleFillColors = <Color>[
  Color(0xFF8B9A7A),
  Color(0xFFC17F59),
  Color(0xFF7A8FA3),
  Color(0xFF8B6B7A),
  Color(0xFFBFA76A),
  Color(0xFF6B8B7F),
  Color(0xFF9A8BA8),
  Color(0xFF7A9B8C),
  Color(0xFFB8927A),
  Color(0xFF8A7A6B),
  Color(0xFF6F7A8F),
  Color(0xFFA08C6E),
];

class _PackedCircle {
  double x;
  double y;
  final double r;
  final int skillIndex;

  _PackedCircle({
    required this.x,
    required this.y,
    required this.r,
    required this.skillIndex,
  });
}

/// Circle packing + force relaxation; scales to [maxWidth].
class SkillsBubbleLayout {
  final List<Skill> skills;
  final List<Offset> centers;
  final List<double> radii;
  final List<Color> colors;
  final double width;
  final double height;

  const SkillsBubbleLayout({
    required this.skills,
    required this.centers,
    required this.radii,
    required this.colors,
    required this.width,
    required this.height,
  });

  static double _radiusForSkill(Skill skill, double minR, double maxR) {
    final double t = (skill.proficiencyPercent.clamp(0, 100)) / 100.0;
    final double curved = math.pow(t, 0.62).toDouble();
    return minR + (maxR - minR) * curved;
  }

  static Color _bubbleColor(Skill skill, int index) {
    final Color? custom = skill.color;
    if (custom != null) {
      return custom;
    }
    return _kBubbleFillColors[index % _kBubbleFillColors.length];
  }

  static SkillsBubbleLayout compute({
    required List<Skill> skills,
    required double maxWidth,
    double minRadius = 22,
    double maxRadius = 52,
    double padding = 12,
    int iterations = 96,
  }) {
    if (skills.isEmpty || maxWidth <= 0) {
      return SkillsBubbleLayout(
        skills: skills,
        centers: const <Offset>[],
        radii: const <double>[],
        colors: const <Color>[],
        width: maxWidth,
        height: 0,
      );
    }
    if (skills.length == 1) {
      final double r = math.min(maxRadius, (maxWidth - 2 * padding) / 2);
      final Color c = _bubbleColor(skills[0], 0);
      return SkillsBubbleLayout(
        skills: skills,
        centers: <Offset>[Offset(maxWidth / 2, r + padding)],
        radii: <double>[r],
        colors: <Color>[c],
        width: maxWidth,
        height: 2 * r + 2 * padding,
      );
    }
    final List<double> radiiList = skills
        .map((Skill s) => _radiusForSkill(s, minRadius, maxRadius))
        .toList();
    final List<int> order = List<int>.generate(skills.length, (int i) => i);
    order.sort((int a, int b) => radiiList[b].compareTo(radiiList[a]));
    const double goldenAngle = 2.39996322972865332;
    final List<_PackedCircle> circles = <_PackedCircle>[];
    for (int k = 0; k < order.length; k++) {
      final int i = order[k];
      final double r = radiiList[i];
      final double t = (k + 1) * goldenAngle;
      final double spiralR = 4.2 * math.sqrt(k + 1);
      circles.add(
        _PackedCircle(
          x: math.cos(t) * spiralR,
          y: math.sin(t) * spiralR,
          r: r,
          skillIndex: i,
        ),
      );
    }
    for (int iter = 0; iter < iterations; iter++) {
      final double sep = 0.42 + 0.08 * (1 - iter / iterations);
      for (int a = 0; a < circles.length; a++) {
        for (int b = a + 1; b < circles.length; b++) {
          final _PackedCircle ca = circles[a];
          final _PackedCircle cb = circles[b];
          double dx = cb.x - ca.x;
          double dy = cb.y - ca.y;
          double dist = math.sqrt(dx * dx + dy * dy);
          final double minDist = ca.r + cb.r;
          if (dist < 1e-6) {
            dx = 0.02;
            dy = 0.01;
            dist = math.sqrt(dx * dx + dy * dy);
          }
          if (dist < minDist) {
            final double overlap = (minDist - dist) * sep;
            final double nx = dx / dist;
            final double ny = dy / dist;
            ca.x -= nx * overlap;
            ca.y -= ny * overlap;
            cb.x += nx * overlap;
            cb.y += ny * overlap;
          }
        }
      }
      final double pull = 0.04;
      for (final _PackedCircle c in circles) {
        c.x *= 1 - pull;
        c.y *= 1 - pull;
      }
    }
    double minX = double.infinity;
    double maxX = double.negativeInfinity;
    double minY = double.infinity;
    double maxY = double.negativeInfinity;
    for (final _PackedCircle c in circles) {
      minX = math.min(minX, c.x - c.r);
      maxX = math.max(maxX, c.x + c.r);
      minY = math.min(minY, c.y - c.r);
      maxY = math.max(maxY, c.y + c.r);
    }
    final double contentW = math.max(maxX - minX, 1e-6);
    final double contentH = math.max(maxY - minY, 1e-6);
    final double innerW = math.max(maxWidth - 2 * padding, 1e-6);
    final double scale = innerW / contentW;
    final double scaledH = contentH * scale;
    final List<Offset> outCenters = <Offset>[];
    final List<double> outRadii = <double>[];
    final List<Color> outColors = <Color>[];
    for (final _PackedCircle c in circles) {
      final double cx = (c.x - minX) * scale + padding;
      final double cy = (c.y - minY) * scale + padding;
      final double rr = c.r * scale;
      outCenters.add(Offset(cx, cy));
      outRadii.add(rr);
      outColors.add(_bubbleColor(skills[c.skillIndex], c.skillIndex));
    }
    final List<Offset> orderedCenters = List<Offset>.filled(
      skills.length,
      Offset.zero,
    );
    final List<double> orderedRadii = List<double>.filled(skills.length, 0);
    final List<Color> orderedColors = List<Color>.filled(
      skills.length,
      ConstColors.paper,
    );
    for (int k = 0; k < circles.length; k++) {
      final int si = circles[k].skillIndex;
      orderedCenters[si] = outCenters[k];
      orderedRadii[si] = outRadii[k];
      orderedColors[si] = outColors[k];
    }
    return SkillsBubbleLayout(
      skills: skills,
      centers: orderedCenters,
      radii: orderedRadii,
      colors: orderedColors,
      width: maxWidth,
      height: scaledH + 2 * padding,
    );
  }
}

/// Packed skill bubbles: each bubble is a [Container] with circular
/// [BoxDecoration] only (no [CustomPaint]).
class SkillsBubbleChart extends StatelessWidget {
  final List<Skill> skills;

  const SkillsBubbleChart({super.key, required this.skills});

  /// Keeps packing scale bounded on ultra-wide web layouts (avoids huge radii / clip loss).
  static const double _kCanvasMaxWidth = 520;

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty) {
      return const SizedBox.shrink();
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double parentW = constraints.maxWidth;
        if (!parentW.isFinite || parentW <= 0) {
          parentW = MediaQuery.sizeOf(context).width;
        }
        final double w = math.min(parentW, _kCanvasMaxWidth);
        final SkillsBubbleLayout layout = SkillsBubbleLayout.compute(
          skills: skills,
          maxWidth: w,
        );
        return Align(
          alignment: Alignment.topCenter,
          child: RepaintBoundary(
            child: SizedBox(
              width: w,
              height: layout.height,
              child: Stack(
                clipBehavior: Clip.none,
                children: List<Widget>.generate(skills.length, (int i) {
                  final Skill skill = skills[i];
                  final Offset c = layout.centers[i];
                  final double r = layout.radii[i];
                  final Color fill = layout.colors[i];
                  final double d = r * 2;
                  final double fontPrimary = (r * 0.30).clamp(
                    ConstSizes.fontS8,
                    ConstSizes.fontS14,
                  );
                  return Positioned(
                    left: c.dx - r,
                    top: c.dy - r,
                    child: Semantics(
                      label:
                          '${skill.name}, ${skill.proficiencyPercent} percent',
                      child: Container(
                        width: d,
                        height: d,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: fill,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: ConstColors.black.withValues(alpha: 0.12),
                              blurRadius: ConstSizes.s4,
                              offset: const Offset(0, ConstSizes.s2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(r * 0.14),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              skill.name,
                              textAlign: TextAlign.center,
                              maxLines: r >= 30 ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    fontSize: fontPrimary,
                                    fontWeight: FontWeight.w800,
                                    height: 1.05,
                                    color: ConstColors.black.withValues(
                                      alpha: 0.88,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ).animate(
                        onPlay: (controller) => controller.repeat(reverse: true),
                      ).scale(
                        begin: const Offset(1, 1),
                        end: Offset(1.03 + (math.sin(i) * 0.01), 1.03 + (math.sin(i) * 0.01)),
                        duration: (1500 + (i * 100)).ms,
                        curve: Curves.easeInOut,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
