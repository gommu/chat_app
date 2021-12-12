import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/domain/entities/chat.dart';
import 'package:chat_app/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetChat implements UseCase<Chat, Params> {
  final ChatRepository repository;

  GetChat({required this.repository});

  @override
  Future<Either<Failure, Chat>> call(Params params) async {
    return await repository.getChat(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params(this.id);

  @override
  List<Object?> get props => [id];

}