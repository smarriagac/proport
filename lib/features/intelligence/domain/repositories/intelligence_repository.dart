import '../entities/ai_workout_recommendation.dart';
import '../entities/chat_message.dart';

abstract class IntelligenceRepository {
  Future<AIWorkoutRecommendation> generateWorkout({
    required List<String> muscleFocus,
    required String equipment,
    required int durationMinutes,
    required String goal,
  });

  Future<List<ChatMessage>> getChatHistory();
  Future<ChatMessage> sendChatMessage(String prompt);
}
