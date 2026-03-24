import 'package:injectable/injectable.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/experience.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/project.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/skill.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/social_link.dart';

abstract class PortfolioLocalDataSource {
  Future<PortfolioProfile> getProfile();
}

@LazySingleton(as: PortfolioLocalDataSource)
class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  @override
  Future<PortfolioProfile> getProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 280));
    return const PortfolioProfile(
      fullName: 'Your Name',
      headline: 'Flutter · Clean Architecture · Web',
      summary:
          'I build reliable, well-structured applications with a focus on '
          'maintainable architecture and polished user experience. '
          'Replace this text in the data layer with your own story.',
      skills: [
        Skill(name: 'Flutter & Dart', proficiencyPercent: 95),
        Skill(name: 'Bloc / Riverpod', proficiencyPercent: 88),
        Skill(name: 'REST / GraphQL', proficiencyPercent: 82),
        Skill(name: 'CI / Testing', proficiencyPercent: 78),
      ],
      projects: [
        Project(
          name: 'Portfolio (this site)',
          description:
              'Single-page portfolio built with Flutter Web and Clean Architecture.',
          repositoryUrl: 'https://github.com',
          liveUrl: null,
          techTags: ['Flutter', 'Bloc', 'GetIt', 'Dartz'],
        ),
        Project(
          name: 'Sample API client',
          description:
              'Demonstrates repository pattern, error mapping, and offline-first reads.',
          repositoryUrl: 'https://github.com',
          liveUrl: 'https://example.com',
          techTags: ['Dart', 'Dio', 'Either'],
        ),
      ],
      experiences: [
        Experience(
          company: 'Company A',
          role: 'Mobile Engineer',
          period: '2022 — Present',
          summary:
              'Shipped production features with Bloc, automated tests, and CI pipelines.',
        ),
        Experience(
          company: 'Company B',
          role: 'Software Developer',
          period: '2019 — 2022',
          summary:
              'Built internal tools and customer-facing dashboards with performance in mind.',
        ),
      ],
      socialLinks: [
        SocialLink(
          type: SocialLinkType.github,
          url: 'https://github.com',
          label: 'GitHub',
        ),
        SocialLink(
          type: SocialLinkType.linkedin,
          url: 'https://linkedin.com',
          label: 'LinkedIn',
        ),
        SocialLink(
          type: SocialLinkType.email,
          url: 'mailto:you@example.com',
          label: 'Email',
        ),
      ],
    );
  }
}
