import 'package:chat_app/core/errors/exceptions.dart';
import 'package:chat_app/data/models/chat_channel_model.dart';
import 'package:chat_app/domain/entities/chat_channel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class ChatChannelWsDatasource {
  ChatChannel getChatChannel(String url);
}

class ChatChannelWsDatasourceImpl implements ChatChannelWsDatasource {

  ChatChannelWsDatasourceImpl();

  @override
  ChatChannel getChatChannel(String url) {
    // WS url
    try {
      final channel = WebSocketChannel.connect(Uri.parse(url));
      final chatChannelModel = ChatChannelModel(channel);
      return chatChannelModel.toModel();
    } on WebSocketChannelException {
      throw WsException();
    }
  }
}