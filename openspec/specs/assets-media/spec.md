# Specification: Assets & Media Domain

## 1. Scope & Overview
The Assets & Media domain governs catalog persistence, image/animation projection, offline reliability, and zero external runtime dependencies.

---

## 2. Requirements

### REQ-MED-01: 100% Offline Asset Packaging
The application MUST bundle all necessary exercise animations, workout covers, and vector icons locally to allow full offline training.

- **Scenario 1: Exercise Catalog Manifest**
  - **Given** the local file `assets/data/exercise_catalog.json`,
  - **When** parsed,
  - **Then** all `thumbnailURL` attributes MUST resolve to local paths (`assets/images/exercises/<hash>.gif`).
  - **And** no URL in the catalog SHALL reference `symmetry-assets.com`.

- **Scenario 2: Workout Plans and Quick Workouts**
  - **Given** the plan manifests in `assets/workout_plan_templates/` and `assets/quick_workouts/`,
  - **When** loaded,
  - **Then** all cover images MUST resolve to local paths (`assets/images/plans/` and `assets/images/quick_workouts/`).

---

### REQ-MED-02: ExtendedImage Projection
All exercise GIFs, covers, and remote media MUST be projected through the centralized `SymmetryExtendedImage` component.

- **Scenario 1: Local Asset Projection**
  - **Given** an asset path starting with `assets/`,
  - **When** rendered by `SymmetryExtendedImage`,
  - **Then** it MUST invoke `ExtendedImage.asset` with `gaplessPlayback: true` and hardware acceleration.

- **Scenario 2: Remote Fallback Projection**
  - **Given** a network URL starting with `http://` or `https://`,
  - **When** rendered by `SymmetryExtendedImage`,
  - **Then** it MUST invoke `ExtendedImage.network` with disk and memory cache enabled.

- **Scenario 3: Error and Loading Fallbacks**
  - **Given** an unavailable or corrupted image source,
  - **When** loading fails,
  - **Then** the component MUST display the designated fallback placeholder icon without crashing or throwing unhandled exceptions.
