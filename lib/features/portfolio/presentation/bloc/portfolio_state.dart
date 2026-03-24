import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio_version_2/core/models/error_model.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';

part 'portfolio_state.freezed.dart';

enum PortfolioStatus {
  init,
  showLoading,
  loaded,
  error,
}

@freezed
abstract class PortfolioState with _$PortfolioState {
  const factory PortfolioState({
    @Default(PortfolioStatus.init) PortfolioStatus status,
    PortfolioProfile? profile,
    ErrorModel? errorModel,
  }) = _PortfolioState;
}
