import 'package:equatable/equatable.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/experience.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/project.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/skill.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/social_link.dart';

class PortfolioProfile extends Equatable {
  final String fullName;
  final String headline;
  final String summary;
  final List<Skill> skills;
  final List<Project> projects;
  final List<Experience> experiences;
  final List<SocialLink> socialLinks;

  const PortfolioProfile({
    required this.fullName,
    required this.headline,
    required this.summary,
    required this.skills,
    required this.projects,
    required this.experiences,
    required this.socialLinks,
  });

  @override
  List<Object?> get props => [
        fullName,
        headline,
        summary,
        skills,
        projects,
        experiences,
        socialLinks,
      ];
}
