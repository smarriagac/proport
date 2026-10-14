import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/generate_ai_workout_usecase.dart';
import '../../domain/usecases/send_chat_message_usecase.dart';
import '../../domain/entities/chat_message.dart';
import 'intelligence_event.dart';
import 'intelligence_state.dart';

class IntelligenceBloc extends Bloc<IntelligenceEvent, IntelligenceState> {
  final GenerateAIWorkoutUseCase generateAIWorkoutUseCase;
  final SendChatMessageUseCase sendChatMessageUseCase;

  IntelligenceBloc({
    required this.generateAIWorkoutUseCase,
    required this.sendChatMessageUseCase,
  }) : super(const IntelligenceState.initial()) {
    on<LoadChatHistoryEvent>(_onLoadChatHistory);
    on<SendChatMessageEvent>(_onSendChatMessage);
    on<GenerateAIWorkoutEvent>(_onGenerateAIWorkout);
    on<ClearRecommendationEvent>(_onClearRecommendation);
  }

  Future<void> _onLoadChatHistory(
    LoadChatHistoryEvent event,
    Emitter<IntelligenceState> emit,
  ) async {
    emit(const IntelligenceState.loading());
    try {
      final history = await sendChatMessageUseCase.getHistory();
      emit(IntelligenceState.loaded(messages: history));
    } catch (e) {
      emit(IntelligenceState.error('Failed to load coach history: $e'));
    }
  }

  Future<void> _onSendChatMessage(
    SendChatMessageEvent event,
    Emitter<IntelligenceState> emit,
  ) async {
    await state.maybeWhen(
      loaded: (messages, _, isGenerating, rec) async {
        // Optimistically add user message
        final userMsg = ChatMessage(
          id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
          sender: 'user',
          content: event.prompt,
          timestamp: DateTime.now(),
        );

        final updatedList = List<ChatMessage>.from(messages)..add(userMsg);
        emit(IntelligenceState.loaded(
          messages: updatedList,
          isSendingMessage: true,
          isGeneratingWorkout: isGenerating,
          generatedRecommendation: rec,
        ));

        try {
          final reply = await sendChatMessageUseCase(event.prompt);
          final finalHistory = await sendChatMessageUseCase.getHistory();
          emit(IntelligenceState.loaded(
            messages: finalHistory.isNotEmpty ? finalHistory : (List<ChatMessage>.from(updatedList)..add(reply)),
            isSendingMessage: false,
            isGeneratingWorkout: isGenerating,
            generatedRecommendation: rec,
          ));
        } catch (e) {
          emit(IntelligenceState.loaded(
            messages: updatedList,
            isSendingMessage: false,
            isGeneratingWorkout: isGenerating,
            generatedRecommendation: rec,
          ));
        }
      },
      orElse: () async {},
    );
  }

  Future<void> _onGenerateAIWorkout(
    GenerateAIWorkoutEvent event,
    Emitter<IntelligenceState> emit,
  ) async {
    await state.maybeWhen(
      loaded: (messages, isSending, _, __) async {
        emit(IntelligenceState.loaded(
          messages: messages,
          isSendingMessage: isSending,
          isGeneratingWorkout: true,
          generatedRecommendation: null,
        ));

        try {
          final rec = await generateAIWorkoutUseCase(
            muscleFocus: event.muscleFocus,
            equipment: event.equipment,
            durationMinutes: event.durationMinutes,
            goal: event.goal,
          );
          emit(IntelligenceState.loaded(
            messages: messages,
            isSendingMessage: isSending,
            isGeneratingWorkout: false,
            generatedRecommendation: rec,
          ));
        } catch (e) {
          emit(IntelligenceState.error('Failed to generate workout: $e'));
        }
      },
      orElse: () async {},
    );
  }

  void _onClearRecommendation(
    ClearRecommendationEvent event,
    Emitter<IntelligenceState> emit,
  ) {
    state.maybeWhen(
      loaded: (messages, isSending, isGenerating, _) {
        emit(IntelligenceState.loaded(
          messages: messages,
          isSendingMessage: isSending,
          isGeneratingWorkout: isGenerating,
          generatedRecommendation: null,
        ));
      },
      orElse: () {},
    );
  }
}
