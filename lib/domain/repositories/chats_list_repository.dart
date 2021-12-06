import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/domain/entities/chat_preview.dart';
import 'package:dartz/dartz.dart';

abstract class ChatsListRepository {
  Future<Either <Failure, List<ChatPreview>>> getChatsList();
}