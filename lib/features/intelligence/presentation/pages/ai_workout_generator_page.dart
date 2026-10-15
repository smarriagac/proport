import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:proport/core/constants/app_constants.dart';
import 'package:proport/features/training/domain/entities/training_session.dart';
import 'package:proport/features/training/presentation/bloc/training_bloc.dart';
import 'package:proport/features/training/presentation/bloc/training_event.dart';
import '../bloc/intelligence_bloc.dart';
import '../bloc/intelligence_event.dart';
import '../bloc/intelligence_state.dart';
import '../widgets/ai_recommendation_card.dart';
import '../widgets/muscle_focus_selector.dart';

class AIWorkoutGeneratorPage extends StatefulWidget {
  const AIWorkoutGeneratorPage({super.key});

  @override
  State<AIWorkoutGeneratorPage> createState() => _AIWorkoutGeneratorPageState();
}

class _AIWorkoutGeneratorPageState extends State<AIWorkoutGeneratorPage> {
  final List<String> _selectedMuscles = ['Chest', 'Arms'];
  String _selectedEquipment = 'Full Gym';
  String _selectedGoal = 'Hypertrophy';
  int _selectedDuration = 45;

  final List<String> _equipmentOptions = [
    'Full Gym',
    'Dumbbells Only',
    'Bodyweight',
  ];

  final List<String> _goalOptions = [
    'Hypertrophy',
    'Strength',
    'Conditioning',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Workout Generator'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<IntelligenceBloc, IntelligenceState>(
        listener: (context, state) {},
        builder: (context, state) {
          final isGenerating = state.maybeWhen(
            loaded: (_, __, isGen, ___) => isGen,
            orElse: () => false,
          );

          final recommendation = state.maybeWhen(
            loaded: (_, __, ___, rec) => rec,
            orElse: () => null,
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Header description
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E293B), Color(0xFF18181B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.psychology_rounded,
                      size: 32,
                      color: AppColors.accentBlue,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Smart Load Calibration',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Symmetry calculates your mechanical volume requirements based on real biomechanical tables.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 1. Muscle Focus
              _sectionHeader('1. TARGET MUSCLE FOCUS'),
              const SizedBox(height: 10),
              MuscleFocusSelector(
                selectedMuscles: _selectedMuscles,
                onToggle: (muscle) {
                  setState(() {
                    if (_selectedMuscles.contains(muscle)) {
                      if (_selectedMuscles.length > 1) {
                        _selectedMuscles.remove(muscle);
                      }
                    } else {
                      _selectedMuscles.add(muscle);
                    }
                  });
                },
              ),
              const SizedBox(height: 24),

              // 2. Equipment
              _sectionHeader('2. AVAILABLE EQUIPMENT'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: _equipmentOptions.map((eq) {
                  final isSelected = _selectedEquipment == eq;
                  return ChoiceChip(
                    selected: isSelected,
                    label: Text(eq),
                    backgroundColor: AppColors.surface,
                    selectedColor: AppColors.primaryBlue,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    side: BorderSide(
                      color: isSelected ? AppColors.primaryBlue : AppColors.cardBorder,
                    ),
                    onSelected: (_) {
                      setState(() => _selectedEquipment = eq);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // 3. Goal
              _sectionHeader('3. TRAINING FOCUS'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: _goalOptions.map((goal) {
                  final isSelected = _selectedGoal == goal;
                  return ChoiceChip(
                    selected: isSelected,
                    label: Text(goal),
                    backgroundColor: AppColors.surface,
                    selectedColor: AppColors.primaryBlue,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    side: BorderSide(
                      color: isSelected ? AppColors.primaryBlue : AppColors.cardBorder,
                    ),
                    onSelected: (_) {
                      setState(() => _selectedGoal = goal);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // 4. Duration
              _sectionHeader('4. DURATION: $_selectedDuration MINUTES'),
              const SizedBox(height: 6),
              Slider(
                value: _selectedDuration.toDouble(),
                min: 20,
                max: 75,
                divisions: 11,
                activeColor: AppColors.primaryBlue,
                inactiveColor: AppColors.cardBorder,
                label: '$_selectedDuration min',
                onChanged: (val) {
                  setState(() => _selectedDuration = val.round());
                },
              ),
              const SizedBox(height: 20),

              // Generate Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: isGenerating
                      ? null
                      : () {
                          context.read<IntelligenceBloc>().add(
                                GenerateAIWorkoutEvent(
                                  muscleFocus: _selectedMuscles,
                                  equipment: _selectedEquipment,
                                  durationMinutes: _selectedDuration,
                                  goal: _selectedGoal,
                                ),
                              );
                        },
                  icon: isGenerating
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.auto_awesome),
                  label: Text(
                    isGenerating ? 'Synthesizing Regimen...' : 'Generate AI Workout',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                ),
              ),

              // Generated result preview
              if (recommendation != null) ...[
                const SizedBox(height: 28),
                AIRecommendationCard(
                  recommendation: recommendation,
                  onStartWorkout: () {
                    final session = TrainingSession(
                      dayOfWeek: 1,
                      name: recommendation.title,
                      description: recommendation.rationale,
                      exercises: recommendation.exercises,
                      durationMinutes: recommendation.estimatedDuration,
                    );
                    context
                        .read<TrainingBloc>()
                        .add(StartWorkoutSessionEvent(session));
                    context.push('/training/active-workout');
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: AppColors.textMuted,
        letterSpacing: 1.0,
      ),
    );
  }
}
