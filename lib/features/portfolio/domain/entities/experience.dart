import 'package:equatable/equatable.dart';

class Experience extends Equatable {
  final String company;
  final String role;
  final String period;
  final String summary;

  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.summary,
  });

  @override
  List<Object?> get props => [company, role, period, summary];
}
