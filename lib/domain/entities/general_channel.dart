import 'package:equatable/equatable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GeneralChannel extends Equatable {
  final WebSocketChannel channel;

  const GeneralChannel(this.channel);

  @override
  List<Object> get props => [channel];
}