import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/theme/app_theme.dart';
import 'package:portfolio_version_2/core/theme/book_palette.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_motion_inherited.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/paint/book_chapter_wave_clipper.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/paint/book_paper_fiber_painter.dart';

/// Open-book spread: yellow chapter panel + paper panel (painted waves & grain).
class BookSpreadPage extends StatelessWidget {
  final List<String> chapterLines;
  final String chapterNumber;
  final Widget paperChild;

  const BookSpreadPage({
    super.key,
    required this.chapterLines,
    required this.chapterNumber,
    required this.paperChild,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool wide = constraints.maxWidth >= 640;
        final BookWaveEdge waveEdge = wide
            ? BookWaveEdge.right
            : BookWaveEdge.bottom;
        final Widget chapter = _ChapterPanel(
          lines: chapterLines,
          number: chapterNumber,
          waveEdge: waveEdge,
        );
        final Widget paper = _PaperPanel(child: paperChild);
        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 42, child: chapter),
              Expanded(flex: 58, child: paper),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 2, child: chapter),
            Expanded(flex: 5, child: paper),
          ],
        );
      },
    );
  }
}

class _ChapterPanel extends StatelessWidget {
  final List<String> lines;
  final String number;
  final BookWaveEdge waveEdge;

  const _ChapterPanel({
    required this.lines,
    required this.number,
    required this.waveEdge,
  });

  @override
  Widget build(BuildContext context) {
    final Animation<double>? motion = BookMotionInherited.maybeOf(context);
    final Widget body = Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...lines
              .where((String line) => line.trim().isNotEmpty)
              .map(
                (String line) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    line,
                    style: AppTheme.archivoBlack(
                      fontSize: 28,
                      color: BookPalette.black,
                      height: 0.95,
                    ),
                  ),
                ),
              ),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 6,
                top: 8,
                child: Text(
                  number,
                  style: AppTheme.archivoBlack(
                    fontSize: 120,
                    color: BookPalette.black.withValues(alpha: 0.12),
                  ),
                ),
              ),
              Text(
                number,
                style: AppTheme.archivoBlack(
                  fontSize: 120,
                  color: BookPalette.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    if (motion == null) {
      return ColoredBox(color: BookPalette.yellow, child: body);
    }
    return ListenableBuilder(
      listenable: motion,
      builder: (BuildContext context, Widget? child) {
        final double ph = motion.value;
        return ClipPath(
          clipper: BookChapterWaveClipper(phase: ph, edge: waveEdge),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const ColoredBox(color: BookPalette.yellow),
              // Positioned.fill(
              //   child: CustomPaint(
              //     painter: BookChapterAccentPainter(phase: ph),
              //   ),
              // ),
              Positioned.fill(child: child!),
            ],
          ),
        );
      },
      child: body,
    );
  }
}

class _PaperPanel extends StatelessWidget {
  final Widget child;

  const _PaperPanel({required this.child});

  @override
  Widget build(BuildContext context) {
    final Animation<double>? motion = BookMotionInherited.maybeOf(context);
    final BorderRadius radius = BorderRadius.circular(24);
    return Container(
      color: BookPalette.black,
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.38),
              blurRadius: 22,
              offset: const Offset(6, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: motion == null
              ? ColoredBox(color: BookPalette.paper, child: child)
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    const ColoredBox(color: BookPalette.paper),
                    Positioned.fill(
                      child: IgnorePointer(
                        child: ListenableBuilder(
                          listenable: motion,
                          builder: (BuildContext context, Widget? _) {
                            return CustomPaint(
                              painter: BookPaperFiberPainter(
                                phase: motion.value,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    child,
                  ],
                ),
        ),
      ),
    );
  }
}
