import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/animations/portfolio_entrance.dart';
import 'package:portfolio_version_2/core/extensions/context_device_extensions.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/contact/contact_section.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/experience/experience_section.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/hero/hero_section.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/projects/projects_section.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/shared/portfolio_footer_note.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/skills/skills_section.dart';

/// Single scroll body for portfolio content. Layout shell differs by [kIsWeb];
/// section list is defined once so data from Bloc is consumed in one place only.
class PortfolioProfileBody extends StatelessWidget {
  final PortfolioProfile profile;

  const PortfolioProfileBody({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final bool isWeb = kIsWeb;
    final List<Widget> sections = _buildSections(context, isWeb);
    if (isWeb) {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 1040,
                  minHeight: context.deviceHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: sections,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    final double horizontalPadding = 20;
    return CustomScrollView(
      slivers: [
        SliverSafeArea(
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              width: context.deviceWidth,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  16,
                  horizontalPadding,
                  24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: sections,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSections(BuildContext context, bool isWeb) {
    final double heroAccentHeight = context.deviceHeight * 0.34;
    final Widget hero = isWeb
        ? HeroSection(profile: profile)
        : HeroSection(
            profile: profile,
            useCompactDeviceLayout: true,
            accentTargetHeight: heroAccentHeight.clamp(140, 320),
          );
    final double gapAfterHero = isWeb ? 56 : context.deviceHeight * 0.04;
    final double sectionGap = isWeb ? 48 : 40;
    final double gapBeforeFooter = isWeb ? 40 : 32;
    return [
      hero,
      SizedBox(height: gapAfterHero),
      SkillsSection(skills: profile.skills).portfolioBlockEntrance(0),
      SizedBox(height: sectionGap),
      ProjectsSection(
        projects: profile.projects,
        forceSingleColumn: !isWeb,
      ).portfolioBlockEntrance(1),
      SizedBox(height: sectionGap),
      ExperienceSection(experiences: profile.experiences)
          .portfolioBlockEntrance(2),
      SizedBox(height: sectionGap),
      ContactSection(links: profile.socialLinks).portfolioBlockEntrance(3),
      SizedBox(height: gapBeforeFooter),
      PortfolioFooterNote(isWebTarget: isWeb).portfolioBlockEntrance(4),
    ];
  }
}
