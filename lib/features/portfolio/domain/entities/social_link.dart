import 'package:equatable/equatable.dart';

enum SocialLinkType { github, linkedin, email, twitter, website }

class SocialLink extends Equatable {
  final SocialLinkType type;
  final String url;
  final String label;

  const SocialLink({
    required this.type,
    required this.url,
    required this.label,
  });

  @override
  List<Object?> get props => [type, url, label];
}
