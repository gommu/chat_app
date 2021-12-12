import 'package:chat_app/core/network/network_info.dart';
import 'package:chat_app/data/datasources/chat_channel_ws_datasource.dart';
import 'package:chat_app/data/datasources/chat_remote_datasource.dart';
import 'package:chat_app/data/datasources/chats_list_local_datasource.dart';
import 'package:chat_app/data/datasources/chats_list_remote_datasource.dart';
import 'package:chat_app/data/datasources/general_channel_ws_datasource.dart';
import 'package:chat_app/data/repositories/chat_channel_repository_impl.dart';
import 'package:chat_app/data/repositories/chat_repository_impl.dart';
import 'package:chat_app/data/repositories/chats_list_repository_impl.dart';
import 'package:chat_app/data/repositories/general_channel_repository_impl.dart';
import 'package:chat_app/domain/repositories/chat_channel_repository.dart';
import 'package:chat_app/domain/repositories/chat_repository.dart';
import 'package:chat_app/domain/repositories/general_channel_repository.dart';
import 'package:chat_app/domain/usecases/get_chat.dart';
import 'package:chat_app/domain/usecases/get_chat_channel.dart';
import 'package:chat_app/domain/usecases/get_chats_list.dart';
import 'package:chat_app/domain/usecases/get_general_channel.dart';
import 'package:chat_app/presentation/cubit/chat/chat_cubit.dart';
import 'package:chat_app/presentation/cubit/chats_list/chats_list_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/repositories/chats_list_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerLazySingleton(() => ChatsListCubit(getChatsList: sl()));
  sl.registerFactory(() => ChatCubit(getChat: sl(), getChatChannel: sl()));

  // Use case
  sl.registerLazySingleton(() => GetChatsList(repository: sl()));
  sl.registerLazySingleton(() => GetChat(repository: sl()));
  sl.registerLazySingleton(() => GetGeneralChannel(repository: sl()));
  sl.registerLazySingleton(() => GetChatChannel(repository: sl()));

  // Repository
  sl.registerLazySingleton<ChatsListRepository>(() => ChatsListRepositoryImpl(
        chatsListRemoteDatasource: sl(),
        chatsListLocalDatasource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(
        chatRemoteDatasource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<GeneralChannelRepository>(
      () => GeneralChannelRepositoryImpl(
            generalChannelWsDatasource: sl(),
            networkInfo: sl(),
          ));
  sl.registerLazySingleton<ChatChannelRepository>(
      () => ChatChannelRepositoryImpl(
            chatChannelWsDatasource: sl(),
            networkInfo: sl(),
          ));

  // Data sources
  sl.registerLazySingleton<ChatsListRemoteDatasource>(
      () => ChatsListRemoteDatasourceImpl(client: sl()));
  sl.registerLazySingleton<ChatsListLocalDatasource>(
      () => ChatsListLocalDatasourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<ChatRemoteDatasource>(
          () => ChatRemoteDatasourceImpl(client: sl()));

  sl.registerLazySingleton<GeneralChannelWsDatasource>(
      () => GeneralChannelWsDatasourceImpl());
  sl.registerLazySingleton<ChatChannelWsDatasource>(
          () => ChatChannelWsDatasourceImpl());

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // External
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => DataConnectionChecker());
}
