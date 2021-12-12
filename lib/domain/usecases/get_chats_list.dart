import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/domain/entities/chat_preview.dart';
import 'package:chat_app/domain/repositories/chats_list_repository.dart';
import 'package:dartz/dartz.dart';

class GetChatsList implements UseCase<List<ChatPreview>, NoParams> {
  final ChatsListRepository repository;

  GetChatsList({required this.repository});

  @override
  Future<Either<Failure, List<ChatPreview>>> call(NoParams params) async {
    return await repository.getChatsList();
  }
}
