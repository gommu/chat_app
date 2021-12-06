import 'dart:convert';

import 'package:chat_app/core/errors/exceptions.dart';
import 'package:chat_app/data/models/chat_preview_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChatsListLocalDatasource {
  Future<List<ChatPreviewModel>> getLastChatsList();

  Future<void> cacheChatsList(List<ChatPreviewModel> chatsList);
}

const cachedChatsList = 'CACHED_CHATS_LIST';

class ChatsListLocalDatasourceImpl implements ChatsListLocalDatasource {
  final SharedPreferences sharedPreferences;

  ChatsListLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheChatsList(List<ChatPreviewModel> chatsList) {
    List<String> chats = chatsList.map((e) => json.encode(e.toJson())).toList();
    return sharedPreferences.setStringList(cachedChatsList, chats);
  }

  @override
  Future<List<ChatPreviewModel>> getLastChatsList() {
    final jsonStrings = sharedPreferences.getStringList(cachedChatsList);
    if (jsonStrings != null) {
      List<ChatPreviewModel> chatsList = jsonStrings
          .map((e) => ChatPreviewModel.fromJson(json.decode(e)))
          .toList();

      return Future.value(chatsList);
    } else {
      throw CacheException();
    }
  }
}
