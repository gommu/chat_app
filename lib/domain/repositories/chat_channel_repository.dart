import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/domain/entities/chat_channel.dart';
import 'package:dartz/dartz.dart';

abstract class ChatChannelRepository {
  Future<Either <Failure, ChatChannel>> getChatChannel(String url);
}