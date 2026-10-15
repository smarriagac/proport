# Specification: Training Feature Domain

## 1. Scope & Overview
The Training domain governs the core user experience for workout plan selection, session inspection, and live guided workout execution matching the decompiled Symmetry mobile application.

---

## 2. Requirements

### REQ-TR-01: Training Dashboard ("Inicio")
The application MUST render the main Training Dashboard reflecting the user's active streak, plan summary, and alternative workout options.

- **Scenario 1: Dashboard Header & Streak**
  - **Given** an authenticated or guest user on the Training tab,
  - **When** the dashboard loads,
  - **Then** the header MUST display the official Symmetry vector logo (`assets/symmetry_logo.svg`) and the streak flame indicator with the current day count.

- **Scenario 2: Active Plan Hero Card**
  - **Given** an active training plan (e.g. "Torso Potencia A"),
  - **When** the hero card is displayed,
  - **Then** it MUST render the authentic plan cover (`assets/images/plans/push_pull_legs_estetico.webp`) using `SymmetryExtendedImage`, show session duration, workout title, and an "INICIAR ENTRENAMIENTO" call-to-action button with a "Ver" preview button.

- **Scenario 3: Alternative Workout Options Card**
  - **Given** the bottom section of the dashboard,
  - **When** rendered,
  - **Then** it MUST show the three options grouped in a unified card: "Generar entrenamiento con IA", "Empezar entrenamiento libre", and "Tus plantillas".

---

### REQ-TR-02: Workout Session Preview ("Ver" Action)
The application MUST allow users to preview the exact exercises and muscle distribution of a workout before starting.

- **Scenario 1: Header and Navigation**
  - **Given** a user tapping "Ver" on the active plan hero card,
  - **When** `WorkoutSessionPreviewPage` opens,
  - **Then** it MUST show a top bar with back navigation, workout title, and session duration.

- **Scenario 2: Muscle Distribution Carousel**
  - **Given** a workout targeting primary muscle groups,
  - **When** the preview renders,
  - **Then** it MUST show horizontal cards with muscle graphics (Hombros, Tríceps, Pecho) and set counts.

- **Scenario 3: Exercise List with Squircle Thumbnails**
  - **Given** the 10 scheduled exercises,
  - **When** displayed,
  - **Then** each row MUST display a white squircle background containing the authentic exercise animation thumbnail (`SymmetryExtendedImage`), subtitle with series/reps, exercise title, and replace icon button (`assets/icons/controls/icon_replace_arrows.svg`).

- **Scenario 4: Start Workout Pill CTA**
  - **Given** the bottom of the screen,
  - **When** viewed,
  - **Then** a floating white pill button labeled "Empezar Entrenamiento" MUST navigate to `/training/active-workout`.

---

### REQ-TR-03: Active Workout Guider ("Empezar Entrenamiento")
The application MUST provide a guided live workout runner.

- **Scenario 1: Top Carousel & Live Timer**
  - **Given** an active workout session,
  - **When** `ActiveWorkoutPage` is open,
  - **Then** it MUST display an elapsed timer (`M:SS`), a "Terminar" button, and a horizontal circular carousel of exercises with a white indicator ring for the active exercise.

- **Scenario 2: Center Stage Dynamic Athlete Render**
  - **Given** the selected exercise in the carousel,
  - **When** the center stage renders,
  - **Then** it MUST display the authentic animated GIF of the active exercise via `SymmetryExtendedImage`, with a floating blue Symmetry Intelligence ("S") assistant button.

- **Scenario 3: Action Buttons**
  - **Given** the control bar beneath the title,
  - **When** rendered,
  - **Then** it MUST show "Tutorial", "Reemplazar", and "Notas" action pills.

- **Scenario 4: Interactive Set Table**
  - **Given** previous performance facts,
  - **When** logging sets,
  - **Then** the table MUST display PREVIA, KG, REPES, and a circular check button that marks the set complete and triggers the rest timer.
