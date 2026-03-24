import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_version_2/core/animations/portfolio_entrance.dart';
import 'package:portfolio_version_2/core/theme/app_theme.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';

/// Warm studio hero: soft gradient mark, serif name, friendly copy.
class HeroSection extends StatelessWidget {
  final PortfolioProfile profile;
  final bool useCompactDeviceLayout;
  final double? accentTargetHeight;

  const HeroSection({
    super.key,
    required this.profile,
    this.useCompactDeviceLayout = false,
    this.accentTargetHeight,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final Widget blob = _HeroBlob(scheme: scheme);
    final Widget copy = _HeroCopy(profile: profile, scheme: scheme);
    if (useCompactDeviceLayout) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: blob).portfolioHeroAccentEntrance(),
          const SizedBox(height: 28),
          copy.portfolioHeroCopyEntrance(),
        ],
      );
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool isWide = constraints.maxWidth > 720;
        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              blob.portfolioHeroAccentEntrance(),
              const SizedBox(width: 36),
              Expanded(child: copy.portfolioHeroTextEntrance()),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: blob).portfolioHeroAccentEntrance(),
            const SizedBox(height: 28),
            copy.portfolioHeroCopyEntrance(),
          ],
        );
      },
    );
  }
}

class _HeroBlob extends StatelessWidget {
  final ColorScheme scheme;

  const _HeroBlob({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primary.withValues(alpha: 0.35),
            scheme.tertiary.withValues(alpha: 0.5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.2),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.waving_hand_rounded,
        size: 44,
        color: scheme.primary.withValues(alpha: 0.9),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  final PortfolioProfile profile;
  final ColorScheme scheme;

  const _HeroCopy({required this.profile, required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello — I’m',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: scheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          profile.fullName,
          style: AppTheme.displaySerif(context),
        ),
        const SizedBox(height: 12),
        Text(
          profile.headline,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            height: 1.35,
            color: scheme.primary,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          profile.summary,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            height: 1.65,
            fontWeight: FontWeight.w400,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
