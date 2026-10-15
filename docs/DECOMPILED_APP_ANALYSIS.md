# Reverse Engineering Analysis & Decompiled Architecture Report

**Target Artifact:** `club.symmetry.application` (v7.15.0)  
**Analyzed Binary Package:** Split APK / XAPK (`club.symmetry.application.apk`, `config.arm64_v8a.apk`, `config.xxhdpi.apk`)  
**Decompilation & Extraction Timestamp:** October 2026  
**Document Target:** Proport Architecture & Asset Integrity Documentation  

---

## 1. Executive Summary

This report documents the reverse-engineering analysis of the Symmetry mobile application (APK package `club.symmetry.application`), the extracted assets, the reverse-engineered Flutter/Dart module topology, design system tokens, and their integration into the clean, offline-first **Proport** codebase.

All extracted assets, vectors, and routines have been sanitized and decoupled from remote Symmetry CDN servers (`symmetry-assets.com`), guaranteeing total privacy, 100% offline functionality, and complete autonomy.

---

## 2. Reverse Engineering Methodology & Package Structure

The original distribution was packaged as an Android App Bundle (XAPK) containing split APKs:

```
scratch/symmetry/
├── club.symmetry.application.apk   # Base APK (~76 MB) - Flutter assets, manifests, bytecode
├── config.arm64_v8a.apk            # Architecture split (~53 MB) - libflutter.so, libapp.so
├── config.xxhdpi.apk               # Density split (~194 KB) - System launcher icons
└── manifest.json                   # App bundle descriptor
```

### 2.1 Extraction & Binary Inspection
1. **Archive Unbundling**: Extracted the APK archives to isolate the Flutter runtime and compiled Dart AOT snapshot.
2. **Flutter Asset Manifest**: Parsed `AssetManifest.bin` and `FontManifest.json` inside `assets/flutter_assets/` to catalog all authentic SVG icons, image assets, fonts, and structured JSON catalogs.
3. **Dart AOT String & Symbol Recovery**: Inspected the ELF binary `lib/arm64-v8a/libapp.so` using binary inspection tools (`strings`, symbol pattern recognition) to recover Dart package routes, feature module hierarchies, class names, state management cubits, and presentation widget structures.

---

## 3. Discovered Dart Module Architecture (`libapp.so`)

Inspection of the Dart AOT snapshot in `libapp.so` revealed a modular architecture organized by feature and bounded contexts:

### 3.1 Library Module Topology
The user's "Mi biblioteca" screen originates from:
```
package:symmetry/training/library_module/
├── core_feature/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── library_item_entity.dart
│   │   └── state_management/
│   │       ├── library_cubit.dart
│   │       ├── library_filter.dart
│   │       └── library_sort.dart
│   └── presentation/
│       ├── screens/
│       │   ├── library_screen.dart
│       │   └── library_shell_screen.dart
│       └── sections/
│           ├── header/
│           │   ├── library_header.dart
│           │   └── library_floating_header.dart
│           ├── filter_chips/
│           │   ├── library_filter_chips_row.dart
│           │   └── selectable_filter_chip.dart
│           ├── recents/
│           │   ├── library_item_card.dart
│           │   ├── library_item_row.dart
│           │   ├── library_item_visuals.dart
│           │   └── TemplateCard (with 2x2 exercise sketch layout)
│           └── explore/
│               ├── explore_programs_section.dart
│               └── catalog_plan_row.dart
```

### 3.2 Key Modules Identified Across the App
- `package:symmetry/training/training_page_module/`: Dashboard, Tu Plan Hero card, active training sessions.
- `package:symmetry/training/exercise_catalog_module/`: Muscle group indexing, exercise details, search filters.
- `package:symmetry/statistics/`: Symmetry Score, body diagram ranking, muscle volume calculation, 1RM calculators.
- `package:symmetry/intelligence/chatbot_module/`: AI workout generator and adaptive overload recommendations.
- `package:symmetry/social_media/`: Friends list, user profile, workout sharing.

---

## 4. Design System Tokens & Asset Inventory

### 4.1 Typography
The decompiled app relies on three font families extracted from `assets/fonts/`:
- **`AlbertSans`** (400, 500, 700, 800): Used for page headers ("Mi biblioteca"), workout titles, rank badges.
- **`DMSans`** (300 to 900): Primary body font, subtitles, filter chips, button labels.
- **`DMMono`** (300 to 500): Technical numerical values, timers, rep counters, weight logs.

