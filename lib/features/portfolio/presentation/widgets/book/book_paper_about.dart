import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/theme/app_theme.dart';
import 'package:portfolio_version_2/core/theme/const_colors.dart';
import 'package:portfolio_version_2/core/theme/const_sizes.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_paper_scroll.dart';

class BookPaperAbout extends StatelessWidget {
  final PortfolioProfile profile;

  const BookPaperAbout({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return BookPaperScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: ConstColors.yellow,
                  shape: BoxShape.circle,
                  border: Border.all(color: ConstColors.black, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: ConstColors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.person_rounded, size: 48, color: ConstColors.black),
                ),
              ),
              const SizedBox(width: ConstSizes.s20),
              Expanded(
                child: Text(
                  profile.headline,
                  style: AppTheme.archivoBlack(
                    fontSize: ConstSizes.fontS24,
                    color: ConstColors.black,
                    height: 1.1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: ConstSizes.s32),
          Text(
            'About Me',
            style: AppTheme.archivoBlack(
              fontSize: ConstSizes.fontS14,
              color: ConstColors.black.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: ConstSizes.s8),
          Text(
            profile.summary,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ConstColors.black.withValues(alpha: 0.88),
                  height: 1.6,
                  letterSpacing: 0.2,
                ),
          ),
        ],
      ),
    );
  }
}
