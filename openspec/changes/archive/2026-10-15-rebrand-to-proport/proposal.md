# Change Proposal: Rebrand Project to Proport

## Why
The application requires a distinct, legally safe brand identity to prevent trademark infringement risks associated with "Symmetry". The selected brand name is **Proport** (derived from proportionality, golden ratio, and balanced hypertrophy).

## What Changes
1. **Dart Package Identity**: Rename `pubspec.yaml` package name from `symmetry` to `proport`.
2. **Import Statements**: Replace all `package:symmetry/` imports in `lib/` and `test/` with `package:proport/`.
3. **Android Configuration**:
   - `android/app/build.gradle.kts`: update `namespace` and `applicationId` to `club.proport.fitness`.
   - `android/app/src/main/AndroidManifest.xml`: update `android:label` to `Proport`.
   - Update Kotlin package path to `club/proport/fitness/MainActivity.kt`.
4. **UI Branding**:
   - Dashboard header: `SYMMETRY` -> `PROPORT`.
   - Coach & Assistant dialogs: `Symmetry Intelligence` / `Symmetry Coach` -> `Proport Intelligence` / `Proport Coach`.
5. **OpenSpec Specifications**: Update `openspec/config.yaml` and specifications to use `proport`.
6. **Project Workspace Folder**: Move project directory from `/Users/silver/Documents/pp/symmetry` to `/Users/silver/Documents/pp/proport`.

## Rollback Plan
Git revision revert and directory rename back to `symmetry`.