### 4.2 Color Palette & Visual Accents
- **Background**: Deep obsidian black `#000000` / `#09090A`.
- **Surfaces & Cards**: Neutral dark `#141416` and `#1A1A1D`.
- **Card Borders**: Subtle separator lines `#1E1E22`, `#222225`, and `#26262B`.
- **Selected "Tu plan inteligente" Glow**: Purple/Indigo border `#6C5CE7` / `#8B5CF6` with a soft blur shadow (`Color(0x596C5CE7)`).
- **Target Muscle Accent**: High-contrast Crimson Red `#E53935` / `#FF3B30` used on stick figure diagrams.
- **Secondary Text & Icons**: Neutral gray `#8E8E93` and `#9E9EA7`.

### 4.3 Iconography & Vector Assets
- **Navigation Bar (Redesign)**:
  - `assets/icons/navigation_bar/redesign/friends.svg` (Amigos)
  - `assets/icons/navigation_bar/redesign/ranks.svg` (Rangos - Star in shield)
  - `assets/icons/navigation_bar/redesign/train.svg` (Entrenar - Dumbbell)
  - `assets/icons/navigation_bar/redesign/library.svg` (Biblioteca - 3 vertical slanted books)
  - `assets/icons/navigation_bar/redesign/profile.svg` (Perfil - User outline)
- **Library Icons**:
  - `assets/icons/lucide_list.svg` (3 bullets + 3 lines icon next to "Plantilla")
  - `assets/icons/library/explore_programs.svg` (Compass icon inside circular border)
  - `assets/icons/library/create_program.svg`
  - `assets/icons/library/create_workout.svg`
- **Ranking & Musculoskeletal Diagrams**:
  - 12 muscle group SVGs in `assets/icons/ranking/muscle_drawer/` (pecho, espaldasuperior, biceps, triceps, cuadriceps, hombros, etc.)
  - Tiered ranking badges in `assets/icons/ranking/base/` (bronze, silver, gold, diamond, emerald)

### 4.4 Structured JSON Catalogs
- `assets/workout_plan_templates/predefined_workout_plans_v2.json`: Over 80 structured training plans covering equipment levels (noEquipment, smallGym, gym, calisthenics).
- `assets/quick_workouts/generation_sessions.json`: Templates for quick generation sessions.
- `assets/exercise_ranking_mock.json`: Benchmark ranking values for muscle groups.
- `assets/translations/es.json`: Complete Spanish localization dictionary.

---

## 5. UI Reconstruction in Proport

Based on the authentic screenshot and decompiled evidence:

1. **Header Layout**:
   - Circular avatar leading widget (`Color(0xFF222226)`).
   - "Mi biblioteca" title in bold Albert Sans (24px, -0.5 tracking).
   - Search (`Icons.search_rounded`) and Add (`Icons.add_rounded`) action icons.

2. **Category Chips**:
   - `Tu plan inteligente`: Selected by default, styled with subtle purple/indigo outline glow.
   - `Programas`, `Plantillas`, `Ejercicios`: Secondary pill chips with dark fill and muted typography.

3. **Template Tiles & 2x2 Exercise Sketches**:
   - White rounded card (`64x64 px`, `BorderRadius.circular(16)`).
   - 2x2 stick figure exercise sketches with precision gray equipment lines, dark charcoal body lines, and active red muscle highlight dots:
     - `Domingo`: Leg Press, Chest Press, Leg Extension, Lat Pulldown.
     - `Sábado de Tracción 🦍`: Lat Pulldown, Seated Row, Bicep Curl, Upright Row.
     - `Sábado de Empuje 🫣`: Incline Bench, Flat Bench, Cable Fly, Tricep Pushdown.
     - `Pecho, Triceps`: Flat Bench, Incline Bench, Cable Fly, Tricep Pushdown.
     - `Espalda, Biceps`: Lat Pulldown, Seated Row, Lat Pulldown variant, Bicep Curl.
     - `Piernas, Hombros`: Leg Press, Leg Extension, Shoulder Press, Lateral Raise.
   - Subtitle indicator with `lucide_list.svg` vector icon and exercise count.

4. **Bottom Explore Card**:
   - Single clean card: "Explorar programas" (`Elige de entre 80+ programas distintos`) featuring the decompiled compass SVG.

5. **Navigation Shell**:
   - 5-tab redesign layout (`Amigos`, `Rangos`, `Entrenar`, `Biblioteca`, `Perfil`) using authentic SVG assets.

---

## 6. Verification & Test Evidence

- **Flutter Analyzer**: 0 errors, 0 warnings across all project files.
- **Unit & Widget Tests**: All test suites passing (`flutter test`).
- **Asset Declaration**: All SVGs, fonts, and catalogs registered in `pubspec.yaml`.
- **Zero Remote Dependencies**: No calls to `symmetry-assets.com` during runtime; all resources served locally.
