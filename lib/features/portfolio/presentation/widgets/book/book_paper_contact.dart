import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/theme/const_colors.dart';
import 'package:portfolio_version_2/core/theme/const_sizes.dart';
import 'package:portfolio_version_2/core/utils/url_launcher_helper.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/social_link.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_paper_scroll.dart';

class BookPaperContact extends StatelessWidget {
  final List<SocialLink> links;

  const BookPaperContact({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    return BookPaperScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reach out for collaboration or a quick hello.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ConstColors.black.withValues(alpha: 0.88),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: ConstSizes.s20),
          Wrap(
            spacing: ConstSizes.s10,
            runSpacing: ConstSizes.s10,
            children: links.map((SocialLink link) {
              return FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: ConstColors.black,
                  foregroundColor: ConstColors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ConstSizes.s4),
                  ),
                ),
                onPressed: () => executeOpenUrl(link.url.trim()),
                child: Text(link.label),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
