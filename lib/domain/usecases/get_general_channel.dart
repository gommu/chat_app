import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/domain/entities/general_channel.dart';
import 'package:chat_app/domain/repositories/general_channel_repository.dart';
import 'package:dartz/dartz.dart';

class GetGeneralChannel implements UseCase<GeneralChannel, NoParams> {
  final GeneralChannelRepository repository;

  GetGeneralChannel({required this.repository});

  @override
  Future<Either<Failure, GeneralChannel>> call() async {
    return await repository.getGeneralChannel();
  }
}
