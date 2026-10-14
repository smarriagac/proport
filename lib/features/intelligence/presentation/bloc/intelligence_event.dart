import 'package:equatable/equatable.dart';

abstract class IntelligenceEvent extends Equatable {
  const IntelligenceEvent();

  @override
  List<Object?> get props => [];
}

class LoadChatHistoryEvent extends IntelligenceEvent {
  const LoadChatHistoryEvent();
}

class SendChatMessageEvent extends IntelligenceEvent {
  final String prompt;
  const SendChatMessageEvent(this.prompt);

  @override
  List<Object?> get props => [prompt];
}

class GenerateAIWorkoutEvent extends IntelligenceEvent {
  final List<String> muscleFocus;
  final String equipment;
  final int durationMinutes;
  final String goal;

  const GenerateAIWorkoutEvent({
    required this.muscleFocus,
    required this.equipment,
    required this.durationMinutes,
    required this.goal,
  });

  @override
  List<Object?> get props => [muscleFocus, equipment, durationMinutes, goal];
}

class ClearRecommendationEvent extends IntelligenceEvent {
  const ClearRecommendationEvent();
}
