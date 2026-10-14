import '../../domain/entities/ai_workout_recommendation.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/intelligence_repository.dart';
import '../datasources/intelligence_local_data_source.dart';

class IntelligenceRepositoryImpl implements IntelligenceRepository {
  final IntelligenceLocalDataSource localDataSource;

  IntelligenceRepositoryImpl(this.localDataSource);

  @override
  Future<List<ChatMessage>> getChatHistory() async {
    final models = await localDataSource.getChatHistory();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<ChatMessage> sendChatMessage(String prompt) async {
    final model = await localDataSource.sendChatMessage(prompt);
    return model.toDomain();
  }

  @override
  Future<AIWorkoutRecommendation> generateWorkout({
    required List<String> muscleFocus,
    required String equipment,
    required int durationMinutes,
    required String goal,
  }) async {
    final model = await localDataSource.generateWorkout(
      muscleFocus: muscleFocus,
      equipment: equipment,
      durationMinutes: durationMinutes,
      goal: goal,
    );
    return model.toDomain();
  }
}
