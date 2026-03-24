import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  final String name;
  final int proficiencyPercent;

  const Skill({required this.name, required this.proficiencyPercent});

  @override
  List<Object?> get props => [name, proficiencyPercent];
}
