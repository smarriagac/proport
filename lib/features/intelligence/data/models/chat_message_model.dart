import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/chat_message.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@freezed
abstract class ChatMessageModel with _$ChatMessageModel {
  const ChatMessageModel._();

  const factory ChatMessageModel({
    required String id,
    required String sender,
    required String content,
    required DateTime timestamp,
    @Default([]) List<String> suggestions,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  ChatMessage toDomain() {
    return ChatMessage(
      id: id,
      sender: sender,
      content: content,
      timestamp: timestamp,
      suggestions: suggestions,
    );
  }

  factory ChatMessageModel.fromDomain(ChatMessage entity) {
    return ChatMessageModel(
      id: entity.id,
      sender: entity.sender,
      content: entity.content,
      timestamp: entity.timestamp,
      suggestions: entity.suggestions,
    );
  }
}
