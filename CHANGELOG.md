## 0.0.1

* TODO: Describe initial release.

## 0.0.2
- Added Dart documentation for the public API (`InnerAiGlowing`, `OuterAiGlow`, and library exports).
- Fixed spelling/typo issues and corrected a blur parameter usage.
- Marked color lists as `const` and improved painter code.
- Updated the example app and widget test to match the current UI.
- Bumped package versions and updated `pubspec.lock` checksums.

## 0.0.3
- **BUG FIX**: Fixed button interaction issue in `InnerAiGlowing` widget where interactive elements (buttons, taps, etc.) were not responding to user input.
- Wrapped `CustomPaint` with `IgnorePointer` to allow touch events to pass through to child widgets while maintaining visual glow effects.
- No API changes - existing code will work without modifications and buttons will now be clickable as expected.


