import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortfolioFooterNote extends StatelessWidget {
  final bool isWebTarget;

  const PortfolioFooterNote({super.key, required this.isWebTarget});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final String label = isWebTarget
        ? 'Made with Flutter for the web'
        : 'Made with Flutter';
    return Text(
      label,
      textAlign: TextAlign.center,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontStyle: FontStyle.italic,
        color: scheme.onSurfaceVariant.withValues(alpha: 0.55),
      ),
    );
  }
}
