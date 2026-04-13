import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_version_2/core/router/app_section_route.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/bloc/portfolio_event.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/bloc/portfolio_state.dart';
import 'package:portfolio_version_2/core/theme/const_sizes.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/book/book_portfolio_reader.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  AppSectionRoute _section = AppSectionRoute.cover;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (BuildContext context, PortfolioState state) {
          return switch (state.status) {
            PortfolioStatus.init => const Center(
                child: _PortfolioLoadingIndicator(),
              ),
            PortfolioStatus.showLoading => const Center(
                child: _PortfolioLoadingIndicator(),
              ),
            PortfolioStatus.loaded => switch (state.profile) {
                null => const Center(
                    child: _PortfolioLoadingIndicator(),
                  ),
                final PortfolioProfile profile => BookPortfolioReader(
                    profile: profile,
                    currentSection: _section,
                    onSectionChanged: (AppSectionRoute nextSection) {
                      if (nextSection != _section) {
                        setState(() => _section = nextSection);
                      }
                    },
                  ),
              },
            PortfolioStatus.error => _PortfolioErrorBody(
                message:
                    state.errorModel?.message ?? 'Something went wrong.',
              ),
          };
        },
      ),
    );
  }
}

class _PortfolioLoadingIndicator extends StatelessWidget {
  const _PortfolioLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator()
        .animate(
          onPlay: (AnimationController controller) =>
              controller.repeat(reverse: true),
        )
        .scale(
          begin: const Offset(0.92, 0.92),
          end: const Offset(1, 1),
          duration: 900.ms,
          curve: Curves.easeInOut,
        )
        .fadeIn(duration: 280.ms);
  }
}

class _PortfolioErrorBody extends StatelessWidget {
  final String message;

  const _PortfolioErrorBody({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ConstSizes.s24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: ConstSizes.s16),
            FilledButton.icon(
              onPressed: () =>
                  context.read<PortfolioBloc>().add(const LoadPortfolio()),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
