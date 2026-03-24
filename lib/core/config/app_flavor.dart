/// Label passed to injectable [Environment] when not on web (`kIsWeb == false`).
/// Override with `--dart-define=APP_FLAVOR=staging` etc.
abstract final class F {
  static const String name = String.fromEnvironment(
    'APP_FLAVOR',
    defaultValue: 'app',
  );
}
