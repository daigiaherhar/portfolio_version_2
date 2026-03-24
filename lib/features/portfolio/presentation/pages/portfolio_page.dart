import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_version_2/core/di/di_service.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/bloc/portfolio_event.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/bloc/portfolio_state.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/widgets/shell/portfolio_view.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          DiService.getIt<PortfolioBloc>()..add(const LoadPortfolio()),
      child: BlocListener<PortfolioBloc, PortfolioState>(
        listenWhen: (PortfolioState previous, PortfolioState current) =>
            current.status == PortfolioStatus.error &&
            current.errorModel != null,
        listener: (BuildContext context, PortfolioState state) {
          if (kDebugMode) {
            debugPrint('PortfolioBloc error: ${state.errorModel?.message}');
          }
        },
        child: const PortfolioView(),
      ),
    );
  }
}
