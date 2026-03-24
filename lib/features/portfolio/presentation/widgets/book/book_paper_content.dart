import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/scroll/book_paper_scroll_physics.dart';
import 'package:portfolio_version_2/core/theme/app_theme.dart';
import 'package:portfolio_version_2/core/theme/book_palette.dart';
import 'package:portfolio_version_2/core/utils/url_launcher_helper.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/experience.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/project.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/skill.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/social_link.dart';

class BookPaperContent {
  BookPaperContent._();

  static Widget about(BuildContext context, PortfolioProfile profile) {
    return _PaperScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile.headline,
            style: AppTheme.archivoBlack(
              fontSize: 22,
              color: BookPalette.black,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            profile.summary,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: BookPalette.black.withValues(alpha: 0.88),
                  height: 1.55,
                ),
          ),
        ],
      ),
    );
  }

  static Widget skills(BuildContext context, List<Skill> skills) {
    return _PaperScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: skills.map((Skill skill) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        skill.name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: BookPalette.black,
                            ),
                      ),
                    ),
                    Text(
                      '${skill.proficiencyPercent}%',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: BookPalette.black.withValues(alpha: 0.55),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: skill.proficiencyPercent / 100,
                    minHeight: 6,
                    backgroundColor: BookPalette.black.withValues(alpha: 0.08),
                    color: BookPalette.yellow,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  static Widget projects(BuildContext context, List<Project> projects) {
    return _PaperScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: projects.map((Project project) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.name,
                  style: AppTheme.archivoBlack(
                    fontSize: 18,
                    color: BookPalette.black,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: BookPalette.black.withValues(alpha: 0.85),
                        height: 1.5,
                      ),
                ),
                if (project.techTags.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: project.techTags.map((String tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: BookPalette.black.withValues(alpha: 0.2),
                          ),
                          color: BookPalette.white,
                        ),
                        child: Text(
                          tag,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: BookPalette.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                if (project.repositoryUrl != null ||
                    project.liveUrl != null) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (project.repositoryUrl != null)
                        TextButton(
                          onPressed: () => executeOpenUrl(
                            project.repositoryUrl!.trim(),
                          ),
                          child: const Text('Repository'),
                        ),
                      if (project.liveUrl != null)
                        TextButton(
                          onPressed: () =>
                              executeOpenUrl(project.liveUrl!.trim()),
                          child: const Text('Live'),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  static Widget experience(
    BuildContext context,
    List<Experience> experiences,
  ) {
    return _PaperScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: experiences.map((Experience item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.company,
                  style: AppTheme.archivoBlack(
                    fontSize: 17,
                    color: BookPalette.black,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.role} · ${item.period}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: BookPalette.black.withValues(alpha: 0.55),
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.summary,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: BookPalette.black.withValues(alpha: 0.85),
                        height: 1.5,
                      ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  static Widget contact(BuildContext context, List<SocialLink> links) {
    return _PaperScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reach out for collaboration or a quick hello.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: BookPalette.black.withValues(alpha: 0.88),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: links.map((SocialLink link) {
              return FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: BookPalette.black,
                  foregroundColor: BookPalette.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
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

class _PaperScroll extends StatelessWidget {
  final Widget child;

  const _PaperScroll({required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: BookPalette.black,
              displayColor: BookPalette.black,
            ),
      ),
      child: SingleChildScrollView(
        primary: false,
        physics: const BookPaperScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
        child: child,
      ),
    );
  }
}
