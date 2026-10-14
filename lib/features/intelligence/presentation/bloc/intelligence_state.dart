import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/ai_workout_recommendation.dart';

part 'intelligence_state.freezed.dart';

@freezed
class IntelligenceState with _$IntelligenceState {
  const factory IntelligenceState.initial() = _Initial;
  const factory IntelligenceState.loading() = _Loading;
  const factory IntelligenceState.loaded({
    @Default([]) List<ChatMessage> messages,
    @Default(false) bool isSendingMessage,
    @Default(false) bool isGeneratingWorkout,
    AIWorkoutRecommendation? generatedRecommendation,
  }) = _Loaded;
  const factory IntelligenceState.error(String message) = _Error;
}
