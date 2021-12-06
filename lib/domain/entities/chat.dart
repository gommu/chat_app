import 'package:chat_app/domain/entities/chat_message.dart';
import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String name;
  final List<ChatMessage> messageHistory;

  const Chat(this.name, this.messageHistory);

  @override
  List<Object> get props => [name, messageHistory];
}
