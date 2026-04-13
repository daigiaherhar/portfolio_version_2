import 'package:flutter/material.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/skill.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_paper_scroll.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/skills_bubble_chart.dart';

class BookPaperSkills extends StatelessWidget {
  final List<Skill> skills;

  const BookPaperSkills({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return BookPaperScroll(
      child: SkillsBubbleChart(skills: skills),
    );
  }
}
