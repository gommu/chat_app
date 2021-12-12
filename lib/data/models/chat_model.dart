import 'package:chat_app/domain/entities/chat.dart';

import 'chat_message_model.dart';

class ChatModel {
  final String name;
  final String channelUrl;
  final List<ChatMessageModel> messageHistory;

  ChatModel({
    required this.name,
    required this.channelUrl,
    required this.messageHistory,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final chatMessagesJson = json['messageHistory'];
    final List<ChatMessageModel> chatMessages = List<ChatMessageModel>.from(
        chatMessagesJson.map((model) => ChatMessageModel.fromJson(model)));

    return ChatModel(
      name: json['name'],
      channelUrl: json['channelUrl'],
      messageHistory: chatMessages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'channelUrl': channelUrl,
      'messageHistory': messageHistory.map((e) => e.toJson()).toList(),
    };
  }
}

extension ChatMapper on ChatModel {
  Chat toModel() {
    return Chat(
      name: name,
      channelUrl: channelUrl,
      messageHistory: messageHistory.map((e) => e.toModel()).toList()
    );
  }
}
