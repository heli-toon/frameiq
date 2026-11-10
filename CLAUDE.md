# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a basic Flutter project created as a starting point for a Flutter application. It contains:

- A simple counter app in `lib/main.dart`
- Basic widget test in `test/widget_test.dart`
- Standard Flutter project structure

## Development Workflow

### Getting Started
1. Ensure Flutter SDK is installed
2. Run `flutter pub get` to fetch dependencies
3. Run `flutter run` to launch the app on a device/emulator
4. Run `flutter test` to run tests

### Common Tasks

#### Running the App
```bash
flutter run
```

#### Running Tests
```bash
flutter test
```

#### Analyzing Code
```bash
flutter analyze
```

#### Updating Dependencies
```bash
flutter pub upgrade --major-versions
```

## Project Structure

- `lib/main.dart` - Main application code with a simple counter app
- `test/widget_test.dart` - Basic widget test for the counter functionality
- `pubspec.yaml` - Project dependencies and metadata
- `analysis_options.yaml` - Dart analyzer configuration

## Code Patterns

This project follows standard Flutter patterns:
- Uses StatefulWidget for stateful components (MyHomePage)
- Uses setState() for state updates
- Uses MaterialApp with ThemeData for theming
- Follows standard widget testing patterns with WidgetTester

## Testing Guidelines

Tests are located in the `test/` directory and use the `flutter_test` package.
To add new tests:
1. Create a new test file in `test/` directory
2. Use `testWidgets()` for widget tests
3. Use `tester.pumpWidget()` to build widgets
4. Use `tester.tap()` and `tester.pump()` for interactions
5. Use `expect()` with `finders` for assertions

## Code Style

This project uses the standard Flutter lints package (`flutter_lints`) which provides:
- Effective Dart lints
- Flutter-specific lints
- Recommended coding practices

To run linting: `flutter analyze`

## Platform-Specific Considerations

This Flutter project targets mobile (Android, iOS) and web. 
Platform-specific code should be placed in:
- `lib/` for cross-platform code
- Platform-specific directories if needed (though this basic template doesn't include them)

## Common Issues

- Ensure Flutter SDK is up to date: `flutter upgrade`
- Run `flutter pub get` after changing dependencies
- For web builds: `flutter build web`
- For Android builds: `flutter build apk` or `flutter build appbundle`
- For iOS builds: `flutter build ios` (requires macOS and Xcode)