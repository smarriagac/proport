import '../models/chat_message_model.dart';
import '../models/ai_workout_recommendation_model.dart';
import 'package:proport/features/training/data/models/exercise_model.dart';
import 'package:proport/features/training/data/models/exercise_set_model.dart';

abstract class IntelligenceLocalDataSource {
  Future<List<ChatMessageModel>> getChatHistory();
  Future<ChatMessageModel> sendChatMessage(String prompt);
  Future<AIWorkoutRecommendationModel> generateWorkout({
    required List<String> muscleFocus,
    required String equipment,
    required int durationMinutes,
    required String goal,
  });
}

class IntelligenceLocalDataSourceImpl implements IntelligenceLocalDataSource {
  final List<ChatMessageModel> _chatHistory = [
    ChatMessageModel(
      id: 'msg_welcome',
      sender: 'assistant',
      content:
          'Welcome to Proport AI Coach. I analyze your training volume, balance, and progressive overload in real time.\n\nAsk me anything about exercise technique, plateau breaking, recovery, or let me design your next workout!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      suggestions: const [
        'How do I break a bench press plateau?',
        'What is optimal rest between hypertrophy sets?',
        'Generate a 40-minute shoulder workout',
      ],
    ),
  ];

  @override
  Future<List<ChatMessageModel>> getChatHistory() async {
    return List.unmodifiable(_chatHistory);
  }

  @override
  Future<ChatMessageModel> sendChatMessage(String prompt) async {
    final userMsg = ChatMessageModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      sender: 'user',
      content: prompt,
      timestamp: DateTime.now(),
    );
    _chatHistory.add(userMsg);

    // AI Coaching Engine Response
    final reply = _generateCoachingResponse(prompt);
    final botMsg = ChatMessageModel(
      id: 'bot_${DateTime.now().millisecondsSinceEpoch}',
      sender: 'assistant',
      content: reply.content,
      timestamp: DateTime.now(),
      suggestions: reply.suggestions,
    );
    _chatHistory.add(botMsg);

    return botMsg;
  }

  @override
  Future<AIWorkoutRecommendationModel> generateWorkout({
    required List<String> muscleFocus,
    required String equipment,
    required int durationMinutes,
    required String goal,
  }) async {
    // Generate tailored exercises based on focus
    final exercises = _buildTailoredExercises(muscleFocus, equipment);

    final title = muscleFocus.isEmpty
        ? 'Full Body Adaptive Hypertrophy'
        : '${muscleFocus.join(" & ")} High-Output Blast';

    return AIWorkoutRecommendationModel(
      id: 'rec_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      targetMuscles: muscleFocus.isNotEmpty ? muscleFocus : const ['Full Body'],
      difficulty: goal.toLowerCase().contains('strength') ? 'Advanced' : 'Intermediate',
      estimatedDuration: durationMinutes,
      intensityScore: durationMinutes > 40 ? 9 : 8,
      rationale:
          'Calibrated for $goal with $equipment equipment. Prioritizes compound stimulus followed by isolated fatigue targeting the motor units in ${muscleFocus.join(", ")}.',
      tips: [
        'Maintain a 2-second eccentric phase on every repetition.',
        'Keep RPE at 8-9 for working sets; avoid failure on the first set.',
        'Hydrate with electrolytes before starting set #3.',
      ],
      exercises: exercises,
    );
  }

  _CoachingReply _generateCoachingResponse(String query) {
    final lower = query.toLowerCase();

    if (lower.contains('plateau') || lower.contains('stuck')) {
      return const _CoachingReply(
        content:
            'To shatter a plateau, apply wave loading or a micro-deload:\n\n1. **Reduce load by 10%** for 1 week to dissipate accumulated systemic fatigue.\n2. **Increase frequency** from 1x to 2x weekly with split volume.\n3. **Address sticking points** with paused reps or tempo variations (e.g., 3-second pause at chest level).',
        suggestions: [
          'How does a deload week work?',
          'What is RPE and RIR?',
        ],
      );
    } else if (lower.contains('rest') || lower.contains('timer')) {
      return const _CoachingReply(
        content:
            'For mechanical tension & hypertrophy:\n\n• **Compound lifts** (Squat, Bench, Deadlift): **2.5 to 3 minutes** allows full ATP resynthesis for maximal recruitment.\n• **Isolation lifts** (Curls, Laterals): **60 to 90 seconds** provides adequate metabolic stress without sacrificing mechanical output.',
        suggestions: [
          'Should I train to failure every set?',
          'Optimize my training split',
        ],
      );
    } else if (lower.contains('protein') || lower.contains('nutrition') || lower.contains('diet')) {
      return const _CoachingReply(
        content:
            'Target **1.6 to 2.2 grams of protein per kilogram of bodyweight** daily, divided across 3-4 meals containing at least 2.5g leucine each for optimal muscle protein synthesis (MPS) spikes.',
        suggestions: [
          'Pre-workout nutrition tips',
          'Creatine monohydrate dosage',
        ],
      );
    } else {
      return const _CoachingReply(
        content:
            'Analysis complete. Your current training volume indicates optimal muscle stimulation. Prioritize progressive overload (adding 1 rep or 1.25kg) each session to ensure continued structural adaptation.',
        suggestions: [
          'Generate a chest workout',
          'Check my symmetry score',
          'How to optimize sleep for recovery',
        ],
      );
    }
  }

  List<ExerciseModel> _buildTailoredExercises(List<String> muscles, String equipment) {
    final list = <ExerciseModel>[];

    final hasChest = muscles.any((m) => m.toLowerCase().contains('chest') || m.toLowerCase().contains('push'));
    final hasBack = muscles.any((m) => m.toLowerCase().contains('back') || m.toLowerCase().contains('pull'));
    final hasLegs = muscles.any((m) => m.toLowerCase().contains('leg') || m.toLowerCase().contains('quad'));
    final hasArms = muscles.any((m) => m.toLowerCase().contains('arm') || m.toLowerCase().contains('bicep') || m.toLowerCase().contains('tricep'));
    final hasShoulders = muscles.any((m) => m.toLowerCase().contains('shoulder'));

    if (hasChest || muscles.isEmpty) {
      list.add(
        ExerciseModel(
          exerciseTemplateId: 740,
          name: equipment == 'Bodyweight' ? 'Deficit Push Up' : 'Dumbbell Incline Press',
          muscleGroup: 'Chest',
          note: 'Full stretch at bottom, explosive concentric drive.',
          sets: const [
            ExerciseSetModel(setNumber: 1, reps: 10, weightKg: 28, restSeconds: 90),
            ExerciseSetModel(setNumber: 2, reps: 10, weightKg: 28, restSeconds: 90),
            ExerciseSetModel(setNumber: 3, reps: 8, weightKg: 30, restSeconds: 120),
          ],
        ),
      );
    }

    if (hasBack || muscles.isEmpty) {
      list.add(
        ExerciseModel(
          exerciseTemplateId: 1901,
          name: equipment == 'Bodyweight' ? 'Inverted Australian Row' : 'Single-Arm Dumbbell Row',
          muscleGroup: 'Back',
          note: 'Drive the elbow towards the hip pocket; squeeze lat at peak.',
          sets: const [
            ExerciseSetModel(setNumber: 1, reps: 10, weightKg: 26, restSeconds: 90),
            ExerciseSetModel(setNumber: 2, reps: 10, weightKg: 26, restSeconds: 90),
            ExerciseSetModel(setNumber: 3, reps: 10, weightKg: 28, restSeconds: 90),
          ],
        ),
      );
    }

    if (hasShoulders) {
      list.add(
        const ExerciseModel(
          exerciseTemplateId: 1834,
          name: 'Seated Dumbbell Overhead Press',
          muscleGroup: 'Shoulders',
          note: 'Elbows slightly tucked in the scapular plane.',
          sets: [
            ExerciseSetModel(setNumber: 1, reps: 12, weightKg: 18, restSeconds: 90),
            ExerciseSetModel(setNumber: 2, reps: 10, weightKg: 20, restSeconds: 90),
            ExerciseSetModel(setNumber: 3, reps: 8, weightKg: 22, restSeconds: 90),
          ],
        ),
      );
    }

    if (hasLegs || muscles.isEmpty) {
      list.add(
        const ExerciseModel(
          exerciseTemplateId: 1,
          name: 'Barbell High Bar Squat',
          muscleGroup: 'Quads',
          note: 'Hit parallel depth with knees tracking over toes.',
          sets: [
            ExerciseSetModel(setNumber: 1, reps: 8, weightKg: 80, restSeconds: 120),
            ExerciseSetModel(setNumber: 2, reps: 8, weightKg: 80, restSeconds: 120),
            ExerciseSetModel(setNumber: 3, reps: 6, weightKg: 85, restSeconds: 120),
          ],
        ),
      );
    }

    if (hasArms) {
      list.add(
        const ExerciseModel(
          exerciseTemplateId: 25,
          name: 'Dumbbell Hammer Curl',
          muscleGroup: 'Arms',
          note: 'Neutral grip; builds brachialis and forearm thickness.',
          sets: [
            ExerciseSetModel(setNumber: 1, reps: 12, weightKg: 14, restSeconds: 60),
            ExerciseSetModel(setNumber: 2, reps: 12, weightKg: 14, restSeconds: 60),
            ExerciseSetModel(setNumber: 3, reps: 10, weightKg: 16, restSeconds: 60),
          ],
        ),
      );
      list.add(
        const ExerciseModel(
          exerciseTemplateId: 27,
          name: 'Rope Cable Overhead Triceps Extension',
          muscleGroup: 'Arms',
          note: 'Full stretch on long head of the triceps.',
          sets: [
            ExerciseSetModel(setNumber: 1, reps: 12, weightKg: 20, restSeconds: 60),
            ExerciseSetModel(setNumber: 2, reps: 12, weightKg: 20, restSeconds: 60),
          ],
        ),
      );
    }

    return list;
  }
}

class _CoachingReply {
  final String content;
  final List<String> suggestions;

  const _CoachingReply({
    required this.content,
    required this.suggestions,
  });
}
