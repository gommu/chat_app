import 'package:chat_app/core/errors/exceptions.dart';
import 'package:chat_app/core/errors/failures.dart';
import 'package:chat_app/data/datasources/general_channel_ws_datasource.dart';
import 'package:chat_app/domain/entities/general_channel.dart';
import 'package:chat_app/domain/repositories/general_channel_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/core/network/network_info.dart';

class GeneralChannelRepositoryImpl implements GeneralChannelRepository {
  final GeneralChannelWsDatasource generalChannelWsDatasource;
  final NetworkInfo networkInfo;

  GeneralChannelRepositoryImpl({
    required this.generalChannelWsDatasource,
    required this.networkInfo,
  });


  @override
  Future<Either <Failure, GeneralChannel>> getGeneralChannel() async {
    if (await networkInfo.isConnected) {
      try {
        final generalChannel = generalChannelWsDatasource.getGeneralChannel();
        return Right(generalChannel);
      } on WsException {
        return Left(WsFailure());
      }
    } else {
      return Left(WsFailure());
    }
  }
}