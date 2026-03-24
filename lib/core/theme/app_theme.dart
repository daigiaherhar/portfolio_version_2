import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_version_2/core/theme/book_palette.dart';

/// Global theme aligned with book / editorial portfolio.
abstract final class AppTheme {
  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final bool isLight = brightness == Brightness.light;
    final ColorScheme scheme = ColorScheme(
      brightness: brightness,
      primary: BookPalette.yellow,
      onPrimary: BookPalette.black,
      primaryContainer: BookPalette.yellow.withValues(alpha: 0.85),
      onPrimaryContainer: BookPalette.black,
      secondary: BookPalette.black,
      onSecondary: BookPalette.yellow,
      tertiary: BookPalette.yellow.withValues(alpha: 0.55),
      onTertiary: BookPalette.black,
      surface: isLight ? BookPalette.black : BookPalette.black,
      onSurface: BookPalette.paper,
      surfaceContainerHighest: BookPalette.paper,
      onSurfaceVariant: BookPalette.paper.withValues(alpha: 0.75),
      error: const Color(0xFFB00020),
      onError: BookPalette.white,
      outline: BookPalette.yellow.withValues(alpha: 0.4),
      shadow: Colors.black.withValues(alpha: 0.45),
    );
    final TextTheme sans = GoogleFonts.dmSansTextTheme().apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: sans,
      scaffoldBackgroundColor: BookPalette.black,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: BookPalette.yellow,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: BookPalette.yellow,
          foregroundColor: BookPalette.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  static TextStyle archivoBlack({
    required double fontSize,
    Color color = BookPalette.yellow,
    double height = 1,
  }) {
    return GoogleFonts.archivoBlack(
      fontSize: fontSize,
      color: color,
      height: height,
    );
  }

  /// Used by hero and section header widgets if those layouts are shown again.
  static TextStyle displaySerif(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return GoogleFonts.playfairDisplay(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      height: 1.05,
      color: scheme.onSurface,
    );
  }

  static TextStyle sectionSerif(ColorScheme scheme) {
    return GoogleFonts.playfairDisplay(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      height: 1.12,
      color: scheme.onSurface,
    );
  }
}
