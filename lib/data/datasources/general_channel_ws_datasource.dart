import 'package:chat_app/core/errors/exceptions.dart';
import 'package:chat_app/data/models/general_channel_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class GeneralChannelWsDatasource {
  GeneralChannelModel getGeneralChannel();
}

class GeneralChannelWsDatasourceImpl implements GeneralChannelWsDatasource {
  GeneralChannelWsDatasourceImpl();

  @override
  GeneralChannelModel getGeneralChannel() {
    // WS url
    try {
      const wsUrl = 'ws://192.168.200.8:6001/ws/app/app-key/chat-events/?session=session';
      final channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      final generalChanelModel = GeneralChannelModel(channel);
      return generalChanelModel;
    } on WebSocketChannelException {
      throw WsException();
    }
  }
}