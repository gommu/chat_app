import 'package:chat_app/domain/entities/chat_message.dart';
import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String name;
  final String channelUrl;
  final List<ChatMessage> messageHistory;

  const Chat({
    required this.name,
    required this.messageHistory,
    required this.channelUrl,
  });

  @override
  List<Object> get props => [name, messageHistory, channelUrl];
}
