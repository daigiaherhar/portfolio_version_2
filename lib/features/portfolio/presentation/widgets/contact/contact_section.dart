import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/animations/portfolio_entrance.dart';
import 'package:portfolio_version_2/core/utils/url_launcher_helper.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/social_link.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/shared/section_header.dart';

class ContactSection extends StatelessWidget {
  final List<SocialLink> links;

  const ContactSection({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Let’s talk',
          subtitle: 'Always happy to chat about ideas or collaboration.',
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: links.asMap().entries.map(
            (MapEntry<int, SocialLink> entry) {
              return FilledButton.tonalIcon(
                onPressed: () => executeOpenUrl(entry.value.url.trim()),
                icon: Icon(_iconFor(entry.value.type), size: 20),
                label: Text(entry.value.label),
              ).portfolioItemEntrance(entry.key, baseMs: 120, stepMs: 45);
            },
          ).toList(),
        ),
      ],
    );
  }
}

IconData _iconFor(SocialLinkType type) {
  switch (type) {
    case SocialLinkType.github:
      return Icons.code_rounded;
    case SocialLinkType.linkedin:
      return Icons.work_outline_rounded;
    case SocialLinkType.email:
      return Icons.mail_outline_rounded;
    case SocialLinkType.twitter:
      return Icons.chat_bubble_outline_rounded;
    case SocialLinkType.website:
      return Icons.language_rounded;
  }
}
