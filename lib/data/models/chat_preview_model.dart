import 'package:chat_app/domain/entities/chat_preview.dart';

import 'chat_message_model.dart';

class ChatPreviewModel {
  final String name;
  final int id;
  final ChatMessageModel lastMessage;
  final int unreadMessagesAmount;

  const ChatPreviewModel({
    required this.name,
    required this.id,
    required this.lastMessage,
    required this.unreadMessagesAmount,
  });

  factory ChatPreviewModel.fromJson(Map<String, dynamic> json) {
    ChatMessageModel message = ChatMessageModel.fromJson(json['lastMessage']);
    return ChatPreviewModel(
      name: json['name'],
      id: json['id'],
      lastMessage: message,
      unreadMessagesAmount: json['unreadMessagesAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'unreadMessagesAmount': unreadMessagesAmount,
      'lastMessage': lastMessage.toJson(),
    };
  }
}

extension ChatPreviewMapper on ChatPreviewModel {
  ChatPreview toModel() {
    return ChatPreview(
      name: name,
      id: id,
      unreadMessagesAmount: unreadMessagesAmount,
      lastMessage: lastMessage.toModel(),
    );
  }
}
