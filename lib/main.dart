import 'package:flutter/material.dart';
import 'package:portfolio_version_2/core/di/di_service.dart';
import 'package:portfolio_version_2/core/scroll/portfolio_scroll_behavior.dart';
import 'package:portfolio_version_2/core/theme/app_theme.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/pages/portfolio_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DiService.setup();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const PortfolioScrollBehavior(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const PortfolioPage(),
    );
  }
}
