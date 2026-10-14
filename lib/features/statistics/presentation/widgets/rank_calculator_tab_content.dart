import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

/// Authentic Symmetry Rank Calculator View
/// Matching the exact visual specifications from the decompiled app and device screenshots.
class RankCalculatorTabContent extends StatelessWidget {
  const RankCalculatorTabContent({super.key});

  void _openCalculatorWizard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _RankCalculatorWizardSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - 32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),

                // 1. Hero 3D Badges Illustration
                Center(
                  child: Image.asset(
                    AppAssets.symmetryCalculatorHeroBadges,
                    width: 290,
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 40),

                // 2. Main Sales Pitch Title
                const Text(
                  'Descubre tu rango en 20\nsegundos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTheme.fontAlbert,
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    letterSpacing: -0.6,
                    height: 1.15,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 18),

                // 3. Subtitle / Disclaimer
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Dinos tu mejor serie en un ejercicio y te damos una estimación.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppTheme.fontDM,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.35,
                      color: Color(0xFF8E8E93),
                    ),
                  ),
                ),

                const SizedBox(height: 38),

                // 4. White Rounded CTA Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => _openCalculatorWizard(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Calcula tu rango',
                      style: TextStyle(
                        fontFamily: AppTheme.fontAlbert,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RankCalculatorWizardSheet extends StatefulWidget {
  const _RankCalculatorWizardSheet();

  @override
  State<_RankCalculatorWizardSheet> createState() =>
      _RankCalculatorWizardSheetState();
}

class _RankCalculatorWizardSheetState
    extends State<_RankCalculatorWizardSheet> {
  int _currentStep = 0; // 0: Select Exercise, 1: Enter Set, 2: Reveal
  String _selectedExercise = 'Press de banca plano';
  double _weightKg = 80.0;
  int _reps = 8;

  final List<_ExerciseOption> _exercises = const [
    _ExerciseOption(
      name: 'Press de banca plano',
      muscle: 'Pecho',
      icon: Icons.fitness_center_rounded,
    ),
    _ExerciseOption(
      name: 'Sentadilla con barra',
      muscle: 'Piernas',
      icon: Icons.accessibility_new_rounded,
    ),
    _ExerciseOption(
      name: 'Peso muerto convencional',
      muscle: 'Espalda',
      icon: Icons.sports_gymnastics_rounded,
    ),
    _ExerciseOption(
      name: 'Press militar con barra',
      muscle: 'Hombros',
      icon: Icons.airline_stops_rounded,
    ),
    _ExerciseOption(
      name: 'Dominadas pronadas',
      muscle: 'Espalda',
      icon: Icons.vertical_align_top_rounded,
    ),
    _ExerciseOption(
      name: 'Fondos en paralelas',
      muscle: 'Brazos / Pecho',
      icon: Icons.height_rounded,
    ),
  ];

  double get _estimated1RM => _weightKg * (1 + _reps / 30.0);

  _RankResult get _rankResult {
    final orm = _estimated1RM;
    if (_selectedExercise.contains('banca')) {
      if (orm >= 130) {
        return const _RankResult(
          title: 'DIAMANTE I',
          tier: 'Diamante',
          percentile: 'top 5% más fuerte',
          color: Color(0xFF5AC8FA),
        );
      } else if (orm >= 100) {
        return const _RankResult(
          title: 'ORO III',
          tier: 'Oro',
          percentile: 'top 20% más fuerte',
          color: Color(0xFFF5A623),
        );
      } else if (orm >= 80) {
        return const _RankResult(
          title: 'ORO I',
          tier: 'Oro',
          percentile: 'top 35% más fuerte',
          color: Color(0xFFF5A623),
        );
      } else {
        return const _RankResult(
          title: 'PLATA II',
          tier: 'Plata',
          percentile: 'top 60% más fuerte',
          color: Color(0xFFD1D1D6),
        );
      }
    } else {
      if (orm >= 160) {
        return const _RankResult(
          title: 'DIAMANTE I',
          tier: 'Diamante',
          percentile: 'top 5% más fuerte',
          color: Color(0xFF5AC8FA),
        );
      } else if (orm >= 120) {
        return const _RankResult(
          title: 'ORO III',
          tier: 'Oro',
          percentile: 'top 25% más fuerte',
          color: Color(0xFFF5A623),
        );
      } else {
        return const _RankResult(
          title: 'PLATA III',
          tier: 'Plata',
          percentile: 'top 55% más fuerte',
          color: Color(0xFFD1D1D6),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF141416),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3C),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),

            // Top Header: Step & Close
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep > 0 && _currentStep < 2)
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          color: Colors.white, size: 18),
                      onPressed: () => setState(() => _currentStep--),
                    )
                  else
                    const SizedBox(width: 40),
                  Text(
                    _currentStep == 0
                        ? 'Elige un ejercicio'
                        : _currentStep == 1
                            ? 'Dinos tu mejor serie'
                            : 'Resultado',
                    style: const TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: Color(0xFF8E8E93), size: 22),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF26262B), height: 16),

            if (_currentStep == 0) _buildExerciseSelectorStep(),
            if (_currentStep == 1) _buildSetInputStep(),
            if (_currentStep == 2) _buildRevealStep(),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseSelectorStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: _exercises.map((opt) {
          final isSelected = _selectedExercise == opt.name;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedExercise = opt.name;
                  _currentStep = 1;
                });
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF222226)
                      : const Color(0xFF1A1A1D),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryBlue
                        : const Color(0xFF26262B),
                    width: isSelected ? 1.4 : 0.8,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(opt.icon, color: Colors.white, size: 22),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            opt.name,
                            style: const TextStyle(
                              fontFamily: AppTheme.fontAlbert,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            opt.muscle,
                            style: const TextStyle(
                              fontFamily: AppTheme.fontDM,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xFF8E8E93),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF8E8E93),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSetInputStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          // Selected exercise chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF222226),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _selectedExercise,
              style: const TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Weight Input
          _buildStepperField(
            label: 'PESO',
            value: '${_weightKg.toStringAsFixed(1)} kg',
            onDecrement: () {
              if (_weightKg > 5) {
                setState(() => _weightKg -= 2.5);
              }
            },
            onIncrement: () {
              setState(() => _weightKg += 2.5);
            },
          ),
          const SizedBox(height: 16),

          // Reps Input
          _buildStepperField(
            label: 'REPETICIONES',
            value: '$_reps Reps',
            onDecrement: () {
              if (_reps > 1) {
                setState(() => _reps--);
              }
            },
            onIncrement: () {
              setState(() => _reps++);
            },
          ),
          const SizedBox(height: 28),

          // Submit CTA
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () => setState(() => _currentStep = 2),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
              child: const Text(
                'Obtener mi rango',
                style: TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperField({
    required String label,
    required String value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF26262B)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: AppTheme.fontAlbert,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 0.8,
                    color: Color(0xFF8E8E93),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: AppTheme.fontMono,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Stepper Buttons
          IconButton(
            onPressed: onDecrement,
            icon: const Icon(Icons.remove_circle_outline_rounded,
                color: Colors.white, size: 28),
          ),
          IconButton(
            onPressed: onIncrement,
            icon: const Icon(Icons.add_circle_outline_rounded,
                color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildRevealStep() {
    final result = _rankResult;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          // Estimated Rank Tag Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF26262B),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'RANGO ESTIMADO',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w800,
                fontSize: 11,
                letterSpacing: 0.8,
                color: Color(0xFFF5A623),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Badge Image
          Image.asset(
            AppAssets.symmetryGold3WingsBadge,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 14),

          // Rank Title
          Text(
            result.title,
            style: TextStyle(
              fontFamily: AppTheme.fontAlbert,
              fontWeight: FontWeight.w900,
              fontSize: 32,
              color: result.color,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),

          // Percentile
          Text(
            'Eres parte del ${result.percentile}',
            style: const TextStyle(
              fontFamily: AppTheme.fontDM,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),

          // 1RM Stat
          Text(
            '1RM estimado: ${_estimated1RM.toStringAsFixed(1)} kg (${_weightKg}kg × $_reps reps)',
            style: const TextStyle(
              fontFamily: AppTheme.fontMono,
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color(0xFF8E8E93),
            ),
          ),
          const SizedBox(height: 20),

          // Disclaimer
          const Text(
            'Es una estimación. Tu rango oficial se gana entrenando.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTheme.fontDM,
              fontSize: 12,
              color: Color(0xFF63636E),
            ),
          ),
          const SizedBox(height: 24),

          // CTA: Comenzar a entrenar
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go('/train');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
              child: const Text(
                'Comenzar a entrenar',
                style: TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Secondary: Calcular otra estimación
          TextButton(
            onPressed: () => setState(() => _currentStep = 0),
            child: const Text(
              'Calcular otra estimación',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(0xFF8E8E93),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseOption {
  final String name;
  final String muscle;
  final IconData icon;

  const _ExerciseOption({
    required this.name,
    required this.muscle,
    required this.icon,
  });
}

class _RankResult {
  final String title;
  final String tier;
  final String percentile;
  final Color color;

  const _RankResult({
    required this.title,
    required this.tier,
    required this.percentile,
    required this.color,
  });
}
