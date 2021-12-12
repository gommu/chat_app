import 'package:chat_app/core/errors/exceptions.dart';
import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/core/network/network_info.dart';
import 'package:chat_app/data/datasources/chat_remote_datasource.dart';
import 'package:chat_app/data/datasources/chats_list_local_datasource.dart';
import 'package:chat_app/data/datasources/chats_list_remote_datasource.dart';
import 'package:chat_app/domain/entities/chat.dart';
import 'package:chat_app/domain/entities/chat_preview.dart';
import 'package:chat_app/domain/repositories/chat_repository.dart';
import 'package:chat_app/domain/repositories/chats_list_repository.dart';
import 'package:chat_app/data/models/chat_preview_model.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/data/models/chat_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource chatRemoteDatasource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({
    required this.chatRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Chat>> getChat(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChat = await chatRemoteDatasource.getChat(id);
        final remoteChatEntity = remoteChat.toModel();
        return Right(remoteChatEntity);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
