import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String name;
  final String description;
  final String? repositoryUrl;
  final String? liveUrl;
  final List<String> techTags;

  const Project({
    required this.name,
    required this.description,
    this.repositoryUrl,
    this.liveUrl,
    required this.techTags,
  });

  @override
  List<Object?> get props =>
      [name, description, repositoryUrl, liveUrl, techTags];
}
