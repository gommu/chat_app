import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/domain/entities/general_channel.dart';
import 'package:dartz/dartz.dart';

abstract class GeneralChannelRepository {
  Future<Either <Failure, GeneralChannel>> getGeneralChannel();
}