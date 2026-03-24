import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_version_2/core/error/failures.dart';
import 'package:portfolio_version_2/features/portfolio/data/datasources/portfolio_local_data_source.dart';
import 'package:portfolio_version_2/features/portfolio/domain/entities/portfolio_profile.dart';
import 'package:portfolio_version_2/features/portfolio/domain/repositories/portfolio_repository.dart';

@LazySingleton(as: PortfolioRepository)
class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;

  PortfolioRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, PortfolioProfile>> getProfile() async {
    try {
      final PortfolioProfile profile = await localDataSource.getProfile();
      return Right(profile);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }
}
