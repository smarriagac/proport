import '../entities/chat_message.dart';
import '../repositories/intelligence_repository.dart';

class SendChatMessageUseCase {
  final IntelligenceRepository repository;

  SendChatMessageUseCase(this.repository);

  Future<ChatMessage> call(String prompt) async {
    return await repository.sendChatMessage(prompt);
  }

  Future<List<ChatMessage>> getHistory() async {
    return await repository.getChatHistory();
  }
}
