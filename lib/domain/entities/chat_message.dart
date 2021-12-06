import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String message;
  final String author;
  final DateTime messageDate;
  final bool isRead;

  const ChatMessage({
    required this.message,
    required this.author,
    required this.messageDate,
    required this.isRead,
  });

  @override
  List<Object> get props => [message, author, messageDate, isRead];

}
