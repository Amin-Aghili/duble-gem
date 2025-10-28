// Project: Flutter Desktop Dubbing Assistant
// Purpose: Responsive desktop Flutter app (Windows/macOS/Linux) for loading a text file of dubbing lines
// and interactively highlighting, striking-through, counting, and filtering by actor.
// File structure (lib/):
//  - main.dart
//  - models/dialog_line.dart
//  - services/parser.dart
//  - widgets/actor_selector.dart
//  - widgets/dialog_list.dart
//  - widgets/top_bar.dart
//  - utils/theme.dart
//  - utils/rtl_text.dart
//  - README.md (at project root)

/*
pubspec.yaml (excerpt) — add this to your project's pubspec.yaml

name: dubbing_assistant
description: A minimal and responsive Flutter desktop app for dubbing scripts (Persian RTL support).
version: 0.1.0

environment:
  sdk: ">=2.18.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
  file_picker: ^5.2.5
  flutter_localizations:
    sdk: flutter

# fonts: put any Persian font files under assets/fonts/ and reference below
flutter:
  uses-material-design: true
  assets:
    - assets/sample.txt
  fonts:
    - family: Vazir
      fonts:
        - asset: assets/fonts/Vazir-Regular.ttf
        - asset: assets/fonts/Vazir-Bold.ttf
          weight: 700


Important: enable desktop support: `flutter config --enable-windows-desktop` (or macOS/linux)
Run: `flutter run -d windows` or `flutter run -d macos` etc.
*/

// ------------------------- lib/widgets/dialog_list.dart -------------------------

// ------------------------- lib/widgets/top_bar.dart -------------------------

// ------------------------- lib/utils/theme.dart -------------------------

// ------------------------- lib/main.dart -------------------------


// ------------------------- README.md -------------------------

/*
README - Quick start
1. Create a new Flutter project: `flutter create dubbing_assistant`
2. Replace pubspec.yaml with font entries, add dependencies.
3. Put the code files above under lib/ with matching file names.
4. Add a Persian font under assets/fonts/Vazir-Regular.ttf (or change name).
5. Enable desktop support and run: `flutter run -d windows` (or macos/linux)

Features included:
- Load .txt dubbing script and auto-parse lines into Actor: Dialogue
- Dropdown of actors (auto-generated)
- Highlight selected actor's lines, dim others
- Checkbox and double-click to toggle strike-through (done)
- Font size slider, RTL Persian support, uses Persian font
- Dark / Light theme toggle
- Counts for total/done/remaining overall and per-actor
- Responsive layout for desktop window resizing

Notes & Improvements you can add:
- Save/Load progress (JSON) to disk
- Export filtered script
- Multi-file project, audio sync, playback markers
- Search and jump to line
- Collapse/expand actors
*/
