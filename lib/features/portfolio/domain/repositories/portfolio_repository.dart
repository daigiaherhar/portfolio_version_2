import 'package:dartz/dartz.dart';
import 'package:portfolio_version_2/core/error/failures.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';

abstract class PortfolioRepository {
  Future<Either<Failure, PortfolioProfile>> getProfile();
}
