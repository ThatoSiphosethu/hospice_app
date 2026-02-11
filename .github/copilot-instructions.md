# Hospice App - AI Agent Instructions

## Project Overview
A Flutter clinical application for hospice care management with role-based dashboards (admin, clinician, patient, family). Multi-platform support: Android, iOS, Linux, macOS, Windows.

## Architecture

### Feature-Based Structure
```
lib/features/{feature}/
├── presentation/        # UI screens and widgets
├── domain/             # Business models (Patient, ClinicalNote, etc.)
└── data/               # Repositories and mock data sources
```
Each feature is **self-contained**—avoid cross-feature imports except through shared components.

### Core Modules
- **`core/theme/app_theme.dart`**: Global MaterialApp theme configuration (colors, typography, component themes)
- **`core/routing/app_router.dart`**: Named route definitions using `MaterialApp.routes` (not Go Router or Beamer)
- **`core/auth/`**: Reserved for authentication logic (currently empty)
- **`shared/widgets/`**: Reusable UI components used across features (e.g., `AppShell`, buttons, search bars)
- **`shared/models/`**: Cross-feature domain models

## Key Patterns & Conventions

### 1. Navigation
- Uses **named routes** with `Navigator.pushNamed()` and `MaterialApp.routes`
- Route arguments passed via `ModalRoute.of(context)!.settings.arguments`
- Example: `/meds` route passes `Patient` object to `MedicationScreen`
- **Add new routes** to `AppRouter.routes` map with proper argument handling

### 2. Shared UI Shell
- **`AppShell`** (`lib/shared/widgets/app_shell.dart`): Reusable Scaffold with animated bottom navigation
- Manages page switching with `AnimatedSwitcher` and fade transitions
- Each clinician-facing screen (ClinicianHome, DoctorDashboard) uses AppShell to provide consistent navigation
- Bottom nav styling comes from `AppTheme.bottomNavigationBarTheme`

### 3. Theming
- Single source of truth: `AppTheme.lightTheme`
- Apply Material Design tokens (colors, fonts) here; component-specific customization in theme data
- Example: BottomNavigationBar styling uses `BottomNavigationBarThemeData` (see current deep purple + white)
- No dark theme yet—add `AppTheme.darkTheme` when needed

### 4. State Management
- **Current approach**: Simple `StatefulWidget` with `setState()` for local page state
- Example: `PatientListScreen` uses `TextEditingController` and local `List<Patient>` with `setState()`
- **When to introduce state management**: If you need app-wide state, cross-feature communication, or persistent caching, consider adding:
  - Provider package for dependency injection and reactive state
  - GetIt for service locator (currently not in pubspec.yaml)
  - Do NOT add Redux, BLoC, or RiverPod without team discussion

### 5. Domain & Data Layer
- **Domain models** live in `features/{feature}/domain/` (e.g., `Patient`, `ClinicalNote`)
- Should be **plain Dart classes** with `final` fields and `required` constructors
- **Repositories** in `features/{feature}/data/` provide data access (mock implementations for now)
- Example pattern:
  ```dart
  class Patient {
    final String id, name, diagnosis, status;
    Patient({required this.id, required this.name, ...});
  }
  class MockPatientRepository {
    Future<List<Patient>> fetchPatients() async { ... }
  }
  ```

### 6. File & Naming Conventions
- **Library documentation**: Each file starts with `library;` and doc comment:
  ```dart
  /// Brief description of file purpose.
  library;
  import '...';
  ```
- **Screen naming**: `{name}_screen.dart` or `{name}_dashboard.dart` (presentation layer)
- **Widget naming**: `{name}_widget.dart` or just `{name}.dart` (shared components)
- **Model naming**: `{name}.dart` (domain/data layers)
- Private methods/fields use `_leading` underscore

### 7. Code Organization
- Import order: dart: → package: → relative imports (same as Dart style guide)
- Const constructors: Always use for StatelessWidgets and immutable widgets
- Dispose pattern: Override `dispose()` in State for TextEditingController cleanup
- Keep presentation logic light—push complex logic to domain or data layers

## Build & Environment

### Dependencies
- Flutter SDK: ^3.10.7
- flutter_lints for analysis
- cupertino_icons for icon styling
- **No external state management, networking, or persistence packages yet**

### Development Workflow
```bash
flutter pub get           # Install dependencies
flutter run              # Run on default device
flutter run -d {deviceId} # Run on specific device
flutter analyze          # Lint check (analysis_options.yaml enforced)
flutter build android    # Build APK/AAB
flutter build ios        # Build iOS
```

## Common Tasks

### Add a New Screen
1. Create feature folder under `lib/features/{feature}/presentation/`
2. Create `{screen_name}_screen.dart` with StatelessWidget or StatefulWidget
3. Add route to `AppRouter.routes` map
4. Import and use in parent navigation (e.g., AppShell pages list)

### Add a New Theme Component
1. Edit `AppTheme.lightTheme` in `lib/core/theme/app_theme.dart`
2. Use `ThemeData` properties: `appBarTheme`, `bottomNavigationBarTheme`, `textTheme`, etc.
3. Apply in widgets via `Theme.of(context).{component}` (e.g., `Theme.of(context).bottomNavigationBarTheme.backgroundColor`)

### Reuse a Widget Across Features
1. Move widget to `lib/shared/widgets/` directory
2. Export from a potential `lib/shared/widgets/barrel.dart` (create if sharing 3+ widgets)
3. Import relative path: `import '../../../shared/widgets/{widget}.dart';`

### Pass Data Between Screens
- Via route arguments: `Navigator.pushNamed(context, '/meds', arguments: patient)`
- Retrieve: `final patient = ModalRoute.of(context)!.settings.arguments as Patient;`
- For complex app-wide state: Introduce Provider package (currently not needed)

## Warnings & Anti-Patterns

- ❌ Don't import features across other features (breaks modularity)
- ❌ Don't hardcode colors/fonts in widgets (use Theme.of() instead)
- ❌ Don't mix business logic in presentation layer
- ❌ Don't add nested MaterialApp widgets
- ❌ Don't create new domain models without discussing with team (use existing ones from `shared/models/` if applicable)

## Key Files Reference

| File | Purpose |
|------|---------|
| [lib/main.dart](../lib/main.dart) | App entry point, MaterialApp config |
| [lib/core/routing/app_router.dart](../lib/core/routing/app_router.dart) | Route definitions |
| [lib/core/theme/app_theme.dart](../lib/core/theme/app_theme.dart) | Global theme |
| [lib/shared/widgets/app_shell.dart](../lib/shared/widgets/app_shell.dart) | Navigation shell for clinician screens |
| [lib/features/ehr](../lib/features/ehr) | EHR feature with Patient/Note models |
| [pubspec.yaml](../pubspec.yaml) | Dependencies & Flutter config |

---

**Last Updated**: 2026-02-10 | Questions? Check feature README files and existing implementation patterns.
