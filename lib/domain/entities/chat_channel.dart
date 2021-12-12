import 'package:equatable/equatable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatChannel extends Equatable {
  final WebSocketChannel channel;

  const ChatChannel({required this.channel});

  @override
  List<Object> get props => [channel];
}