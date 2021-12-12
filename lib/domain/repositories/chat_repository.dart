import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/domain/entities/chat.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either <Failure, Chat>> getChat(int id);
}