import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_version_2/core/theme/app_theme.dart';
import 'package:portfolio_version_2/core/theme/const_colors.dart';
import 'package:portfolio_version_2/core/theme/const_sizes.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/experience.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_paper_scroll.dart';

class BookPaperExperience extends StatelessWidget {
  final List<Experience> experiences;

  const BookPaperExperience({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    return BookPaperScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: experiences.asMap().entries.map((entry) {
          final int index = entry.key;
          final Experience item = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: ConstSizes.s24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.company,
                  style: AppTheme.archivoBlack(
                    fontSize: ConstSizes.fontS18,
                    color: ConstColors.black,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: ConstSizes.s4),
                Text(
                  '${item.role} · ${item.period}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: ConstColors.black.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: ConstSizes.s12),
                Text(
                  item.summary,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ConstColors.black.withValues(alpha: 0.8),
                        height: 1.6,
                      ),
                ),
              ],
            ).animate().fadeIn(delay: (index * 150).ms).slideY(begin: 0.1),
          );
        }).toList(),
      ),
    );
  }
}
