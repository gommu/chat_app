import 'package:chat_app/domain/entities/general_channel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class GeneralChannelModel {
  final WebSocketChannel channel;
  const GeneralChannelModel(this.channel);

}

extension GeneralChannelMapper on GeneralChannelModel {
  GeneralChannel toModel() {
    return GeneralChannel(channel);
  }
}