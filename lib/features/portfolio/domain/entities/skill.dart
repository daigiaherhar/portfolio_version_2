import 'dart:ui' show Color;

import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  final String name;
  final int proficiencyPercent;
  final Color? color;

  const Skill({
    required this.name,
    required this.proficiencyPercent,
    this.color,
  });

  @override
  List<Object?> get props => [name, proficiencyPercent, color];
}
