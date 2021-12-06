import 'dart:convert';

import 'package:chat_app/core/errors/exceptions.dart';
import 'package:chat_app/data/models/chat_preview_model.dart';
import 'package:http/http.dart';

abstract class ChatsListRemoteDatasource {
  Future<List<ChatPreviewModel>> getChatsList();
}

class ChatsListRemoteDatasourceImpl implements ChatsListRemoteDatasource {
  final Client client;

  ChatsListRemoteDatasourceImpl({required this.client});

  @override
  Future<List<ChatPreviewModel>> getChatsList() async {
    final url = Uri.https('chatdemo.free.beeceptor.com', 'chats');
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var chatsJson = json.decode(response.body);
      final List<ChatPreviewModel> chatsList = List<ChatPreviewModel>.from(
          chatsJson.map((model) => ChatPreviewModel.fromJson(model)));
      return chatsList;
    } else {
      throw ServerException();
    }
  }
}
