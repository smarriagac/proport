import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String id;
  final String sender; // 'user' or 'assistant'
  final String content;
  final DateTime timestamp;
  final List<String> suggestions;

  const ChatMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.suggestions = const [],
  });

  bool get isUser => sender == 'user';

  @override
  List<Object?> get props => [id, sender, content, timestamp, suggestions];
}
