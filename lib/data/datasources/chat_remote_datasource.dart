import 'dart:convert';

import 'package:chat_app/core/errors/exceptions.dart';
import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/data/models/chat_preview_model.dart';
import 'package:chat_app/domain/entities/chat.dart';
import 'package:http/http.dart';

abstract class ChatRemoteDatasource {
  Future<ChatModel> getChat(int id);
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final Client client;

  ChatRemoteDatasourceImpl({required this.client});

  @override
  Future<ChatModel> getChat(int id) async {
    // final url = Uri.https('chatdemo.free.beeceptor.com', 'chat/$id');
    final url = Uri.https('demo2866250.mockable.io', 'chat/$id');
    // final url = Uri.https('f946359e-5644-4bbf-bb27-2208a6561e3b.mock.pstmn.io', 'chats');
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var chatJson = json.decode(response.body);
      final chatModel = ChatModel.fromJson(chatJson);
      return chatModel;
    } else {
      throw ServerException();
    }
  }
}
