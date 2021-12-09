import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String message;
  final String author;
  final DateTime messageDate;
  final bool isRead;
  final bool isMine;

  const ChatMessage({
    required this.message,
    required this.author,
    required this.messageDate,
    required this.isRead,
    required this.isMine,
  });

  @override
  List<Object> get props => [message, author, messageDate, isRead, isMine];

}
