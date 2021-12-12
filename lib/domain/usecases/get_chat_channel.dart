import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/domain/entities/chat_channel.dart';
import 'package:chat_app/domain/repositories/chat_channel_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetChatChannel implements UseCase<ChatChannel, ChannelParams> {
  final ChatChannelRepository repository;

  GetChatChannel({required this.repository});

  @override
  Future<Either<Failure, ChatChannel>> call(ChannelParams params) async {
    return await repository.getChatChannel(params.url);
  }
}

class ChannelParams extends Equatable {
  final String url;

  const ChannelParams(this.url);

  @override
  List<Object?> get props => [url];

}