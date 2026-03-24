import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension PortfolioEntrance on Widget {
  /// Staggered fade + vertical slide for major page blocks (hero, sections).
  Widget portfolioBlockEntrance(int index, {int stepMs = 72}) {
    final Duration delay = (stepMs * index).ms;
    return animate()
        .fadeIn(
          duration: 440.ms,
          delay: delay,
          curve: Curves.easeOutCubic,
        )
        .slideY(
          begin: 0.1,
          end: 0,
          duration: 520.ms,
          delay: delay,
          curve: Curves.easeOutCubic,
        );
  }

  /// Stagger inside a section (cards, rows, chips).
  Widget portfolioItemEntrance(
    int index, {
    int baseMs = 0,
    int stepMs = 48,
  }) {
    final Duration delay = (baseMs + stepMs * index).ms;
    return animate()
        .fadeIn(
          duration: 380.ms,
          delay: delay,
          curve: Curves.easeOutCubic,
        )
        .slideX(
          begin: 0.04,
          end: 0,
          duration: 420.ms,
          delay: delay,
          curve: Curves.easeOutCubic,
        );
  }

  /// Hero accent: scale + fade for a stronger focal point.
  Widget portfolioHeroAccentEntrance() {
    return animate()
        .fadeIn(duration: 520.ms, curve: Curves.easeOutCubic)
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          duration: 680.ms,
          curve: Curves.easeOutCubic,
        );
  }

  /// Hero copy: quick follow-up after accent.
  Widget portfolioHeroCopyEntrance() {
    return animate()
        .fadeIn(delay: 100.ms, duration: 480.ms, curve: Curves.easeOutCubic)
        .slideY(
          begin: 0.08,
          end: 0,
          delay: 100.ms,
          duration: 560.ms,
          curve: Curves.easeOutCubic,
        );
  }

  /// Desktop hero: text from leading, visual from trailing.
  Widget portfolioHeroTextEntrance() {
    return animate()
        .fadeIn(duration: 500.ms, curve: Curves.easeOutCubic)
        .slideX(
          begin: -0.05,
          end: 0,
          duration: 560.ms,
          curve: Curves.easeOutCubic,
        );
  }

  Widget portfolioHeroAsideEntrance() {
    return animate()
        .fadeIn(delay: 140.ms, duration: 520.ms, curve: Curves.easeOutCubic)
        .slideX(
          begin: 0.06,
          end: 0,
          delay: 140.ms,
          duration: 620.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
