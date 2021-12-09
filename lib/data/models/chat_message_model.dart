import 'package:chat_app/domain/entities/chat_message.dart';

// class ChatMessageModel extends ChatMessage {
class ChatMessageModel {
  final String message;
  final String author;
  final DateTime messageDate;
  final bool isRead;
  final bool isMine;

  const ChatMessageModel({
    required this.message,
    required this.author,
    required this.messageDate,
    required this.isRead,
    required this.isMine,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      message: json['message'],
      author: json['author'],
      messageDate: DateTime.now(),
      // messageDate: json['messageDate'],
      isRead: json['isRead'],
      isMine: json['isMine'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'author': author,
      'messageDate': messageDate,
      'isRead': isRead,
      'isMine': isMine,
    };
  }
}

extension ChatMessageMapper on ChatMessageModel {
  ChatMessage toModel() {
    return ChatMessage(
      message: message,
      author: author,
      messageDate: messageDate,
      isRead: isRead,
      isMine: isMine,
    );
  }
}
