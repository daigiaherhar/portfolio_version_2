import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_version_2/core/animations/portfolio_entrance.dart';
import 'package:portfolio_version_2/core/utils/url_launcher_helper.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/project.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/shared/section_header.dart';

class ProjectsSection extends StatelessWidget {
  final List<Project> projects;
  final bool forceSingleColumn;

  const ProjectsSection({
    super.key,
    required this.projects,
    this.forceSingleColumn = false,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Projects',
          subtitle: 'A few things I’ve enjoyed building.',
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool useGrid =
                !forceSingleColumn && constraints.maxWidth > 900;
            if (!useGrid) {
              return Column(
                children: projects.asMap().entries.map(
                  (MapEntry<int, Project> entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _ProjectTile(
                        project: entry.value,
                      ).portfolioItemEntrance(entry.key, baseMs: 90),
                    );
                  },
                ).toList(),
              );
            }
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: projects.asMap().entries.map(
                (MapEntry<int, Project> entry) {
                  return SizedBox(
                    width: (constraints.maxWidth - 16) / 2,
                    child: _ProjectTile(
                      project: entry.value,
                    ).portfolioItemEntrance(entry.key, baseMs: 90),
                  );
                },
              ).toList(),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          'Edit copy in portfolio_local_data_source.dart',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.65),
          ),
        ),
      ],
    );
  }
}

class _ProjectTile extends StatelessWidget {
  final Project project;

  const _ProjectTile({required this.project});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.name,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              project.description,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                height: 1.55,
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.techTags
                  .map(
                    (String tag) => Chip(label: Text(tag)),
                  )
                  .toList(),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                if (project.repositoryUrl != null)
                  FilledButton.tonalIcon(
                    onPressed: () =>
                        executeOpenUrl(project.repositoryUrl!.trim()),
                    icon: const Icon(Icons.code_rounded, size: 18),
                    label: const Text('Code'),
                  ),
                if (project.liveUrl != null)
                  FilledButton.icon(
                    onPressed: () => executeOpenUrl(project.liveUrl!.trim()),
                    icon: const Icon(Icons.open_in_new_rounded, size: 18),
                    label: const Text('Live demo'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
