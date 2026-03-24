import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_version_2/core/error/failures.dart';
import 'package:portfolio_version_2/core/usecases/usecase.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';
import 'package:portfolio_version_2/features/portfolio/domain/repositories/portfolio_repository.dart';

@lazySingleton
class GetPortfolio implements UseCase<PortfolioProfile, NoParams> {
  final PortfolioRepository repository;

  GetPortfolio(this.repository);

  @override
  Future<Either<Failure, PortfolioProfile>> call(NoParams params) {
    return repository.getProfile();
  }
}
