import 'package:chat_app/domain/entities/chat_message.dart';
import 'package:equatable/equatable.dart';

class ChatPreview extends Equatable {
  final String name;
  final ChatMessage lastMessage;
  final int unreadMessagesAmount;

  const ChatPreview({
    required this.name,
    required this.lastMessage,
    required this.unreadMessagesAmount,
  });

  @override
  List<Object> get props => [name, lastMessage, unreadMessagesAmount];

}
