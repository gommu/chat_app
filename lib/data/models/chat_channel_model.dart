import 'package:chat_app/domain/entities/chat_channel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class ChatChannelModel {
  final WebSocketChannel channel;
  const ChatChannelModel(this.channel);
}

extension ChatChannelMapper on ChatChannelModel {
  ChatChannel toModel() {
    return ChatChannel(channel: channel);
  }
}