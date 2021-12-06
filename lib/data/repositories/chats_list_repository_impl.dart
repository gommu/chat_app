import 'package:chat_app/core/errors/exceptions.dart';
import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/core/network/network_info.dart';
import 'package:chat_app/data/datasources/chats_list_local_datasource.dart';
import 'package:chat_app/data/datasources/chats_list_remote_datasource.dart';
import 'package:chat_app/domain/entities/chat_preview.dart';
import 'package:chat_app/domain/repositories/chats_list_repository.dart';
import 'package:chat_app/data/models/chat_preview_model.dart';
import 'package:dartz/dartz.dart';

class ChatsListRepositoryImpl implements ChatsListRepository {
  final ChatsListRemoteDatasource chatsListRemoteDatasource;
  final ChatsListLocalDatasource chatsListLocalDatasource;
  final NetworkInfo networkInfo;

  ChatsListRepositoryImpl({
    required this.chatsListRemoteDatasource,
    required this.chatsListLocalDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ChatPreview>>> getChatsList() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChatsList = await chatsListRemoteDatasource.getChatsList();
        // chatsListLocalDatasource.cacheChatsList(remoteChatsList);
        final remoteChatsListEntities =
            remoteChatsList.map((e) => e.toModel()).toList();
        return Right(remoteChatsListEntities);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localChatsList =
            await chatsListLocalDatasource.getLastChatsList();
        final remoteChatsListEntities =
            localChatsList.map((e) => e.toModel()).toList();
        return Right(remoteChatsListEntities);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
