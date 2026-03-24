import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_version_2/core/models/error_model.dart';
import 'package:portfolio_version_2/core/usecases/usecase.dart';
import 'package:portfolio_version_2/features/portfolio/domain/usecases/get_portfolio.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/bloc/portfolio_event.dart';
import 'package:portfolio_version_2/features/portfolio/presentation/bloc/portfolio_state.dart';

@injectable
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetPortfolio _getPortfolio;

  PortfolioBloc(this._getPortfolio) : super(const PortfolioState()) {
    on<LoadPortfolio>(_onLoadPortfolio);
  }

  Future<void> _onLoadPortfolio(
    LoadPortfolio event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(
      state.copyWith(
        status: PortfolioStatus.showLoading,
        errorModel: null,
      ),
    );
    final result = await _getPortfolio(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PortfolioStatus.error,
          errorModel: ErrorModel(message: failure.message),
        ),
      ),
      (profile) => emit(
        state.copyWith(
          status: PortfolioStatus.loaded,
          profile: profile,
          errorModel: null,
        ),
      ),
    );
  }
}
