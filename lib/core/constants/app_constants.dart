import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Pure dark Gym Tech Palette - Authentic Symmetry Decompiled Values
  static const Color background = Color(0xFF09090A);
  static const Color surface = Color(0xFF141416);
  static const Color card = Color(0xFF1A1A1D);
  static const Color container = Color(0xFF1A1A1D);
  static const Color cardBorder = Color(0xFF26262B);
  static const Color cardHover = Color(0xFF222225);

  // Brand Accents
  static const Color primaryBlue = Color(0xFF3875FF);
  static const Color accentBlue = Color(0xFF4A84FF);
  static const Color flameOrange = Color(0xFFFF6A00);
  static const Color flameYellow = Color(0xFFFFB300);
  static const Color emeraldGreen = Color(0xFF00E599);

  // Authenticated Decompiled Aliases
  static const Color accentFlame = Color(0xFFFF7A00);
  static const Color accentGold = Color(0xFFFFB800);
  static const Color accentEmerald = Color(0xFF00E599);
  static const Color streakOrange = Color(0xFFFF6A00);

  // Feedback Colors
  static const Color success = Color(0xFF00E599);
  static const Color warning = Color(0xFFFFB300);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF4A84FF);

  // Typography
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9E9EA7);
  static const Color textMuted = Color(0xFF63636E);
  static const Color textDisabled = Color(0xFF404048);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, accentBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient streakGradient = LinearGradient(
    colors: [flameOrange, flameYellow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGlowGradient = LinearGradient(
    colors: [Color(0x333875FF), Color(0x00141416)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppAssets {
  AppAssets._();

  static const String logoSvg = 'assets/symmetry_logo.svg';
  static const String lettersLogoSvg = 'assets/symmetry_letters_logo.svg';
  static const String logoPng = 'assets/symmetry_logo.png';
  static const String androidLogoPng = 'assets/symmetry_android_logo.png';

  // Navigation Bar SVGs
  static const String navFriends = 'assets/icons/navigation_bar/redesign/friends.svg';
  static const String navHome = 'assets/icons/navigation_bar/home_icon.svg';
  static const String navRanks = 'assets/icons/navigation_bar/redesign/ranks.svg';
  static const String navTrain = 'assets/icons/navigation_bar/redesign/train.svg';
  static const String navFiveTabsTrain = 'assets/icons/navigation_bar/redesign/five_tabs_train.svg';
  static const String navLibrary = 'assets/icons/navigation_bar/redesign/library.svg';
  static const String navProfile = 'assets/icons/navigation_bar/profile_icon.svg';

  // Streak & Action SVGs
  static const String streakFlameLit = 'assets/icons/streak/flame_lit.svg';
  static const String streakFlameGrey = 'assets/icons/streak/flame_grey.svg';
  static const String notificationIcon = 'assets/icons/notification_icon.svg';

  // Library Icons
  static const String libraryExplorePrograms =
      'assets/icons/library/explore_programs.svg';
  static const String libraryCreateProgram =
      'assets/icons/library/create_program.svg';

  // Symmetry Authentic Ranking Assets
  static const String symmetryRankedBodyDiagram =
      'assets/icons/ranking/symmetry_ranked_body_diagram.png';
  static const String symmetryGold3WingsBadge =
      'assets/icons/ranking/symmetry_gold3_wings_badge.png';
  static const String symmetryMuscleHexBadge =
      'assets/icons/ranking/symmetry_muscle_hex_badge.png';
  static const String workoutBody0 = 'assets/icons/ranking/workout_body_0.png';
  static const String workoutBody1 = 'assets/icons/ranking/workout_body_1.png';
  static const String workoutBody2 = 'assets/icons/ranking/workout_body_2.png';
  static const String workoutBody3 = 'assets/icons/ranking/workout_body_3.png';
  static const String workoutBody4 = 'assets/icons/ranking/workout_body_4.png';
  static const String workoutBody5 = 'assets/icons/ranking/workout_body_5.png';
  static const String symmetryCalculatorHeroBadges =
      'assets/icons/ranking/symmetry_calculator_hero_badges.png';
  static const String workoutHeroCleanBg =
      'assets/images/workout_hero_clean_bg.png';
  static const String workoutHeroEmpujeCard =
      'assets/images/workout_hero_empuje_card.png';

  // Data Assets
  static const String exerciseCatalogJson =
      'assets/data/exercise_catalog.json';
  static const String predefinedPlansExampleJson =
      'assets/workout_plan_templates/predefined_workout_plans_v2_example.json';
  static const String predefinedPlansEnJson =
      'assets/workout_plan_templates/predefined_workout_plans_v2_en.json';
  static const String exerciseRankingMockJson =
      'assets/data/exercise_ranking_mock.json';
  static const String quickWorkoutsJson =
      'assets/quick_workouts/quick_workouts_en.json';

  // Key Icons
  static const String iconDumbbell = 'assets/icons/icon_dumbbell.svg';
  static const String iconTrain = 'assets/icons/icon_train.svg';
  static const String iconSparkles = 'assets/icons/icon_sparkles_outline.svg';
  static const String iconGraph = 'assets/icons/onboarding/chart.svg';
  static const String iconBodyScan = 'assets/icons/onboarding/physique_selected.svg';
  static const String iconStreak = 'assets/icons/icon_streak.svg';
  static const String iconClock = 'assets/icons/clock.svg';
  static const String iconCheck = 'assets/icons/icon_check.svg';
  static const String iconPlay = 'assets/icons/play_icon.svg';
  static const String iconCrown = 'assets/icons/crown_icon.svg';
  static const String iconSettings = 'assets/icons/gw_redesign_settings.svg';
  static const String iconAdd = 'assets/icons/icon_add.svg';
  static const String iconReplaceArrows =
      'assets/icons/controls/icon_replace_arrows.svg';

  // Muscle Distribution
  static const String muscleDistributionHombros =
      'assets/images/muscles/distribution_hombros.png';
  static const String muscleDistributionTriceps =
      'assets/images/muscles/distribution_triceps.png';
  static const String muscleDistributionPecho =
      'assets/images/muscles/distribution_pecho.png';

  // Authentic Symmetry Exercise Animated GIFs
  static const String gifTreadmill =
      'assets/images/exercises/treadmill.gif';
  static const String gifInclineBenchPress =
      'assets/images/exercises/incline_bench_press.gif';
  static const String gifFlatBenchPress =
      'assets/images/exercises/flat_bench_press.gif';
  static const String gifLowCableCrossover =
      'assets/images/exercises/low_cable_crossover.gif';
  static const String gifSeatedShoulderPress =
      'assets/images/exercises/seated_shoulder_press.gif';
  static const String gifStandingMilitaryPress =
      'assets/images/exercises/standing_military_press.gif';
  static const String gifLateralRaises =
      'assets/images/exercises/lateral_raises.gif';
  static const String gifTricepsPushdown =
      'assets/images/exercises/triceps_pushdown.gif';
  static const String gifBenchDips =
      'assets/images/exercises/bench_dips.gif';
  static const String gifLatPulldownPronated =
      'assets/images/exercises/lat_pulldown_pronated.gif';
  static const String gifLatPulldownSupinated =
      'assets/images/exercises/lat_pulldown_supinated.gif';
  static const String gifSeatedCableRow =
      'assets/images/exercises/seated_cable_row.gif';
  static const String gifBarbellRow =
      'assets/images/exercises/barbell_row.gif';
  static const String gifDumbbellRow =
      'assets/images/exercises/dumbbell_row.gif';
  static const String gifFacePull =
      'assets/images/exercises/face_pull.gif';
  static const String gifBicepCurl =
      'assets/images/exercises/bicep_curl.gif';

  // Authentic Symmetry Plan Covers
  static const String planPushPullLegs =
      'assets/images/plans/push_pull_legs_estetico.webp';
  static const String planFullBodyGym =
      'assets/images/plans/full_body_en_el_gym.webp';
  static const String planUpperLower =
      'assets/images/plans/upper_lower_de_fuerza.webp';
  static const String planEsteticaCorporal =
      'assets/images/plans/estetica_con_peso_corporal.webp';

  // Fallback Legacy Thumbnails (kept for compatibility)
  static const String exTreadmill = gifTreadmill;
  static const String exInclineBench = gifInclineBenchPress;
  static const String exCableCrossover = gifLowCableCrossover;
  static const String exShoulderPress = gifSeatedShoulderPress;
  static const String exLateralRaise = gifLateralRaises;
  static const String heroLatPulldown = gifLatPulldownPronated;
  static const String carouselLatPulldown = gifLatPulldownPronated;
  static const String carouselPulldownVar = gifLatPulldownSupinated;
  static const String carouselSeatedRow = gifSeatedCableRow;
  static const String rankDiamondBadge =
      'assets/icons/ranking/base/rank=diamond.svg';
}
