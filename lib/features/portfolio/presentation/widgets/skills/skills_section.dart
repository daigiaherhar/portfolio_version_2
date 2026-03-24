import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_version_2/core/animations/portfolio_entrance.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/skill.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/shared/section_header.dart';

class SkillsSection extends StatelessWidget {
  final List<Skill> skills;

  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Skills',
          subtitle: 'What I use to design and ship products.',
        ),
        ...skills.asMap().entries.map(
          (MapEntry<int, Skill> entry) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.value.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    Text(
                      '${entry.value.proficiencyPercent}%',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: entry.value.proficiencyPercent / 100,
                    backgroundColor:
                        scheme.primaryContainer.withValues(alpha: 0.35),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      scheme.primary,
                    ),
                  ),
                ),
              ],
            ).portfolioItemEntrance(entry.key, baseMs: 80),
          ),
        ),
      ],
    );
  }
}
