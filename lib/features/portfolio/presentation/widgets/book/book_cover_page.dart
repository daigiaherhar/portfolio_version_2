import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_version_2/core/theme/app_theme.dart';
import 'package:portfolio_version_2/core/theme/book_palette.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_hex_badge.dart';

class BookCoverPage extends StatelessWidget {
  final PortfolioProfile profile;

  const BookCoverPage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool narrow = constraints.maxWidth < 520;
        final double titleSize = narrow ? 38 : 56;
        final double nameSize = narrow ? 11 : 12;
        return Container(
          color: BookPalette.black,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: narrow ? 20 : 36,
                vertical: 20,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Text(
                      profile.fullName,
                      style: AppTheme.archivoBlack(
                        fontSize: nameSize,
                        color: BookPalette.yellow,
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.2),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: const BookHexBadge(size: 32).animate().fadeIn(delay: 100.ms).scale(),
                  ),
                  Positioned(
                    left: 0,
                    top: 72,
                    bottom: 120,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          profile.headline.toLowerCase(),
                          style: TextStyle(
                            color: BookPalette.white.withValues(alpha: 0.85),
                            fontSize: narrow ? 9 : 10,
                            letterSpacing: 1.4,
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                  Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: 'PORTFOLIO'
                            .split('')
                            .asMap()
                            .entries
                            .map(
                              (entry) =>
                                  _StackedLetter(char: entry.value, fontSize: titleSize)
                                  .animate()
                                  .fadeIn(delay: (400 + entry.key * 50).ms)
                                  .slideY(begin: 0.1),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Selected\nWorks',
                          style: AppTheme.archivoBlack(
                            fontSize: narrow ? 14 : 18,
                            color: BookPalette.yellow,
                            height: 1.05,
                          ),
                        ).animate().fadeIn(delay: 800.ms).slideX(begin: -0.2),
                        const SizedBox(width: 12),
                        RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            '2026',
                            style: TextStyle(
                              fontSize: narrow ? 42 : 64,
                              fontWeight: FontWeight.w900,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = BookPalette.yellow,
                            ),
                          ),
                        ).animate().fadeIn(delay: 900.ms).scale(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StackedLetter extends StatelessWidget {
  final String char;
  final double fontSize;

  const _StackedLetter({required this.char, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    if (char == ' ') {
      return SizedBox(height: fontSize * 0.2);
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 4,
            top: 5,
            child: Text(
              char,
              style: AppTheme.archivoBlack(
                fontSize: fontSize,
                color: BookPalette.black,
              ),
            ),
          ),
          Text(
            char,
            style: AppTheme.archivoBlack(
              fontSize: fontSize,
              color: BookPalette.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
