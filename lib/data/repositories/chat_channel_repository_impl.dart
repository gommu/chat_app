import 'package:chat_app/core/errors/exceptions.dart';
import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/data/datasources/chat_channel_ws_datasource.dart';
import 'package:chat_app/domain/entities/chat_channel.dart';
import 'package:chat_app/domain/repositories/chat_channel_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/core/network/network_info.dart';

class ChatChannelRepositoryImpl implements ChatChannelRepository {
  final ChatChannelWsDatasource chatChannelWsDatasource;
  final NetworkInfo networkInfo;

  ChatChannelRepositoryImpl({
    required this.chatChannelWsDatasource,
    required this.networkInfo,
  });


  @override
  Future<Either <Failure, ChatChannel>> getChatChannel(String url) async {
    if (await networkInfo.isConnected) {
      try {
        final chatChannel = chatChannelWsDatasource.getChatChannel(url);
        return Right(chatChannel);
      } on WsException {
        return Left(WsFailure());
      }
    } else {
      return Left(WsFailure());
    }
  }
}