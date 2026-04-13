import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_version_2/core/theme/app_theme.dart';
import 'package:portfolio_version_2/core/theme/const_colors.dart';
import 'package:portfolio_version_2/core/theme/const_sizes.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_motion_inherited.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/paint/book_chapter_wave_clipper.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/paint/book_paper_fiber_painter.dart';

/// Open-book spread: yellow chapter panel + paper panel (painted waves & grain).
class BookSpreadPage extends StatelessWidget {
  final List<String> chapterLines;
  final String chapterNumber;
  final Widget paperChild;
  final Color? colorsPager;
  final EdgeInsets? paddingPaper;

  const BookSpreadPage({
    super.key,
    required this.chapterLines,
    required this.chapterNumber,
    required this.paperChild,
    this.colorsPager,
    this.paddingPaper,
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
        final Widget paper = _PaperPanel(
          colorsPager: colorsPager,
          child: paperChild,
        );
        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 42,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: ConstSizes.s100,
                    bottom: ConstSizes.s100,
                    left: ConstSizes.s100,
                  ),
                  child: chapter,
                ),
              ),
              Expanded(
                flex: 58,
                child: Padding(
                  padding:
                      paddingPaper ??
                      EdgeInsets.only(
                        top: ConstSizes.s100,
                        bottom: ConstSizes.s100,
                        right: ConstSizes.s100,
                      ),
                  child: paper,
                ),
              ),
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
      padding: const EdgeInsets.fromLTRB(
        ConstSizes.s20,
        ConstSizes.s28,
        ConstSizes.s20,
        ConstSizes.s20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...lines
              .where((String line) => line.trim().isNotEmpty)
              .map(
                (String line) => Padding(
                  padding: const EdgeInsets.only(bottom: ConstSizes.s4),
                  child: Text(
                    line,
                    style: AppTheme.archivoBlack(
                      fontSize: ConstSizes.fontS28,
                      color: ConstColors.black,
                      height: 0.95,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                ),
              ),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: ConstSizes.s6,
                top: ConstSizes.s8,
                child: Text(
                  number,
                  style: AppTheme.archivoBlack(
                    fontSize: ConstSizes.fontS120,
                    color: ConstColors.black.withValues(alpha: 0.12),
                  ),
                ),
              ),
              Text(
                number,
                style: AppTheme.archivoBlack(
                  fontSize: ConstSizes.fontS120,
                  color: ConstColors.white,
                ),
              ),
            ],
          ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.8, 0.8)),
        ],
      ),
    );
    if (motion == null) {
      return ColoredBox(color: ConstColors.yellow, child: body);
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
              const ColoredBox(color: ConstColors.yellow),

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
  final Color? colorsPager;

  const _PaperPanel({required this.child, this.colorsPager});

  @override
  Widget build(BuildContext context) {
    final Animation<double>? motion = BookMotionInherited.maybeOf(context);
    final BorderRadius radius = BorderRadius.circular(ConstSizes.s24);
    return Container(
      color: ConstColors.black,
      padding: const EdgeInsets.fromLTRB(
        ConstSizes.s12,
        ConstSizes.s16,
        ConstSizes.s12,
        ConstSizes.s16,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.38),
              blurRadius: ConstSizes.s22,
              offset: const Offset(ConstSizes.s6, ConstSizes.s12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: motion == null
              ? ColoredBox(
                  color: colorsPager ?? ConstColors.paper,
                  child: child,
                )
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(color: colorsPager ?? ConstColors.paper),
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
