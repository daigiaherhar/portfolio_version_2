import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio_version_2/core/config/app_flavor.dart';

import 'di_service.config.dart';

final GetIt _getIt = GetIt.instance;

/// Must stay top-level for [injectable_generator].
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {
  _getIt.init(environment: kIsWeb ? 'web' : F.name);
}

class DiService {
  static GetIt get getIt => _getIt;

  static Future<void> setup() async {
    configureDependencies();
  }
}
