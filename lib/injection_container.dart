import 'package:chat_app/core/network/network_info.dart';
import 'package:chat_app/data/datasources/chats_list_local_datasource.dart';
import 'package:chat_app/data/datasources/chats_list_remote_datasource.dart';
import 'package:chat_app/data/repositories/chats_list_repository_impl.dart';
import 'package:chat_app/domain/usecases/get_chats_list.dart';
import 'package:chat_app/presentation/cubit/chats_list_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/repositories/chats_list_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(() => ChatsListCubit(getChatsList: sl()));

  // Use case
  sl.registerLazySingleton(() => GetChatsList(repository: sl()));

  // Repository
  sl.registerLazySingleton<ChatsListRepository>(() => ChatsListRepositoryImpl(
        chatsListRemoteDatasource: sl(),
        chatsListLocalDatasource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<ChatsListRemoteDatasource>(
      () => ChatsListRemoteDatasourceImpl(client: sl()));
  sl.registerLazySingleton<ChatsListLocalDatasource>(
      () => ChatsListLocalDatasourceImpl(sharedPreferences: sl()));
  
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // External
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => DataConnectionChecker());
}
