import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/theme/const_sizes.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/project.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_paper_scroll.dart';
import 'package:portfolio_version_2/core/theme/app_theme.dart';
import 'package:portfolio_version_2/core/theme/const_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class BookPaperProjects extends StatelessWidget {
  final List<Project> projects;

  const BookPaperProjects({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return const BookPaperScroll(child: SizedBox.shrink());
    }
    return BookPaperScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: projects.map((Project project) => _ProjectCard(project: project)).toList(),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ConstSizes.s24),
      padding: const EdgeInsets.all(ConstSizes.s20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(ConstSizes.s16),
        border: Border.all(
          color: ConstColors.black.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  project.name,
                  style: AppTheme.archivoBlack(
                    fontSize: ConstSizes.fontS18,
                    color: ConstColors.black,
                  ),
                ),
              ),
              if (project.liveUrl != null || project.repositoryUrl != null)
                Row(
                  children: [
                    if (project.repositoryUrl != null)
                      IconButton(
                        icon: const Icon(Icons.code_rounded, size: 20),
                        onPressed: () => launchUrl(Uri.parse(project.repositoryUrl!)),
                        tooltip: 'Source Code',
                      ),
                    if (project.liveUrl != null)
                      IconButton(
                        icon: const Icon(Icons.open_in_new_rounded, size: 20),
                        onPressed: () => launchUrl(Uri.parse(project.liveUrl!)),
                        tooltip: 'Live Demo',
                      ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: ConstSizes.s8),
          Text(
            project.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ConstColors.black.withValues(alpha: 0.75),
                  height: 1.5,
                ),
          ),
          if (project.techTags.isNotEmpty) ...[
            const SizedBox(height: ConstSizes.s12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.techTags.map((String tech) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: ConstColors.yellow.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tech,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: ConstColors.black,
                  ),
                ),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
