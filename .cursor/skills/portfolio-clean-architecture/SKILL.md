---
name: portfolio-clean-architecture
description: >-
  Enforces this repo's Flutter Clean Architecture (feature-first, domain/data/presentation,
  Bloc + Freezed state, GetIt, Dartz). Use when adding features, refactoring layers,
  wiring DI, or writing Bloc/UI for portfolio_version_2.
---

# Portfolio Clean Architecture (AI rules)

Follow these rules when changing or extending this codebase. Dependencies point **inward**: Presentation → Domain ← Data.

## Layout

```
lib/
├── core/                          # Shared, no feature-specific business rules
│   ├── animations/                # Reusable motion (e.g. flutter_animate extensions)
│   ├── di/                        # GetIt registration only
│   ├── error/                     # Failure hierarchy (domain-facing errors)
│   ├── extensions/                # BuildContext / other small extensions
│   ├── models/                    # Cross-cutting DTOs (e.g. ErrorModel + codegen)
│   ├── theme/
│   ├── usecases/                  # Base UseCase + NoParams
│   └── utils/
├── features/
│   └── <feature_name>/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/      # Abstract repository interfaces only
│       │   └── usecases/
│       ├── data/
│       │   ├── datasources/       # Local / remote sources (implementations)
│       │   └── repositories/    # Repository implementations
│       └── presentation/
│           ├── bloc/              # Events, Freezed state, Bloc
│           ├── pages/
│           └── widgets/           # shell/, layout/, shared/, hero/, skills/, projects/, …
└── main.dart
```

## Domain layer

- **Entities**: Immutable, `Equatable` where helpful; no Flutter imports; no JSON/HTTP types.
- **Repository interfaces**: Only abstract contracts; return `Future<Either<Failure, T>>` (Dartz).
- **Use cases**: Implement `UseCase<ReturnType, Params>` from `core/usecases/usecase.dart`; call repository; no UI, no `BuildContext`.
- **Failures**: Use / extend `Failure` from `core/error/failures.dart` inside the domain/data boundary—not `ErrorModel` in domain.

## Data layer

- **Data sources**: Concrete classes (`*Impl`); async I/O; may throw or return models—repository maps to `Either`.
- **Repository implementation**: Depends on `PortfolioLocalDataSource` (or remote); maps exceptions to `Left(Failure)`; maps success to `Right(entity)`.
- Do **not** import presentation or `flutter_bloc` from data.

## Presentation layer

- **State management**: `flutter_bloc` + `bloc` package.
- **Events**: `sealed` / `final class` + `Equatable` in `*_event.dart` (no Freezed required unless you add it).
- **State**: Prefer **one** `@freezed` state class with:
  - A **status enum** (e.g. `init`, `showLoading`, `loaded`, `error`).
  - Domain payload fields when loaded (e.g. `PortfolioProfile? profile`).
  - `ErrorModel? errorModel` for user-facing errors (see `core/models/error_model.dart`).
- **Bloc**: Injects use cases via constructor; maps `Failure` → `ErrorModel(message: …)` when emitting error; uses `state.copyWith(...)`.
- **UI**: `BlocBuilder` / `BlocListener`; switch on **`state.status`**, not ad-hoc flags.
- **Web vs mobile**: Prefer **one** body widget that branches layout (`kIsWeb`, `LayoutBuilder`, breakpoints) and builds the **same section list once**—avoid duplicating scroll content in separate `mobile/` and `web/` files unless shells diverge heavily.
- **Motion**: Reuse `core/animations/portfolio_entrance.dart` patterns (`flutter_animate`) for entrance animations—avoid duplicating long animation chains in every widget.

## Core DI (GetIt + injectable)

- Entry: `core/di/di_service.dart` — top-level `@InjectableInit`, `configureDependencies()`, `DiService.getIt`, `DiService.setup()`.
- Annotate implementations: `@LazySingleton(as: Interface)`, use cases `@lazySingleton`, Blocs `@injectable` (factory).
- Flavor: `kIsWeb ? 'web' : F.name` (`core/config/app_flavor.dart`, override with `--dart-define=APP_FLAVOR=`).
- After adding/changing `@injectable`: `dart run build_runner build --delete-conflicting-outputs`.
- `main.dart`: `WidgetsFlutterBinding.ensureInitialized()` → `await DiService.setup()` → `runApp`.

## Code generation

- After changing `@freezed` / `json_serializable` models: run  
  `dart run build_runner build --delete-conflicting-outputs`
- Generated files (`*.freezed.dart`, `*.g.dart`) are gitignored in this repo—CI and teammates must run codegen.

## Imports and naming

- **English** for code, types, and file names; `snake_case` files; `PascalCase` types.
- One feature’s presentation should not import another feature’s data layer; share via `core/` or explicit domain contracts if needed.

## Anti-patterns (do not do)

- Business logic or `Either`/repository calls inside widgets.
- Domain entities depending on Flutter or third-party DTOs.
- Hard-coded navigation strings scattered without a single routing strategy (when you add routes, keep them in one place).
- Ignoring `Failure` / `ErrorModel` distinction: **Failure** in domain/data; **ErrorModel** in presentation state for display.

## Quick checklist for a new feature

1. Add entities + repository interface + use case(s) under `domain/`.
2. Add datasource + repository impl under `data/`.
3. Add `@injectable` / `@LazySingleton(as: …)` and run `build_runner`.
4. Add Bloc (events + Freezed state + bloc) under `presentation/bloc/`.
5. Add page + widgets; use a single adaptive body when only shell/spacing differs.
6. Run `build_runner` if you added/changed Freezed/JSON models.
7. Run `flutter analyze` before finishing.
